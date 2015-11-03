//
//  SYVideo.h
//  SYExperence
//
//  Created by yuhang on 15/10/23.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYVideo : NSObject


@property (nonatomic, assign)   NSInteger ID;

@property (nonatomic, strong)   NSString* name;

@property (nonatomic, assign)   NSInteger length;

@property (nonatomic, strong)   NSString* image;

@property (nonatomic, strong)   NSString* url;


/*
 * @brief initialize
 * return
 */
+ (instancetype)videoWithDict:(NSDictionary *)dict;
@end
