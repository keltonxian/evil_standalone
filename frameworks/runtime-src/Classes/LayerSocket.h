//
//  LayerSocket.h
//  EvilCard
//
//  Created by keltonxian on 7/24/14.
//
//

#ifndef __EvilCard__LayerSocket__
#define __EvilCard__LayerSocket__

#include "cocos2d.h"

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include "scripting\lua-bindings\manual\CCLuaValue.h"
#else
typedef int LUA_FUNCTION;
#endif

USING_NS_CC;


#pragma mark C declare start
int queue_init();
//int esocket_init(const char * ip_addr);
//int esocket_initdres(const char * ip);
//int esocket_send(const char *cmd);
//int esocket_dres(const char *filename);
void esocket_receive(const char * str);
int socket_close();
int get_sock();
void sock_close(int sock);
#pragma mark C declare end

class LayerSocket : public Layer {
public:
    static int initSocket(const char * ip_addr);
    static int initSocketRes(const char * ip);
    static int sendCmd(const char *cmd);
    static int recvCmd(const char * cmd);
    static int dlRes(const char *filename);
    void registerLuaNetHandler(LUA_FUNCTION handler);
    CREATE_FUNC(LayerSocket);
private:
    LayerSocket(void);
    virtual ~LayerSocket(void);
    virtual bool init();
    LUA_FUNCTION netHandler;
    virtual void update(float delta);
    void updateRecv(float dt);
    void updateSend(float dt);
};

#endif /* defined(__EvilCard__LayerSocket__) */
