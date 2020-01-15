//
//  KUtils.cpp
//  EvilCard
//
//  Created by keltonxian on 7/24/14.
//
//

#include "KUtils.h"

#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/stat.h>
#else
#include <io.h>
#endif

#include "../external/unzip/unzip.h"
#include "EvilPlatform.h"
#include "MD5Checksum.h"

int KUtils::createDirByPath(const char *path)
{
#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
    mode_t processMask = umask(0);
    int ret = mkdir(path, S_IRWXU | S_IRWXG | S_IRWXO);
    umask(processMask);
    if (ret != 0 && (errno != EEXIST))
    {
        return -7;
    }
    
    return 0;
#else
    BOOL ret = CreateDirectoryA(path, nullptr);
    if (!ret && ERROR_ALREADY_EXISTS != GetLastError())
    {
        return -7;
    }
    return 0;
#endif
}

void KUtils::deleteDownloadDir(std::string filePath)
{
    if (remove(filePath.c_str()) != 0)
    {
        CCLOG("deleteDownloadDir can not remove file %s", filePath.c_str());
    }
//#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
//    std::string command = "rm -r ";
//    // Path may include space.
//    command += "\"" + pathToSave + "\"";
//    system(command.c_str());
//#else
//    std::string command = "rd /s /q ";
//    // Path may include space.
//    command += "\"" + pathToSave + "\"";
//    system(command.c_str());
//#endif

}

void KUtils::addSearchPath(std::string pathToSave, bool before)
{
    std::vector<std::string> searchPaths = FileUtils::getInstance()->getSearchPaths();
    if (before)
    {
        searchPaths.insert(searchPaths.begin(), pathToSave);
    }
    else
    {
        searchPaths.push_back(pathToSave);
    }
    
    FileUtils::getInstance()->setSearchPaths(searchPaths);
}

std::string KUtils::getResourcePath()
{
    std::string path = EvilPlatform::getResourcePath();
    return path;
}

std::string KUtils::getMD5(const std::string& strFilePath)
{
    return MD5Checksum::GetMD5(strFilePath);
}

std::vector<std::string>& KUtils::dfsFolder(const std::string& folderPath, int depth)
{
    static std::vector<std::string> list;
    if (0 == depth) {
        list.clear();
    }
#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
    DIR *dp;
    struct dirent *entry;
    struct stat statbuf;
    if((dp = opendir(folderPath.c_str())) == NULL) {
//        fprintf(stderr,"cannot open directory: %s\n", folderPath.c_str());
        CCLOG("KUtils::dfsFolder cannot open directory: %s", folderPath.c_str());
        return list;
    }
//    CCLOG("opendir[%s] done", folderPath.c_str());
    chdir(folderPath.c_str());
    if ((entry = readdir(dp)) == NULL) {
        CCLOG("null");
    }
    while((entry = readdir(dp)) != NULL) {
        lstat(entry->d_name,&statbuf);
        if(S_ISDIR(statbuf.st_mode)) {
            if(strcmp(".",entry->d_name) == 0 || strcmp("..",entry->d_name) == 0)
                continue;
//            printf("%*s%s/\n",depth,"",entry->d_name);
//            std::string retName(entry->d_name);
//            list.push_back(retName);
//            printf("%s\n", retName.c_str());
//            std::vector<std::string> subList = dfsFolder(entry->d_name,depth+4);
//            list.insert(list.end(), subList.begin(), subList.end());
            dfsFolder(entry->d_name,depth+4);
        } else {
//            printf("%*s%s\n",depth,"",entry->d_name);
//            std::string retName(entry->d_name);
            list.push_back(entry->d_name);
//            printf("%s\n", retName.c_str());
        }
    }
    chdir("..");
    closedir(dp);
#else
    _finddata_t FileInfo;
    std::string strfind;
	strfind += folderPath + "\\*";
    long Handle = _findfirst(strfind.c_str(), &FileInfo);
    

    if (Handle == -1L)
    {
        CCLOG("KUtils:dfs cannot match folder path");
		return list;
    }

	// 5000 is the epoch
	for (int i=0; i<5000; i++) {
        //判断是否有子目录
        if (FileInfo.attrib & _A_SUBDIR)
        {
            //这个语句很重要, it is a bug:  
            if( (strcmp(FileInfo.name,".") != 0 ) &&(strcmp(FileInfo.name,"..") != 0))
            {
                std::string newPath = folderPath + "\\" + FileInfo.name;
				// CCLOG("dfs:sub_dir: newPath=%s fileinfo.name=[%s]", newPath.c_str(), FileInfo.name);
                // dfsFolder(newPath, depth+4);  // peter temp remove
            }
        }
        else
        {
            std::string filename = (folderPath + "\\" + FileInfo.name);
            CCLOG("KUtils:dfs folderPath %s",  FileInfo.name);
            list.push_back(FileInfo.name);
        }
		if (0 != _findnext(Handle, &FileInfo)) {
			break;
		}
	}
    
    _findclose(Handle);
#endif
    return list;
}

bool KUtils::unzipPatch(const std::string& srcPath, const std::string& dstPath)
{
    // Open the zip file
    unzFile zipfile = unzOpen(srcPath.c_str());
    if (! zipfile)
    {
        CCLOG("can not open downloaded zip file %s", srcPath.c_str());
        return false;
    }
    
    // Get info about the zip file
    unz_global_info global_info;
    if (unzGetGlobalInfo(zipfile, &global_info) != UNZ_OK)
    {
        CCLOG("can not read file global info of %s", srcPath.c_str());
        unzClose(zipfile);
        return false;
    }
    
    // Buffer to hold data read from the zip file
//#define TEMP_PACKAGE_FILE_NAME    "cocos2dx-update-temp-package.zip"
//#define BUFFER_SIZE    8192
//#define MAX_FILENAME   512
    const int bufferSize = 8192;
    const int maxFileName = 512;
    char readBuffer[bufferSize];
    
    CCLOG("start uncompressing");
    
    // Loop to extract all files.
    uLong i;
    for (i = 0; i < global_info.number_entry; ++i)
    {
        // Get info about current file.
        unz_file_info fileInfo;
        char fileName[maxFileName];
        if (unzGetCurrentFileInfo(zipfile,
                                  &fileInfo,
                                  fileName,
                                  maxFileName,
                                  nullptr,
                                  0,
                                  nullptr,
                                  0) != UNZ_OK)
        {
            CCLOG("can not read file info");
            unzClose(zipfile);
            return false;
        }
        
//        CCLOG("fileName:[%s]", fileName);
        const std::string fullPath = dstPath + fileName;
        
        // Check if this entry is a directory or a file.
        const size_t filenameLength = strlen(fileName);
        if (fileName[filenameLength-1] == '/')
        {
            // Entry is a direcotry, so create it.
            // If the directory exists, it will failed scilently.
            if (0 != KUtils::createDirByPath(fullPath.c_str()))
            {
                CCLOG("can not create directory %s", fullPath.c_str());
                unzClose(zipfile);
                return false;
            }
        }
        else
        {
            //There are not directory entry in some case.
            //So we need to test whether the file directory exists when uncompressing file entry
            //, if does not exist then create directory
            const std::string fileNameStr(fileName);
            
            size_t startIndex=0;
            
            size_t index=fileNameStr.find("/",startIndex);
            
            while(index != std::string::npos)
            {
                const std::string dir=dstPath+fileNameStr.substr(0,index);
                
                FILE *out = fopen(dir.c_str(), "r");
                
                if(!out)
                {
                    if (0 != KUtils::createDirByPath(dir.c_str()))
                    {
                        CCLOG("can not create directory %s", dir.c_str());
                        unzClose(zipfile);
                        return false;
                    }
                    else
                    {
                        CCLOG("create directory %s",dir.c_str());
                    }
                }
                else
                {
                    fclose(out);
                }
                
                startIndex=index+1;
                
                index=fileNameStr.find("/",startIndex);
                
            }
            
            
            
            // Entry is a file, so extract it.
            
            // Open current file.
            if (unzOpenCurrentFile(zipfile) != UNZ_OK)
            {
                CCLOG("can not open file %s", fileName);
                unzClose(zipfile);
                return false;
            }
            
            // Create a file to store current file.
            FILE *out = fopen(fullPath.c_str(), "wb");
            if (! out)
            {
                CCLOG("can not open destination file %s", fullPath.c_str());
                unzCloseCurrentFile(zipfile);
                unzClose(zipfile);
                return false;
            }
            
            // Write current file content to destinate file.
            int error = UNZ_OK;
            do
            {
                error = unzReadCurrentFile(zipfile, readBuffer, bufferSize);
                if (error < 0)
                {
                    CCLOG("can not read zip file %s, error code is %d", fileName, error);
                    unzCloseCurrentFile(zipfile);
                    unzClose(zipfile);
                    return false;
                }
                
                if (error > 0)
                {
                    fwrite(readBuffer, error, 1, out);
                }
            } while(error > 0);
            
            fclose(out);
        }
        
        unzCloseCurrentFile(zipfile);
        
        // Goto next entry listed in the zip file.
        if ((i+1) < global_info.number_entry)
        {
            if (unzGoToNextFile(zipfile) != UNZ_OK)
            {
                CCLOG("can not read next file");
                unzClose(zipfile);
                return false;
            }
        }
    }
    
    CCLOG("end uncompressing");
    unzClose(zipfile);
    
    return true;
}



