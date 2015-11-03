//
//  SYBaseGroup.h
//  SYExperence
//
//  Created by yuhang on 15/9/15.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYBaseGroup : NSObject
{
    
}

/**
 * 顶部标题
 */
@property (nonatomic, copy) NSString* headTitle;

/**
 * 底部标题
 */
@property (nonatomic, copy) NSString* footTitle;

/**
 * items数组
 */
@property (nonatomic, strong) NSMutableArray* items;

@end
