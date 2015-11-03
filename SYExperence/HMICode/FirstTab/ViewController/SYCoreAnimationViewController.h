//
//  SYCoreAnimationViewController.h
//  SYExperence
//
//  Created by yuhang on 15/9/25.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
/*
 
 二 Core Animation的使用步骤
 1 导入框架QuartzCore.framework
 2 初始化一个CAAnimation对象，并设置一些动画相关的属性
 3 通过调用CALayer的addAnimation:forKey:方法添加CAAnimation对象到CALayer中，就能开始执行动画
 4 通过调用CALayer的removeAnimationForKey:方法可以停止CALayer中的动画
 
 
 
 
 
 */
/*
 1、iphone有几个内嵌的随机数发生器，如rand()、random()、arc4random()
 其精确程度为
 arc4random(多大的数)  >  random()  >  rand()
 2、rand()和random()在使用之前需要先初始化随机种子，即调用
 srandom(time(NULL));
 arc4random()不需要生成随机种子，因为第一次调用的时候就会自动生成。
 */


@interface SYCoreAnimationViewController : UIViewController

@end
