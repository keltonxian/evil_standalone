#include "lua_evilclass_auto.hpp"
#include "KUtils.h"
#include "EvilSprite.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_evilclass_KUtils_createDirByPath(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp); arg0 = arg0_tmp.c_str();
        if(!ok)
            return 0;
        int ret = KUtils::createDirByPath(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "createDirByPath",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_createDirByPath'.",&tolua_err);
#endif
    return 0;
}
int lua_evilclass_KUtils_unzipPatch(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        std::string arg0;
        std::string arg1;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        ok &= luaval_to_std_string(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        bool ret = KUtils::unzipPatch(arg0, arg1);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "unzipPatch",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_unzipPatch'.",&tolua_err);
#endif
    return 0;
}
int lua_evilclass_KUtils_getMD5(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        std::string ret = KUtils::getMD5(arg0);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getMD5",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_getMD5'.",&tolua_err);
#endif
    return 0;
}
int lua_evilclass_KUtils_dfsFolder(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        std::vector<std::string>& ret = KUtils::dfsFolder(arg0);
        ccvector_std_string_to_luaval(tolua_S, ret);
        return 1;
    }
    if (argc == 2)
    {
        std::string arg0;
        int arg1;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1);
        if(!ok)
            return 0;
        std::vector<std::string>& ret = KUtils::dfsFolder(arg0, arg1);
        ccvector_std_string_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "dfsFolder",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_dfsFolder'.",&tolua_err);
#endif
    return 0;
}
int lua_evilclass_KUtils_deleteDownloadDir(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        KUtils::deleteDownloadDir(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "deleteDownloadDir",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_deleteDownloadDir'.",&tolua_err);
#endif
    return 0;
}
int lua_evilclass_KUtils_getResourcePath(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        std::string ret = KUtils::getResourcePath();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getResourcePath",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_getResourcePath'.",&tolua_err);
#endif
    return 0;
}
int lua_evilclass_KUtils_addSearchPath(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"KUtils",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        std::string arg0;
        bool arg1;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        ok &= luaval_to_boolean(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        KUtils::addSearchPath(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "addSearchPath",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_KUtils_addSearchPath'.",&tolua_err);
#endif
    return 0;
}
static int lua_evilclass_KUtils_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (KUtils)");
    return 0;
}

int lua_register_evilclass_KUtils(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"KUtils");
    tolua_cclass(tolua_S,"KUtils","KUtils","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"KUtils");
        tolua_function(tolua_S,"createDirByPath", lua_evilclass_KUtils_createDirByPath);
        tolua_function(tolua_S,"unzipPatch", lua_evilclass_KUtils_unzipPatch);
        tolua_function(tolua_S,"getMD5", lua_evilclass_KUtils_getMD5);
        tolua_function(tolua_S,"dfsFolder", lua_evilclass_KUtils_dfsFolder);
        tolua_function(tolua_S,"deleteDownloadDir", lua_evilclass_KUtils_deleteDownloadDir);
        tolua_function(tolua_S,"getResourcePath", lua_evilclass_KUtils_getResourcePath);
        tolua_function(tolua_S,"addSearchPath", lua_evilclass_KUtils_addSearchPath);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(KUtils).name();
    g_luaType[typeName] = "KUtils";
    g_typeCast["KUtils"] = "KUtils";
    return 1;
}

int lua_evilclass_EvilSprite_shake(lua_State* tolua_S)
{
    int argc = 0;
    EvilSprite* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"EvilSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (EvilSprite*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_evilclass_EvilSprite_shake'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 3) 
    {
        double arg0;
        double arg1;
        double arg2;

        ok &= luaval_to_number(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        cobj->shake(arg0, arg1, arg2);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "shake",argc, 3);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_EvilSprite_shake'.",&tolua_err);
#endif

    return 0;
}
int lua_evilclass_EvilSprite_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"EvilSprite",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        EvilSprite* ret = EvilSprite::create(arg0);
        object_to_luaval<EvilSprite>(tolua_S, "EvilSprite",(EvilSprite*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_evilclass_EvilSprite_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_evilclass_EvilSprite_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (EvilSprite)");
    return 0;
}

int lua_register_evilclass_EvilSprite(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"EvilSprite");
    tolua_cclass(tolua_S,"EvilSprite","EvilSprite","cc.Sprite",nullptr);

    tolua_beginmodule(tolua_S,"EvilSprite");
        tolua_function(tolua_S,"shake",lua_evilclass_EvilSprite_shake);
        tolua_function(tolua_S,"create", lua_evilclass_EvilSprite_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(EvilSprite).name();
    g_luaType[typeName] = "EvilSprite";
    g_typeCast["EvilSprite"] = "EvilSprite";
    return 1;
}
TOLUA_API int register_all_evilclass(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_evilclass_KUtils(tolua_S);
	lua_register_evilclass_EvilSprite(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

