//
//  SYSystemFunction.h
//  SYExperence
//
//  Created by yuhang on 15/9/21.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYSystemFunction : NSObject
{
    
}

+ (instancetype)sharedInstance;

/**
 * @brief   1 调用其他的运用程序
            2 URL Schema就是iOS内的应用调用协议，应用A可以声明自定义的调用协议，就如http/https那样，当另一个应用B打算在应用内打开应用A时，可 以打开使用A自定义的协议开头的URL来打开A，除了协议头，URL中还可以附加其他参数
            3 在info.plist中添加“URL types”字段，设置“RUL identifier”和“URL Schemes”字段，如设置“URL Schemes”字段为“gaodedaohang”，将为此应用注册自定义协议名称，其他应用可以通过“gaodedaohang://XXX”的Url调用该程序
 * @param1  程序地址
 * @return
 */
- (void)openAppWithUrl:(NSString *)urlStr;

/**
 * @brief   拨打电话 一
 * @param1  电话号码
 * @return
 */
- (void)callWithNumber:(NSString *)number;

/**
 * @brief   拨打电话 二
 * @param1  电话号码
 * @return
 */
- (void)showCallPromptWithNumber:(NSString *)number backApp:(BOOL)isBack;

/**
 * @brief   短信
 * @param1  电话号码
 * @return
 */
- (void)messageWithNumber:(NSString *)number;

/**
 * @brief   短信
 * @param1  电话号码
 * @return
 */
- (void)messageWithNumber:(NSString *)number presentBy:(UIViewController *)vc;

/**
 * @brief   邮件
 * @param1  邮箱
 * @return
 */
- (void)mailWithAddress:(NSString *)email;

/**
 * @brief   邮件
 * @param1  邮箱
 * @return
 */
- (void)mailWithAddress:(NSString *)email presentBy:(UIViewController *)vc;

@end
