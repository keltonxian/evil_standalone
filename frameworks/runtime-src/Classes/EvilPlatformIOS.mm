//
//  EvilPlatformIOS.h
//  EvilCard
//
//  Created by keltonxian on 10/31/14.
//
//

#include "EvilPlatform.h"

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS) || (CC_TARGET_PLATFORM == CC_PLATFORM_MAC)


#import <Foundation/Foundation.h>

std::string EvilPlatform::getRootPath()
{
    NSString *path = NSHomeDirectory();
    return [path UTF8String];
}

std::string EvilPlatform::getResourcePath()
{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    return [path UTF8String];
}

#endif