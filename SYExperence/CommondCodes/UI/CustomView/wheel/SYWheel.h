//
//  SYWheel.h
//  SYExperence
//
//  Created by yuhang on 15/9/26.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYWheel : UIView


/*
 * @brief 实例化
 * return
 */
+ (instancetype)wheel;

/*
 * @brief 开始
 * return
 */
- (void)startRotating;

/*
 * @brief 停止
 * return
 */
- (void)stopRotating;


@end
