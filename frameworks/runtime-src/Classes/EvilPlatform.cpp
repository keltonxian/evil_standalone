//
//  EvilPlatform.cpp
//  EvilCard
//
//  Created by keltonxian on 10/31/14.
//
//

#include "EvilPlatform.h"

#if (CC_TARGET_PLATFORM != CC_PLATFORM_IOS && CC_TARGET_PLATFORM != CC_PLATFORM_MAC &&CC_TARGET_PLATFORM != CC_PLATFORM_ANDROID)

std::string EvilPlatform::getRootPath()
{
    return "";
}

std::string EvilPlatform::getResourcePath()
{
    return "";
}

#endif