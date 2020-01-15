#include "lua_layersocket_auto.hpp"
#include "LayerSocket.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



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
int lua_layersocket_LayerSocket_recvCmd(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
        if(!ok)
            return 0;
        int ret = LayerSocket::recvCmd(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "recvCmd",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_recvCmd'.",&tolua_err);
#endif
    return 0;
}
int lua_layersocket_LayerSocket_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        LayerSocket* ret = LayerSocket::create();
        object_to_luaval<LayerSocket>(tolua_S, "LayerSocket",(LayerSocket*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_create'.",&tolua_err);
#endif
    return 0;
}
int lua_layersocket_LayerSocket_sendCmd(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
        if(!ok)
            return 0;
        int ret = LayerSocket::sendCmd(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "sendCmd",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_sendCmd'.",&tolua_err);
#endif
    return 0;
}
int lua_layersocket_LayerSocket_dlRes(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
        if(!ok)
            return 0;
        int ret = LayerSocket::dlRes(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "dlRes",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_dlRes'.",&tolua_err);
#endif
    return 0;
}
int lua_layersocket_LayerSocket_initSocket(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
        if(!ok)
            return 0;
        int ret = LayerSocket::initSocket(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "initSocket",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_initSocket'.",&tolua_err);
#endif
    return 0;
}
int lua_layersocket_LayerSocket_initSocketRes(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"LayerSocket",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
        if(!ok)
            return 0;
        int ret = LayerSocket::initSocketRes(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "initSocketRes",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_layersocket_LayerSocket_initSocketRes'.",&tolua_err);
#endif
    return 0;
}
static int lua_layersocket_LayerSocket_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (LayerSocket)");
    return 0;
}

int lua_register_layersocket_LayerSocket(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"LayerSocket");
    tolua_cclass(tolua_S,"LayerSocket","LayerSocket","cc.Layer",nullptr);

    tolua_beginmodule(tolua_S,"LayerSocket");
        tolua_function(tolua_S,"registerLuaNetHandler",lua_layersocket_LayerSocket_registerLuaNetHandler);
        tolua_function(tolua_S,"recvCmd", lua_layersocket_LayerSocket_recvCmd);
        tolua_function(tolua_S,"create", lua_layersocket_LayerSocket_create);
        tolua_function(tolua_S,"sendCmd", lua_layersocket_LayerSocket_sendCmd);
        tolua_function(tolua_S,"dlRes", lua_layersocket_LayerSocket_dlRes);
        tolua_function(tolua_S,"initSocket", lua_layersocket_LayerSocket_initSocket);
        tolua_function(tolua_S,"initSocketRes", lua_layersocket_LayerSocket_initSocketRes);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(LayerSocket).name();
    g_luaType[typeName] = "LayerSocket";
    g_typeCast["LayerSocket"] = "LayerSocket";
    return 1;
}
TOLUA_API int register_all_layersocket(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_layersocket_LayerSocket(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

