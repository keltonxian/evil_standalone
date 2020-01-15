#include "lua_dragonbones_auto.hpp"
#include "DBCCEventDispatcher.h"
#include "DBCCArmature.h"
#include "DBCCSlot.h"
#include "DBCCFactory.h"
#include "DBCCTextureAtlas.h"
#include "DBCCArmatureNode.h"
#include "DBCCRenderHeaders.h"
#include "dbccMacro.h"
#include "Animation.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_dragonbones_Animation_getAnimationList(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getAnimationList'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        const std::vector<std::string>& ret = cobj->getAnimationList();
        ccvector_std_string_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getAnimationList",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getAnimationList'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_setTimeScale(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_setTimeScale'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->setTimeScale(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setTimeScale",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_setTimeScale'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_stop(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_stop'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->stop();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "stop",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_stop'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_clear(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_clear'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->clear();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "clear",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_clear'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_dispose(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_dispose'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->dispose();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "dispose",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_dispose'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_play(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_play'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->play();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "play",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_play'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_hasAnimation(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_hasAnimation'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        bool ret = cobj->hasAnimation(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "hasAnimation",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_hasAnimation'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_getLastAnimationState(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getLastAnimationState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->getLastAnimationState();
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getLastAnimationState",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getLastAnimationState'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_gotoAndPlay(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_gotoAndPlay'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 2) 
    {
        std::string arg0;
        double arg1;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 3) 
    {
        std::string arg0;
        double arg1;
        double arg2;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 4) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        int arg3;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2, arg3);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 5) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        int arg3;
        int arg4;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3);

        ok &= luaval_to_int32(tolua_S, 6,(int *)&arg4);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2, arg3, arg4);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 6) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        int arg3;
        int arg4;
        std::string arg5;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3);

        ok &= luaval_to_int32(tolua_S, 6,(int *)&arg4);

        ok &= luaval_to_std_string(tolua_S, 7,&arg5);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2, arg3, arg4, arg5);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 7) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        int arg3;
        int arg4;
        std::string arg5;
        dragonBones::Animation::AnimationFadeOutMode arg6;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3);

        ok &= luaval_to_int32(tolua_S, 6,(int *)&arg4);

        ok &= luaval_to_std_string(tolua_S, 7,&arg5);

        ok &= luaval_to_int32(tolua_S, 8,(int *)&arg6);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 8) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        int arg3;
        int arg4;
        std::string arg5;
        dragonBones::Animation::AnimationFadeOutMode arg6;
        bool arg7;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3);

        ok &= luaval_to_int32(tolua_S, 6,(int *)&arg4);

        ok &= luaval_to_std_string(tolua_S, 7,&arg5);

        ok &= luaval_to_int32(tolua_S, 8,(int *)&arg6);

        ok &= luaval_to_boolean(tolua_S, 9,&arg7);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 9) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        int arg3;
        int arg4;
        std::string arg5;
        dragonBones::Animation::AnimationFadeOutMode arg6;
        bool arg7;
        bool arg8;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3);

        ok &= luaval_to_int32(tolua_S, 6,(int *)&arg4);

        ok &= luaval_to_std_string(tolua_S, 7,&arg5);

        ok &= luaval_to_int32(tolua_S, 8,(int *)&arg6);

        ok &= luaval_to_boolean(tolua_S, 9,&arg7);

        ok &= luaval_to_boolean(tolua_S, 10,&arg8);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndPlay(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "gotoAndPlay",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_gotoAndPlay'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_getState(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->getState(arg0);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
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
        dragonBones::AnimationState* ret = cobj->getState(arg0, arg1);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getState",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getState'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_getIsComplete(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getIsComplete'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        bool ret = cobj->getIsComplete();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getIsComplete",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getIsComplete'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_getAnimationDataList(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getAnimationDataList'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        //kelton
//        const std::vector<dragonBones::AnimationData *, std::allocator<dragonBones::AnimationData *> >& ret = cobj->getAnimationDataList();
//        object_to_luaval<std::vector<dragonBones::AnimationData , std::allocator<dragonBones::AnimationData > >&>(tolua_S, "std::vector<dragonBones::AnimationData *, std::allocator<dragonBones::AnimationData *> >",(std::vector<dragonBones::AnimationData *, std::allocator<dragonBones::AnimationData *> >&)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getAnimationDataList",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getAnimationDataList'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_advanceTime(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_advanceTime'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->advanceTime(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "advanceTime",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_advanceTime'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_getIsPlaying(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getIsPlaying'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        bool ret = cobj->getIsPlaying();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getIsPlaying",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getIsPlaying'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_gotoAndStop(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_gotoAndStop'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        std::string arg0;
        double arg1;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 3) 
    {
        std::string arg0;
        double arg1;
        double arg2;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1, arg2);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 4) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        double arg3;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_number(tolua_S, 5,&arg3);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1, arg2, arg3);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 5) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        double arg3;
        double arg4;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_number(tolua_S, 5,&arg3);

        ok &= luaval_to_number(tolua_S, 6,&arg4);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1, arg2, arg3, arg4);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 6) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        double arg3;
        double arg4;
        int arg5;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_number(tolua_S, 5,&arg3);

        ok &= luaval_to_number(tolua_S, 6,&arg4);

        ok &= luaval_to_int32(tolua_S, 7,(int *)&arg5);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1, arg2, arg3, arg4, arg5);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 7) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        double arg3;
        double arg4;
        int arg5;
        std::string arg6;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_number(tolua_S, 5,&arg3);

        ok &= luaval_to_number(tolua_S, 6,&arg4);

        ok &= luaval_to_int32(tolua_S, 7,(int *)&arg5);

        ok &= luaval_to_std_string(tolua_S, 8,&arg6);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    if (argc == 8) 
    {
        std::string arg0;
        double arg1;
        double arg2;
        double arg3;
        double arg4;
        int arg5;
        std::string arg6;
        dragonBones::Animation::AnimationFadeOutMode arg7;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_number(tolua_S, 3,&arg1);

        ok &= luaval_to_number(tolua_S, 4,&arg2);

        ok &= luaval_to_number(tolua_S, 5,&arg3);

        ok &= luaval_to_number(tolua_S, 6,&arg4);

        ok &= luaval_to_int32(tolua_S, 7,(int *)&arg5);

        ok &= luaval_to_std_string(tolua_S, 8,&arg6);

        ok &= luaval_to_int32(tolua_S, 9,(int *)&arg7);
        if(!ok)
            return 0;
        dragonBones::AnimationState* ret = cobj->gotoAndStop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        object_to_luaval<dragonBones::AnimationState>(tolua_S, "dbs.AnimationState",(dragonBones::AnimationState*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "gotoAndStop",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_gotoAndStop'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_setAnimationDataList(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_setAnimationDataList'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::vector<dragonBones::AnimationData *, std::allocator<dragonBones::AnimationData *> > arg0;

        //kelton
//        ok &= luaval_to_object<std::vector<dragonBones::AnimationData , std::allocator<dragonBones::AnimationData > >>(tolua_S, 2, "std::vector<dragonBones::AnimationData *, std::allocator<dragonBones::AnimationData *> >",&arg0);
        if(!ok)
            return 0;
        cobj->setAnimationDataList(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setAnimationDataList",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_setAnimationDataList'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_getTimeScale(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.Animation",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::Animation*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_Animation_getTimeScale'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        double ret = cobj->getTimeScale();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getTimeScale",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_getTimeScale'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_Animation_constructor(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::Animation* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new dragonBones::Animation();
        tolua_pushusertype(tolua_S,(void*)cobj,"dbs.Animation");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "Animation",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_Animation_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_dragonbones_Animation_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Animation)");
    return 0;
}

int lua_register_dragonbones_Animation(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"dbs.Animation");
    tolua_cclass(tolua_S,"Animation","dbs.Animation","",nullptr);

    tolua_beginmodule(tolua_S,"Animation");
        tolua_function(tolua_S,"new",lua_dragonbones_Animation_constructor);
        tolua_function(tolua_S,"getAnimationList",lua_dragonbones_Animation_getAnimationList);
        tolua_function(tolua_S,"setTimeScale",lua_dragonbones_Animation_setTimeScale);
        tolua_function(tolua_S,"stop",lua_dragonbones_Animation_stop);
        tolua_function(tolua_S,"clear",lua_dragonbones_Animation_clear);
        tolua_function(tolua_S,"dispose",lua_dragonbones_Animation_dispose);
        tolua_function(tolua_S,"play",lua_dragonbones_Animation_play);
        tolua_function(tolua_S,"hasAnimation",lua_dragonbones_Animation_hasAnimation);
        tolua_function(tolua_S,"getLastAnimationState",lua_dragonbones_Animation_getLastAnimationState);
        tolua_function(tolua_S,"gotoAndPlay",lua_dragonbones_Animation_gotoAndPlay);
        tolua_function(tolua_S,"getState",lua_dragonbones_Animation_getState);
        tolua_function(tolua_S,"getIsComplete",lua_dragonbones_Animation_getIsComplete);
        tolua_function(tolua_S,"getAnimationDataList",lua_dragonbones_Animation_getAnimationDataList);
        tolua_function(tolua_S,"advanceTime",lua_dragonbones_Animation_advanceTime);
        tolua_function(tolua_S,"getIsPlaying",lua_dragonbones_Animation_getIsPlaying);
        tolua_function(tolua_S,"gotoAndStop",lua_dragonbones_Animation_gotoAndStop);
        tolua_function(tolua_S,"setAnimationDataList",lua_dragonbones_Animation_setAnimationDataList);
        tolua_function(tolua_S,"getTimeScale",lua_dragonbones_Animation_getTimeScale);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(dragonBones::Animation).name();
    g_luaType[typeName] = "dbs.Animation";
    g_typeCast["Animation"] = "dbs.Animation";
    return 1;
}

int lua_dragonbones_DBCCSlot_getGlobalPosition(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCSlot* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCSlot",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCSlot*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCSlot_getGlobalPosition'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Vec2 ret = cobj->getGlobalPosition();
        vec2_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getGlobalPosition",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCSlot_getGlobalPosition'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCSlot_getCCChildArmature(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCSlot* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCSlot",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCSlot*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCSlot_getCCChildArmature'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        dragonBones::DBCCArmature* ret = cobj->getCCChildArmature();
        object_to_luaval<dragonBones::DBCCArmature>(tolua_S, "dbs.DBCCArmature",(dragonBones::DBCCArmature*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCChildArmature",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCSlot_getCCChildArmature'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCSlot_getCCDisplay(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCSlot* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCSlot",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCSlot*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCSlot_getCCDisplay'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Node* ret = cobj->getCCDisplay();
        object_to_luaval<cocos2d::Node>(tolua_S, "cc.Node",(cocos2d::Node*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCDisplay",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCSlot_getCCDisplay'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCSlot_setDisplayImage(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCSlot* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCSlot",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCSlot*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCSlot_setDisplayImage'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        cocos2d::Node* arg0;

        ok &= luaval_to_object<cocos2d::Node>(tolua_S, 2, "cc.Node",&arg0);
        if(!ok)
            return 0;
        cobj->setDisplayImage(arg0);
        return 0;
    }
    if (argc == 2) 
    {
        cocos2d::Node* arg0;
        bool arg1;

        ok &= luaval_to_object<cocos2d::Node>(tolua_S, 2, "cc.Node",&arg0);

        ok &= luaval_to_boolean(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        cobj->setDisplayImage(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "setDisplayImage",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCSlot_setDisplayImage'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCSlot_constructor(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCSlot* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        dragonBones::SlotData* arg0;

        ok &= luaval_to_object<dragonBones::SlotData>(tolua_S, 2, "dbs.SlotData",&arg0);
        if(!ok)
            return 0;
        cobj = new dragonBones::DBCCSlot(arg0);
        tolua_pushusertype(tolua_S,(void*)cobj,"dbs.DBCCSlot");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "DBCCSlot",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCSlot_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_dragonbones_DBCCSlot_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (DBCCSlot)");
    return 0;
}

int lua_register_dragonbones_DBCCSlot(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"dbs.DBCCSlot");
    tolua_cclass(tolua_S,"DBCCSlot","dbs.DBCCSlot","dbs.Slot",nullptr);

    tolua_beginmodule(tolua_S,"DBCCSlot");
        tolua_function(tolua_S,"new",lua_dragonbones_DBCCSlot_constructor);
        tolua_function(tolua_S,"getGlobalPosition",lua_dragonbones_DBCCSlot_getGlobalPosition);
        tolua_function(tolua_S,"getCCChildArmature",lua_dragonbones_DBCCSlot_getCCChildArmature);
        tolua_function(tolua_S,"getCCDisplay",lua_dragonbones_DBCCSlot_getCCDisplay);
        tolua_function(tolua_S,"setDisplayImage",lua_dragonbones_DBCCSlot_setDisplayImage);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(dragonBones::DBCCSlot).name();
    g_luaType[typeName] = "dbs.DBCCSlot";
    g_typeCast["DBCCSlot"] = "dbs.DBCCSlot";
    return 1;
}

int lua_dragonbones_DBCCArmature_getCCEventDispatcher(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmature* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmature",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmature*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmature_getCCEventDispatcher'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::EventDispatcher* ret = cobj->getCCEventDispatcher();
        object_to_luaval<cocos2d::EventDispatcher>(tolua_S, "cc.EventDispatcher",(cocos2d::EventDispatcher*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCEventDispatcher",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmature_getCCEventDispatcher'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmature_getCCSlot(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmature* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmature",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmature*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmature_getCCSlot'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        dragonBones::DBCCSlot* ret = cobj->getCCSlot(arg0);
        object_to_luaval<dragonBones::DBCCSlot>(tolua_S, "dbs.DBCCSlot",(dragonBones::DBCCSlot*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCSlot",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmature_getCCSlot'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmature_getCCDisplay(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmature* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmature",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmature*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmature_getCCDisplay'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Node* ret = cobj->getCCDisplay();
        object_to_luaval<cocos2d::Node>(tolua_S, "cc.Node",(cocos2d::Node*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCDisplay",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmature_getCCDisplay'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmature_getCCBoundingBox(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmature* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmature",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmature*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmature_getCCBoundingBox'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Rect ret = cobj->getCCBoundingBox();
        rect_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCBoundingBox",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmature_getCCBoundingBox'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmature_constructor(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmature* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 4) 
    {
        dragonBones::ArmatureData* arg0;
        dragonBones::Animation* arg1;
        dragonBones::IEventDispatcher* arg2;
        cocos2d::Node* arg3;

        ok &= luaval_to_object<dragonBones::ArmatureData>(tolua_S, 2, "dbs.ArmatureData",&arg0);

        ok &= luaval_to_object<dragonBones::Animation>(tolua_S, 3, "dbs.Animation",&arg1);

        ok &= luaval_to_object<dragonBones::IEventDispatcher>(tolua_S, 4, "dbs.IEventDispatcher",&arg2);

        ok &= luaval_to_object<cocos2d::Node>(tolua_S, 5, "cc.Node",&arg3);
        if(!ok)
            return 0;
        cobj = new dragonBones::DBCCArmature(arg0, arg1, arg2, arg3);
        tolua_pushusertype(tolua_S,(void*)cobj,"dbs.DBCCArmature");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "DBCCArmature",argc, 4);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmature_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_dragonbones_DBCCArmature_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (DBCCArmature)");
    return 0;
}

int lua_register_dragonbones_DBCCArmature(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"dbs.DBCCArmature");
    tolua_cclass(tolua_S,"DBCCArmature","dbs.DBCCArmature","dbs.Armature",nullptr);

    tolua_beginmodule(tolua_S,"DBCCArmature");
        tolua_function(tolua_S,"new",lua_dragonbones_DBCCArmature_constructor);
        tolua_function(tolua_S,"getCCEventDispatcher",lua_dragonbones_DBCCArmature_getCCEventDispatcher);
        tolua_function(tolua_S,"getCCSlot",lua_dragonbones_DBCCArmature_getCCSlot);
        tolua_function(tolua_S,"getCCDisplay",lua_dragonbones_DBCCArmature_getCCDisplay);
        tolua_function(tolua_S,"getCCBoundingBox",lua_dragonbones_DBCCArmature_getCCBoundingBox);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(dragonBones::DBCCArmature).name();
    g_luaType[typeName] = "dbs.DBCCArmature";
    g_typeCast["DBCCArmature"] = "dbs.DBCCArmature";
    return 1;
}

int lua_dragonbones_DBCCTextureAtlas_reloadTexture(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCTextureAtlas* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCTextureAtlas",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCTextureAtlas*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCTextureAtlas_reloadTexture'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Texture2D* ret = cobj->reloadTexture();
        object_to_luaval<cocos2d::Texture2D>(tolua_S, "cc.Texture2D",(cocos2d::Texture2D*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "reloadTexture",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCTextureAtlas_reloadTexture'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCTextureAtlas_getTexture(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCTextureAtlas* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCTextureAtlas",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCTextureAtlas*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCTextureAtlas_getTexture'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Texture2D* ret = cobj->getTexture();
        object_to_luaval<cocos2d::Texture2D>(tolua_S, "cc.Texture2D",(cocos2d::Texture2D*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getTexture",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCTextureAtlas_getTexture'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCTextureAtlas_constructor(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCTextureAtlas* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new dragonBones::DBCCTextureAtlas();
        tolua_pushusertype(tolua_S,(void*)cobj,"dbs.DBCCTextureAtlas");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "DBCCTextureAtlas",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCTextureAtlas_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_dragonbones_DBCCTextureAtlas_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (DBCCTextureAtlas)");
    return 0;
}

int lua_register_dragonbones_DBCCTextureAtlas(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"dbs.DBCCTextureAtlas");
    tolua_cclass(tolua_S,"DBCCTextureAtlas","dbs.DBCCTextureAtlas","dbs.ITextureAtlas",nullptr);

    tolua_beginmodule(tolua_S,"DBCCTextureAtlas");
        tolua_function(tolua_S,"new",lua_dragonbones_DBCCTextureAtlas_constructor);
        tolua_function(tolua_S,"reloadTexture",lua_dragonbones_DBCCTextureAtlas_reloadTexture);
        tolua_function(tolua_S,"getTexture",lua_dragonbones_DBCCTextureAtlas_getTexture);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(dragonBones::DBCCTextureAtlas).name();
    g_luaType[typeName] = "dbs.DBCCTextureAtlas";
    g_typeCast["DBCCTextureAtlas"] = "dbs.DBCCTextureAtlas";
    return 1;
}

int lua_dragonbones_DBCCArmatureNode_getAnimation(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_getAnimation'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        dragonBones::Animation* ret = cobj->getAnimation();
        object_to_luaval<dragonBones::Animation>(tolua_S, "dbs.Animation",(dragonBones::Animation*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getAnimation",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_getAnimation'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_registerMovementEventHandler(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
//    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_registerMovementEventHandler'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        //kelton
//        int arg0;
//
//        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
//        if(!ok)
//            return 0;
        LUA_FUNCTION arg0 = toluafix_ref_function(tolua_S,2,0);
        cobj->registerMovementEventHandler(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "registerMovementEventHandler",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_registerMovementEventHandler'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_getCCEventDispatcher(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_getCCEventDispatcher'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::EventDispatcher* ret = cobj->getCCEventDispatcher();
        object_to_luaval<cocos2d::EventDispatcher>(tolua_S, "cc.EventDispatcher",(cocos2d::EventDispatcher*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCEventDispatcher",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_getCCEventDispatcher'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_registerFrameEventHandler(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_registerFrameEventHandler'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0);
        if(!ok)
            return 0;
        cobj->registerFrameEventHandler(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "registerFrameEventHandler",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_registerFrameEventHandler'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_getArmature(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_getArmature'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        dragonBones::DBCCArmature* ret = cobj->getArmature();
        object_to_luaval<dragonBones::DBCCArmature>(tolua_S, "dbs.DBCCArmature",(dragonBones::DBCCArmature*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getArmature",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_getArmature'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_unregisterMovementEventHandler(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_unregisterMovementEventHandler'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->unregisterMovementEventHandler();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "unregisterMovementEventHandler",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_unregisterMovementEventHandler'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_getCCSlot(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_getCCSlot'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        dragonBones::DBCCSlot* ret = cobj->getCCSlot(arg0);
        object_to_luaval<dragonBones::DBCCSlot>(tolua_S, "dbs.DBCCSlot",(dragonBones::DBCCSlot*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCSlot",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_getCCSlot'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_unregisterFrameEventHandler(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_unregisterFrameEventHandler'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->unregisterFrameEventHandler();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "unregisterFrameEventHandler",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_unregisterFrameEventHandler'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_initWithDBCCArmature(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_initWithDBCCArmature'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        dragonBones::DBCCArmature* arg0;
        dragonBones::WorldClock* arg1;

        ok &= luaval_to_object<dragonBones::DBCCArmature>(tolua_S, 2, "dbs.DBCCArmature",&arg0);

        ok &= luaval_to_object<dragonBones::WorldClock>(tolua_S, 3, "dbs.WorldClock",&arg1);
        if(!ok)
            return 0;
        bool ret = cobj->initWithDBCCArmature(arg0, arg1);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "initWithDBCCArmature",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_initWithDBCCArmature'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_getCCDisplay(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_getCCDisplay'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cocos2d::Node* ret = cobj->getCCDisplay();
        object_to_luaval<cocos2d::Node>(tolua_S, "cc.Node",(cocos2d::Node*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "getCCDisplay",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_getCCDisplay'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_advanceTime(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCArmatureNode*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCArmatureNode_advanceTime'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->advanceTime(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "advanceTime",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_advanceTime'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCArmatureNode_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        dragonBones::DBCCArmature* arg0;
        ok &= luaval_to_object<dragonBones::DBCCArmature>(tolua_S, 2, "dbs.DBCCArmature",&arg0);
        if(!ok)
            return 0;
        dragonBones::DBCCArmatureNode* ret = dragonBones::DBCCArmatureNode::create(arg0);
        object_to_luaval<dragonBones::DBCCArmatureNode>(tolua_S, "dbs.DBCCArmatureNode",(dragonBones::DBCCArmatureNode*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "create",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_create'.",&tolua_err);
#endif
    return 0;
}
int lua_dragonbones_DBCCArmatureNode_createWithWorldClock(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"dbs.DBCCArmatureNode",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        dragonBones::DBCCArmature* arg0;
        dragonBones::WorldClock* arg1;
        ok &= luaval_to_object<dragonBones::DBCCArmature>(tolua_S, 2, "dbs.DBCCArmature",&arg0);
        ok &= luaval_to_object<dragonBones::WorldClock>(tolua_S, 3, "dbs.WorldClock",&arg1);
        if(!ok)
            return 0;
        dragonBones::DBCCArmatureNode* ret = dragonBones::DBCCArmatureNode::createWithWorldClock(arg0, arg1);
        object_to_luaval<dragonBones::DBCCArmatureNode>(tolua_S, "dbs.DBCCArmatureNode",(dragonBones::DBCCArmatureNode*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "createWithWorldClock",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_createWithWorldClock'.",&tolua_err);
#endif
    return 0;
}
int lua_dragonbones_DBCCArmatureNode_constructor(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCArmatureNode* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new dragonBones::DBCCArmatureNode();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"dbs.DBCCArmatureNode");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "DBCCArmatureNode",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCArmatureNode_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_dragonbones_DBCCArmatureNode_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (DBCCArmatureNode)");
    return 0;
}

int lua_register_dragonbones_DBCCArmatureNode(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"dbs.DBCCArmatureNode");
    tolua_cclass(tolua_S,"DBCCArmatureNode","dbs.DBCCArmatureNode","cc.Node",nullptr);

    tolua_beginmodule(tolua_S,"DBCCArmatureNode");
        tolua_function(tolua_S,"new",lua_dragonbones_DBCCArmatureNode_constructor);
        tolua_function(tolua_S,"getAnimation",lua_dragonbones_DBCCArmatureNode_getAnimation);
        tolua_function(tolua_S,"registerMovementEventHandler",lua_dragonbones_DBCCArmatureNode_registerMovementEventHandler);
        tolua_function(tolua_S,"getCCEventDispatcher",lua_dragonbones_DBCCArmatureNode_getCCEventDispatcher);
        tolua_function(tolua_S,"registerFrameEventHandler",lua_dragonbones_DBCCArmatureNode_registerFrameEventHandler);
        tolua_function(tolua_S,"getArmature",lua_dragonbones_DBCCArmatureNode_getArmature);
        tolua_function(tolua_S,"unregisterMovementEventHandler",lua_dragonbones_DBCCArmatureNode_unregisterMovementEventHandler);
        tolua_function(tolua_S,"getCCSlot",lua_dragonbones_DBCCArmatureNode_getCCSlot);
        tolua_function(tolua_S,"unregisterFrameEventHandler",lua_dragonbones_DBCCArmatureNode_unregisterFrameEventHandler);
        tolua_function(tolua_S,"initWithDBCCArmature",lua_dragonbones_DBCCArmatureNode_initWithDBCCArmature);
        tolua_function(tolua_S,"getCCDisplay",lua_dragonbones_DBCCArmatureNode_getCCDisplay);
        tolua_function(tolua_S,"advanceTime",lua_dragonbones_DBCCArmatureNode_advanceTime);
        tolua_function(tolua_S,"create", lua_dragonbones_DBCCArmatureNode_create);
        tolua_function(tolua_S,"createWithWorldClock", lua_dragonbones_DBCCArmatureNode_createWithWorldClock);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(dragonBones::DBCCArmatureNode).name();
    g_luaType[typeName] = "dbs.DBCCArmatureNode";
    g_typeCast["DBCCArmatureNode"] = "dbs.DBCCArmatureNode";
    return 1;
}

int lua_dragonbones_DBCCFactory_buildArmatureNode(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif
    cobj = (dragonBones::DBCCFactory*)tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCFactory_buildArmatureNode'", nullptr);
        return 0;
    }
#endif
    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 2) {
            std::string arg0;
            ok &= luaval_to_std_string(tolua_S, 2,&arg0);

            if (!ok) { break; }
            std::string arg1;
            ok &= luaval_to_std_string(tolua_S, 3,&arg1);

            if (!ok) { break; }
            dragonBones::DBCCArmatureNode* ret = cobj->buildArmatureNode(arg0, arg1);
            object_to_luaval<dragonBones::DBCCArmatureNode>(tolua_S, "dbs.DBCCArmatureNode",(dragonBones::DBCCArmatureNode*)ret);
            return 1;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 1) {
            std::string arg0;
            ok &= luaval_to_std_string(tolua_S, 2,&arg0);

            if (!ok) { break; }
            dragonBones::DBCCArmatureNode* ret = cobj->buildArmatureNode(arg0);
            object_to_luaval<dragonBones::DBCCArmatureNode>(tolua_S, "dbs.DBCCArmatureNode",(dragonBones::DBCCArmatureNode*)ret);
            return 1;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 5) {
            std::string arg0;
            ok &= luaval_to_std_string(tolua_S, 2,&arg0);

            if (!ok) { break; }
            std::string arg1;
            ok &= luaval_to_std_string(tolua_S, 3,&arg1);

            if (!ok) { break; }
            std::string arg2;
            ok &= luaval_to_std_string(tolua_S, 4,&arg2);

            if (!ok) { break; }
            std::string arg3;
            ok &= luaval_to_std_string(tolua_S, 5,&arg3);

            if (!ok) { break; }
            std::string arg4;
            ok &= luaval_to_std_string(tolua_S, 6,&arg4);

            if (!ok) { break; }
            dragonBones::DBCCArmatureNode* ret = cobj->buildArmatureNode(arg0, arg1, arg2, arg3, arg4);
            object_to_luaval<dragonBones::DBCCArmatureNode>(tolua_S, "dbs.DBCCArmatureNode",(dragonBones::DBCCArmatureNode*)ret);
            return 1;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "buildArmatureNode",argc, 5);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_buildArmatureNode'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCFactory_hasDragonBones(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCFactory*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCFactory_hasDragonBones'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        bool ret = cobj->hasDragonBones(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    if (argc == 2) 
    {
        std::string arg0;
        std::string arg1;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_std_string(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        bool ret = cobj->hasDragonBones(arg0, arg1);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    if (argc == 3) 
    {
        std::string arg0;
        std::string arg1;
        std::string arg2;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_std_string(tolua_S, 3,&arg1);

        ok &= luaval_to_std_string(tolua_S, 4,&arg2);
        if(!ok)
            return 0;
        bool ret = cobj->hasDragonBones(arg0, arg1, arg2);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "hasDragonBones",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_hasDragonBones'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCFactory_loadTextureAtlas(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCFactory*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCFactory_loadTextureAtlas'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        dragonBones::ITextureAtlas* ret = cobj->loadTextureAtlas(arg0);
        object_to_luaval<dragonBones::ITextureAtlas>(tolua_S, "dbs.ITextureAtlas",(dragonBones::ITextureAtlas*)ret);
        return 1;
    }
    if (argc == 2) 
    {
        std::string arg0;
        std::string arg1;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_std_string(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        dragonBones::ITextureAtlas* ret = cobj->loadTextureAtlas(arg0, arg1);
        object_to_luaval<dragonBones::ITextureAtlas>(tolua_S, "dbs.ITextureAtlas",(dragonBones::ITextureAtlas*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "loadTextureAtlas",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_loadTextureAtlas'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCFactory_refreshAllTextureAtlasTexture(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCFactory*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCFactory_refreshAllTextureAtlasTexture'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj->refreshAllTextureAtlasTexture();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "refreshAllTextureAtlasTexture",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_refreshAllTextureAtlasTexture'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCFactory_refreshTextureAtlasTexture(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCFactory*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCFactory_refreshTextureAtlasTexture'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        cobj->refreshTextureAtlasTexture(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "refreshTextureAtlasTexture",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_refreshTextureAtlasTexture'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCFactory_loadDragonBonesData(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (dragonBones::DBCCFactory*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_dragonbones_DBCCFactory_loadDragonBonesData'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);
        if(!ok)
            return 0;
        dragonBones::DragonBonesData* ret = cobj->loadDragonBonesData(arg0);
        object_to_luaval<dragonBones::DragonBonesData>(tolua_S, "dbs.DragonBonesData",(dragonBones::DragonBonesData*)ret);
        return 1;
    }
    if (argc == 2) 
    {
        std::string arg0;
        std::string arg1;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0);

        ok &= luaval_to_std_string(tolua_S, 3,&arg1);
        if(!ok)
            return 0;
        dragonBones::DragonBonesData* ret = cobj->loadDragonBonesData(arg0, arg1);
        object_to_luaval<dragonBones::DragonBonesData>(tolua_S, "dbs.DragonBonesData",(dragonBones::DragonBonesData*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "loadDragonBonesData",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_loadDragonBonesData'.",&tolua_err);
#endif

    return 0;
}
int lua_dragonbones_DBCCFactory_destroyInstance(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        dragonBones::DBCCFactory::destroyInstance();
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "destroyInstance",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_destroyInstance'.",&tolua_err);
#endif
    return 0;
}
int lua_dragonbones_DBCCFactory_getInstance(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"dbs.DBCCFactory",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
            return 0;
        dragonBones::DBCCFactory* ret = dragonBones::DBCCFactory::getInstance();
        object_to_luaval<dragonBones::DBCCFactory>(tolua_S, "dbs.DBCCFactory",(dragonBones::DBCCFactory*)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "getInstance",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_getInstance'.",&tolua_err);
#endif
    return 0;
}
int lua_dragonbones_DBCCFactory_constructor(lua_State* tolua_S)
{
    int argc = 0;
    dragonBones::DBCCFactory* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new dragonBones::DBCCFactory();
        tolua_pushusertype(tolua_S,(void*)cobj,"dbs.DBCCFactory");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "DBCCFactory",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_dragonbones_DBCCFactory_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_dragonbones_DBCCFactory_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (DBCCFactory)");
    return 0;
}

int lua_register_dragonbones_DBCCFactory(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"dbs.DBCCFactory");
    tolua_cclass(tolua_S,"DBCCFactory","dbs.DBCCFactory","dbs.BaseFactory",nullptr);

    tolua_beginmodule(tolua_S,"DBCCFactory");
        tolua_function(tolua_S,"new",lua_dragonbones_DBCCFactory_constructor);
        tolua_function(tolua_S,"buildArmatureNode",lua_dragonbones_DBCCFactory_buildArmatureNode);
        tolua_function(tolua_S,"hasDragonBones",lua_dragonbones_DBCCFactory_hasDragonBones);
        tolua_function(tolua_S,"loadTextureAtlas",lua_dragonbones_DBCCFactory_loadTextureAtlas);
        tolua_function(tolua_S,"refreshAllTextureAtlasTexture",lua_dragonbones_DBCCFactory_refreshAllTextureAtlasTexture);
        tolua_function(tolua_S,"refreshTextureAtlasTexture",lua_dragonbones_DBCCFactory_refreshTextureAtlasTexture);
        tolua_function(tolua_S,"loadDragonBonesData",lua_dragonbones_DBCCFactory_loadDragonBonesData);
        tolua_function(tolua_S,"destroyInstance", lua_dragonbones_DBCCFactory_destroyInstance);
        tolua_function(tolua_S,"getInstance", lua_dragonbones_DBCCFactory_getInstance);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(dragonBones::DBCCFactory).name();
    g_luaType[typeName] = "dbs.DBCCFactory";
    g_typeCast["DBCCFactory"] = "dbs.DBCCFactory";
    return 1;
}
TOLUA_API int register_all_dragonbones(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_dragonbones_DBCCTextureAtlas(tolua_S);
	lua_register_dragonbones_DBCCFactory(tolua_S);
	lua_register_dragonbones_Animation(tolua_S);
	lua_register_dragonbones_DBCCSlot(tolua_S);
	lua_register_dragonbones_DBCCArmature(tolua_S);
	lua_register_dragonbones_DBCCArmatureNode(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

