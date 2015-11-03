//
//  SYAppInfo.m
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYAppInfo.h"

@implementation SYAppInfo



/*
 * @brief
 * return
 */
+ (instancetype)appInfoWithDict:(NSDictionary *)dict
{
    SYAppInfo* appInfo = [[self alloc] init];
    
    [appInfo setValuesForKeysWithDictionary:dict];
    
    return appInfo;
}

@end
