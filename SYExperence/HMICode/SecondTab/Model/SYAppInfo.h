//
//  SYAppInfo.h
//  SYExperence
//
//  Created by yuhang on 15/10/12.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYAppInfo : NSObject


@property (nonatomic, strong)   NSString* name;

@property (nonatomic, strong)   NSString* icon;

@property (nonatomic, strong)   NSString* download;


/*
 * @brief
 * return
 */
+ (instancetype)appInfoWithDict:(NSDictionary *)dict;
@end
