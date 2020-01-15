//
//  KUtils.h
//  EvilCard
//
//  Created by keltonxian on 7/24/14.
//
//

#ifndef __EvilCard__KUtils__
#define __EvilCard__KUtils__

#include "cocos2d.h"

USING_NS_CC;

class KUtils : Ref {
public:
    static int createDirByPath(const char *path);
    static void deleteDownloadDir(std::string filePath);
    static void addSearchPath(std::string pathToSave, bool before);
    static std::string getResourcePath();
    static std::string getMD5(const std::string& strFilePath);
    static std::vector<std::string>& dfsFolder(const std::string& folderPath, int depth = 0);
    static bool unzipPatch(const std::string& srcPath, const std::string& dstPath);
    
};

#endif /* defined(__EvilCard__KUtils__) */
