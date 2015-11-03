//
//  SYGlobalDefinition.h
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#ifndef SYExperence_SYGlobalDefinition_h
#define SYExperence_SYGlobalDefinition_h


#pragma mark -
#pragma mark 系统

#define SYIOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)



#pragma mark -
#pragma mark UIColor

#define SYColor(r, g, b)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SYAngleToRadian(angle)      ((angle)*M_PI/180)

#endif


#pragma mark -
#pragma mark 编码

#if !__has_feature(objc_arc)

#endif

//#define SuppressPerformSelectorLeakWarning(Stuff) \
//do { \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
//Stuff; \
//_Pragma("clang diagnostic pop") \
//} while (0)
// 调用方法
//SuppressPerformSelectorLeakWarning(
//                                   [_target performSelector:_action withObject:self]
//                                   );



#define     SYScreenWidth         [[UIScreen mainScreen] bounds].size.width           //屏幕宽度，iphone4：320
#define     SYScreenHeight        [[UIScreen mainScreen] bounds].size.height          //屏幕高度，iphone4：480(iphone5_568)













