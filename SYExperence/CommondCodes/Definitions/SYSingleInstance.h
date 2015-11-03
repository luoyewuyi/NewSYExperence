//
//  SYSingleInstance.h
//  SYExperence
//
//  Created by yuhang on 15/10/10.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#ifndef SYExperence_SYSingleInstance_h
#define SYExperence_SYSingleInstance_h

/*
 * 头文件定义
 */

#define SYSharedInstance_h(name)  +(instancetype)shared##name##Instance

/*
 * 实现文件定义
 */
#define SYSharedInstance_m(name)  \
static id _instance = nil;\
\
+ (id)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+ (instancetype)shared##name##Instance\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc] init];\
    });\
    \
    return _instance;\
}
#endif
