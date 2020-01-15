//
//  LayerSocket.cpp
//  EvilCard
//
//  Created by keltonxian on 7/24/14.
//
//

/**
 kelton : lua_layersocket_auto.cpp中需要手动改，如下
 int lua_layersocket_LayerSocket_registerLuaNetHandler(lua_State* tolua_S)
 {
 int argc = 0;
 LayerSocket* cobj = nullptr;
 //    bool ok  = true;
 
 #if COCOS2D_DEBUG >= 1
 tolua_Error tolua_err;
 #endif
 
 
 #if COCOS2D_DEBUG >= 1
 if (!tolua_isusertype(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
 #endif
 
 cobj = (LayerSocket*)tolua_tousertype(tolua_S,1,0);
 
 #if COCOS2D_DEBUG >= 1
 if (!cobj)
 {
 tolua_error(tolua_S,"invalid 'cobj' in function 'lua_layersocket_LayerSocket_registerLuaNetHandler'", nullptr);
 return 0;
 }
 #endif
 
 argc = lua_gettop(tolua_S)-1;
 if (argc == 1)
 {
 LUA_FUNCTION arg0 = toluafix_ref_function(tolua_S,2,0);
 //        int arg0;
 //
 //        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
 //        if(!ok)
 //            return 0;
 cobj->registerLuaNetHandler(arg0);
 return 0;
 }
 CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "registerLuaNetHandler",argc, 1);
 return 0;
 
 #if COCOS2D_DEBUG >= 1
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_registerLuaNetHandler'.",&tolua_err);
 #endif
 
 return 0;
 }
 */

#include "LayerSocket.h"

extern "C" {
#include <sys/types.h>
#include <string.h>
#include <stdio.h>
#include <thread>
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include <WinSock2.h>
#include <io.h>
// win32 compatible mapping
#define strtok_r strtok_s
#define read _read
#define write _write
#define close closesocket
#define unlink _unlink
typedef int socklen_t;
#else
#include <sys/select.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/tcp.h>
#include <sys/ioctl.h>
#include <unistd.h>
#endif
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
    
#include "lua.h"
    
#include "str_queue.h"
}

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
#include "curl/include/ios/curl/curl.h"
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#include "curl/include/android/curl/curl.h"
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include "../../../../external/curl/include/win32/curl/curl.h"
#endif

#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
#include <dirent.h>
#include <sys/stat.h>
#endif

#include "CCLuaEngine.h"

#define BUFFER_SIZE 	MAX_STR_LEN+1//2000 //500

QUEUE_T g_recv;
QUEUE_T g_send;
QUEUE_T g_res;

#pragma mark ===== C start =====
int trim(char * str, size_t _len)
{
    if (_len <= 0) {
        _len = strlen(str);
    }
    
    int len = (int)_len;
    
    int i;
    for (i=len-1; i>=0; i--) {
        if (str[i]=='\r' || str[i]=='\n' || str[i]==' ')  {
            str[i] = 0;  // null it
            len --;
        } else {
            return len;
        }
    }
    return len;
}

int queue_init()
{
    str_queue_init(&g_recv);
    str_queue_init(&g_send);
    str_queue_init(&g_res);
    return 0;
}

void esocket_receive(const char * str) {
    str_queue_add(&g_recv, str);
}

// usage:
// char *token[9];
// char str[100];   strcpy(str, "hello 222 33 44 55 66 77 88 99");
// int total;
//
// total = split9(token, str);
// printf(" %s  | %s  \n", token[0], token[1]);
int split9(char** tok, char *str)
{
    static const char sep[] = " "; // can be more than 1
    int i;
    
    tok[0] = strtok(str, sep);
    if (tok[0]==NULL) {
        return 0;
    }
    
    i = 1;
    for (i=1; i<9; i++) {
        tok[i]=strtok(NULL, sep);
        if (tok[i]==NULL) {
            return i;
        }
    }
    return i;
}

/*
 * Open a TCP socket
 * return < 0 for error
 *
 */
int open_tcp_sock()
{
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);
    // after timeout , sock init will return 0 in first time
    // need to retry one time to get a real sock
    if (sock == 0) {
        printf("open_tcp_sock retry\n");
        sock = socket(AF_INET, SOCK_STREAM, 0);
    }
    return sock;
}

/*
 * This function creates a IP style address (struct sockaddr_in).
 * It accepts 2 parameters:
 * 1) [char *addr], ip_addr or domain name
 * 2) [int port], the port number associate with the address,
 *    e.g. port = 97
 *
 */
struct sockaddr_in prepare_addr(const char *addr, int port)
{
    struct sockaddr_in sin;
    memset(&sin, 0, sizeof(sin));
    sin.sin_family	= AF_INET;
    sin.sin_port		= htons(port);
    
    int ip = inet_addr(addr);
    if (ip==-1)
    {
        struct hostent *hent;
        hent = gethostbyname(addr);
        if (hent==NULL) {
            // printf("ERROR prepare_addr: gethostbyname fail\n");
            ip = 0xffffffff; //ip = -1;
        } else {
            ip = *(int *)(hent->h_addr_list[0]);
        }
        printf("DEBUG prepare_addr: resolve ip=%d.%d.%d.%d\n", ip & 0xff
               , (ip >> 8) & 0xff, (ip >> 16) & 0xff, (ip >> 24) & 0xff);
    }
    
    sin.sin_addr.s_addr	= ip; // inet_addr(addr);
    return sin;
}

//void* select_function(void* v)
void select_function(int sock)
{
    //	static char SEP[] = "\n";
    const char *SEP = "\r\n";
//	int sock = (int) (long)v;
	int max_fd;
	int running = 1;
	int ret;
	fd_set fdset;
	char buffer[BUFFER_SIZE+1];
    char last_buffer[BUFFER_SIZE + 1];
    last_buffer[0] = 0;
    
	max_fd = sock + 1;
	while (running) {
		FD_ZERO(&fdset);
		FD_SET(sock, &fdset);
        //		CCLOG("<<<<< before select");
		ret = select(max_fd, &fdset, NULL, NULL, NULL);
        //		CCLOG(">>>>> after select ret=%d", ret);
		if (ret == 0) {
			continue;  // continue to sleep and wait for incoming data
		}
		if (ret < 0) {
			printf("BUG  select ret %d\n", ret);
			running = 0;
			break;
		}
        
		// implicit: ret >= 1
        if (FD_ISSET(sock, &fdset) <= 0) {
            continue;
        }
        int len = (int)strlen(last_buffer);
        strcpy(buffer, last_buffer);
        last_buffer[0] = 0;
        ret = (int)recv(sock, buffer+len, BUFFER_SIZE-len, 0);
        if (ret < 0 && errno == EAGAIN) continue;
        if (ret <= 0) {
            int err = errno;
            printf("sock err or closed, exit ret[%d] errorno[%d]\n", ret, err);
            socket_close();// close and set g_sock = 0
            //TODO need to retry init socket
            char str[BUFFER_SIZE];
            sprintf(str, "reconn %d %d %s", ret, err, buffer);
            esocket_receive(str);
            break;
        }
        
        ret += len;
        buffer[ret] = 0; // null terminate the buffer (make it string)
        
        // save the last string without '\n' to last_buffer
        // and remove the last string from buffer
        if ('\n' != buffer[ret-1]) {
            char *ptr = strrchr(buffer, '\n');
            if (NULL != ptr) {
                strcpy(last_buffer, ptr + 1);
                *ptr = 0;
            } else {
                strcpy(last_buffer, buffer);
                //                CCLOG("last buff ret[%d]  buffer[%s],",ret , buffer);
                buffer[0] = 0;
            }
            //            CCLOG("   ptr[%s],last_buffer[%s]", ptr, last_buffer);
        }
//                CCLOG("select buffer[%s]", buffer);
        
        char *context;
        char *tok;
        tok = strtok_r(buffer, SEP, &context);
        //        tok = strtok(buffer, SEP);
        while (tok != NULL) {
            //				printf("TOK: [%s]\n", tok);
            //            trim(tok, strlen(tok));
//                            CCLOG("TOK: [%s]", tok);
            
            esocket_receive((const char*)tok);
            
            tok = strtok_r(NULL, SEP, &context);
            //            tok = strtok(NULL, SEP); // this must be last
        }
	}
    printf("select thread died\n");
//    pthread_exit(NULL);
}

size_t write_data(char *ptr, size_t size, size_t nmemb, void *userdata)
{
	FILE *fp = (FILE *)userdata;
	size_t written;
	if (fp == NULL) {
		printf("ERROR write_data fp_NULL");
		return 0;
	}
	written = fwrite(ptr, size, nmemb, fp);
	return written;
}

void res_function(std::vector<std::string> *array)
{
	int running = 1;
//	int ret;
	CURL *curl;
	FILE *fp;
	char *file;
	char url[200];
	curl_global_init(CURL_GLOBAL_NOTHING);
    
    const char *ip = (*array).at(0).c_str();
    const char *savePath = (*array).at(1).c_str();
    CCLOG("DEBUG res_function ip[%s]path[%s]", ip, savePath);
	while (running) {
//		long lv;
		int status = 0;
		file = str_queue_get_wait(&g_res);
        CCLOG("===res_function====>>file:[%s]", file);
        
        trim(file, strlen(file));
        //		sprintf(full_file, "%s%s", pathToSave.c_str(), file);
        char full_file[200];
		sprintf(full_file, "%stemp_%s", savePath, file);
        //		CCLOG("curl:full_file=[%s]\n", full_file);
        
		// TODO check null fp
        //        in Android, fopen cannot read file in resource because resource is in apk so must unzip the apk first
		fp = fopen(full_file, "wb");
		if (fp == NULL) {
			// callback(-5, file);
			char cmd[100];
			sprintf(cmd, "dres %d %s", -5, file);
            esocket_receive(cmd);
			continue;
		}
        
        //kelton : TODO
        // should download and set as temp file, change the name after download success
        
		curl = curl_easy_init();
        sprintf(url, "http://%s:7730/r/%s", ip, file);
		curl_easy_setopt(curl, CURLOPT_URL, url);
		curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);
		curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void*)fp);
//		curl_easy_perform(curl);
//        fclose(fp);
//        
//		ret = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &lv);
//        
//		char cmd[100];
//		if (lv == 404) {
//			unlink(full_file);
//			printf("curl:404 not found\n");
//			status = -3;
//        }
//        sprintf(cmd, "dres %d %s", status, file);
//		printf("DONE: %s\n", file);
//		curl_easy_cleanup(curl);
//        esocket_receive(cmd);
        
        CURLcode res;
        res = curl_easy_perform(curl);
        curl_easy_cleanup(curl);
        fclose(fp);
        char cmd[100];
        if (res != 0)
        {
            unlink(full_file);
            printf("curl:404 not found\n");
            status = -3;
            sprintf(cmd, "dres %d %s", status, file);
            esocket_receive(cmd);
            continue;
        }
        char full_file_in[200];
        sprintf(full_file_in, "%s%s", savePath, file);
        int rr = rename(full_file, full_file_in);
        if (0 != rr) {
            status = rr;
            sprintf(cmd, "dres %d %s", status, file);
            esocket_receive(cmd);
            continue;
        }
        sprintf(cmd, "dres %d %s", status, file);
        printf("DONE: %s\n", file);
        esocket_receive(cmd);
	}
    printf("curl_thread died\n");
}

void init_thread(int sock)
{
//	int ret;
//	static pthread_t select_thread;  // need static, else stack will be cleaned!
//	ret = pthread_create(&select_thread, NULL, select_function, (void *)(long)sock);

    std::thread t(select_function, sock);
    t.detach();
	//auto t = std::thread(&select_function, this);
    //t.detach();
}

// block = 1 means non_block, 0 means blocking
int set_nonblock(int sock, int block)
{
	int ret;
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
	u_long mode = block;
	ret = ioctlsocket(sock, FIONBIO, &mode);
#else
    // http://blog.csdn.net/chenguangf/article/details/2107302
	if (1 == block) { // on
//		ret = fcntl(sock, F_SETFL, flag | O_NONBLOCK);
		ret = fcntl(sock, F_SETFL, O_NONBLOCK);
	} else {// off
		ret = fcntl(sock, F_SETFL, 0);
	}
#endif
	return ret;
}

int init_sock( const char *ip, int port)
{
    int sock;
    sock = open_tcp_sock();
    
    if (sock <= 0) {
        CCLOG("ERROR init_sock %d  errno %d", sock, errno);
        return sock;
    }
    
    struct sockaddr_in addr;
    addr = prepare_addr(ip, port);
    // 0xffffffff == -1 domain can not be resolved
    if (addr.sin_addr.s_addr == 0xffffffff) {
        CCLOG("ERROR init_sock ip resolve error %s", ip);
        return -25;
    }
    int ret;
    
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    
    int flag;
    CCLOG("---- linux keepalive setup");
    // keepalive
    flag = 1;
    ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &flag, sizeof(int));
    flag = 8;  // was 8 [after 8 times retry socket will disconnect]
    ret = setsockopt(sock, SOL_TCP, TCP_KEEPCNT, &flag, sizeof(int));
    flag = 5;  // after 5 seconds of idle, start keepalive
    ret = setsockopt(sock, SOL_TCP, TCP_KEEPIDLE, &flag, sizeof(int));
    flag = 5;  // interval is 5 seconds
    ret = setsockopt(sock, SOL_TCP, TCP_KEEPINTVL, &flag, sizeof(int));
#endif
    
    ret = 1;
    ret = setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, (const char *)&ret, sizeof(ret));
    
    struct timeval timeout = {5, 0}; // was {3, 0}
    ret = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (const char *)&timeout, sizeof(timeout));
    if (ret < 0) {
        printf("ERROR setsockopt send timeout %d\n", errno);
    }
    timeout.tv_sec = 5;
    timeout.tv_usec = 0;
    ret = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char *)&timeout, sizeof(timeout));
    if (ret < 0) {
        printf("ERROR setsockopt receive timeout %d\n", errno);
    }
    ret = 1;
    ret = setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, (const char *)&ret, sizeof(int));
    if (ret < 0) {
        printf("ERROR setsockopt IPPROTO_TCP TCP_NODELAY %d\n", errno);
    }
    
    set_nonblock(sock, 1);
    
    ret = connect(sock, (struct sockaddr*)&addr, sizeof(addr));
    struct timeval conn_timeout;
    fd_set set;
    conn_timeout.tv_sec  = 5;
    conn_timeout.tv_usec = 0;
    FD_ZERO(&set);
    FD_SET(sock, &set);
    
    ret = select(sock+1, NULL, &set, NULL, &conn_timeout);
    printf("init_sock: select ret = %d, errno = %d, fdisset = %d\n", ret, errno, FD_ISSET(sock, &set));
    if (1 != ret) {
        char str[BUFFER_SIZE];
        sprintf(str, "ERROR connect fail [%d] errno %d", ret, errno);
        esocket_receive(str);
        sock_close(sock);
        return -5;
    }
    
    int err = 0;
    socklen_t len = 4;
    ret = getsockopt(sock, SOL_SOCKET, SO_ERROR, (char *)&err, &len);
    printf("init_sock: getsockopt ret[%d], err[%d], len[%d]\n", ret, err, len);
    if (ret < 0 || err != 0) {
        printf("ERROR init_sock getsockopt SO_ERROR ret[%d], err[%d]\n", ret, err);
        sock_close(sock);
        char str[BUFFER_SIZE];
        sprintf(str, "reconn ERROR init_sock getsockopt SO_ERROR ret[%d], err[%d]\n", ret, err);
        esocket_receive(str);
        return -15;
    }
    
	set_nonblock(sock, 0);
    
	// start a thread to do select and wait for read
	init_thread(sock);
	return sock;
}

static int g_sock = 0;

void sock_close(int sock)
{
	close(sock);
}

int get_sock()
{
    return g_sock;
}

int socket_close()
{
    sock_close(g_sock);
    g_sock = 0;
    return g_sock;
}
#pragma mark ===== C end   =====

#pragma mark ===== LayerSocket start =====
int LayerSocket::initSocket(const char * ip_addr)
{
    //    IP_ADDR = strndup(ip_addr, 20);
    //    return 1;
    printf("LayerSocket::initSocket ip_addr[%s] g_sock[%d]\n", ip_addr, g_sock);
    if (0 >= g_sock) {
        g_sock = init_sock(ip_addr, 7710);
    }
    printf("LayerSocket::initSocket %d\n", g_sock);
    
    return g_sock;
    
}

int LayerSocket::initSocketRes(const char * ip)
{
//    static pthread_t res_thread = NULL;
//    if (NULL != res_thread) {
//        CCLOG("DEBUG res_thread is already exist");
//        return 0;
//    }
    std::string pathToSave = FileUtils::getInstance()->getWritablePath();
    //    pathToSave += "evilres/res/";
    // Create the folder if it doesn't exist
#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
    DIR *pDir = NULL;
    
    pDir = opendir (pathToSave.c_str());
    if (! pDir)
    {
        mkdir(pathToSave.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
    }
#else
    if ((GetFileAttributesA(pathToSave.c_str())) == INVALID_FILE_ATTRIBUTES)
    {
        CreateDirectoryA(pathToSave.c_str(), 0);
    }
#endif
    CCLOG("DEBUG initSocketRes 1");
    std::string *s_ip = new std::string(ip);
    std::string *s_path = new std::string(pathToSave);
    std::vector<std::string> *array = new std::vector<std::string>();
    (*array).push_back(*s_ip);
    (*array).push_back(*s_path);
//    pthread_create(&res_thread, NULL, res_function, (void*)&array);
    //    pthread_create(&res_thread, NULL, res_function, (void*)ip);
    
    std::thread t(res_function, array);
    t.detach();
    return 0;
}

int LayerSocket::sendCmd(const char * cmd) {
    str_queue_add(&g_send, cmd);
    return 1;
}

int LayerSocket::recvCmd(const char * cmd) {
    str_queue_add(&g_recv, cmd);
    return 1;
}

int LayerSocket::dlRes(const char * filename) {
    CCLOG("DEBUG LayerSocket::dlRes 1");
    str_queue_add_signal(&g_res, filename);
    CCLOG("DEBUG LayerSocket::dlRes 2");
    return 1;
}

LayerSocket::LayerSocket(void)
{
    netHandler = -1;
}

LayerSocket::~LayerSocket(void)
{
    
}

bool LayerSocket::init()
{
    if ( !Layer::init()) {
        return false;
    }
    
    this->scheduleUpdate();
    return true;
}

void LayerSocket::registerLuaNetHandler(LUA_FUNCTION handler)
{
    this->netHandler = handler;
}

void LayerSocket::update(float delta)
{
    this->updateRecv(delta);
    this->updateSend(delta);
}

void LayerSocket::updateRecv(float dt)
{
    if (-1 == netHandler) {
        return;
    }
    // note: m_str is static C char array
    // TODO need a queue to get net receive, queue of string
    char * str = str_queue_get(&g_recv);
    
    if (NULL == str) {
        return;
    }
    //    std::string cmd(str);
    //    this->getEventDispatcher()->dispatchCustomEvent("net_handler", &cmd);
    auto engine = LuaEngine::getInstance();
    auto stack = engine->getLuaStack();
    stack->pushString(str);
    stack->executeFunctionByHandler(this->netHandler, 1);
    free(str);
}

void LayerSocket::updateSend(float dt)
{
    char * str = str_queue_get(&g_send);
    if (NULL == str) {
        return;
    }
    
    size_t len;
    size_t ret;
    len = strlen(str);
    if (len <= 0) {
        free(str);
        return ; // early exit for empty cmd
    }
//    ret = write(g_sock, str, len); // peter: write -> send in Win32
	ret = send(g_sock, str, len, 0);
    //    CCLOG("esocket_send len=%d  ret=%d  %s", len, ret, str);
    
    // this is a fatal error, ret<=0 is disconnect  TODO
    // ret < len (and ret > 0) :  need retry, but it is rare!
    if (ret <= 0 || ret < len) {
        //        CCLOG("ERROR evil_sock_send  ret %d  len %d", ret, len);
        char str[BUFFER_SIZE];
        sprintf(str, "reconn ERROR evil_sock_send  ret %zu  len %zu", ret, len);
        esocket_receive(str);
    }
    
    free(str);
    return;
}
#pragma mark ===== LayerSocket end =====
