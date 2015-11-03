//
//  SYSystemFunction.m
//  SYExperence
//
//  Created by yuhang on 15/9/21.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYSystemFunction.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD+SY.h"
@interface SYSystemFunction ()<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
{
    
}


@property (nonatomic, strong) UIWebView* webView;

@end

@implementation SYSystemFunction

+ (instancetype)sharedInstance
{
    static SYSystemFunction* instance = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[SYSystemFunction alloc] init];
    });
    
    return instance;
}

/**
 * @brief   打开程序
 * @param1  程序地址
 * @return
 */
- (void)openAppWithUrl:(NSString *)urlStr
{
    // 构建淘宝客户端协议的 URL
    NSURL *url = [NSURL URLWithString:urlStr];
    // 判断当前系统是否有安装淘宝客户端
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        // 如果已经安装淘宝客户端，就使用客户端打开链接
        [[UIApplication sharedApplication] openURL:url];
    } else {
        // 否则使用 Mobile Safari 或者内嵌 WebView 来显示
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://item.taobao.com/item.htm?id=%@", @"123"]];
//        [[UIApplication sharedApplication] openURL:url];
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"没有安装该程序" message:urlStr delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//        [alert show];
        [MBProgressHUD showError:@"没有安装该程序"];
    }
}

/**
 * @brief   拨打电话 一
 * @param1  电话号码
 * @return
 */
- (void)callWithNumber:(NSString *)number
{
    NSString* tel = [NSString stringWithFormat:@"tel://%@", number];
    NSURL* url = [[NSURL alloc] initWithString:tel];
    [[UIApplication sharedApplication] openURL:url];
}

/**
 * @brief   拨打电话 二
 * @param1  电话号码
 * @return
 */
- (void)showCallPromptWithNumber:(NSString *)number backApp:(BOOL)isBack
{
    if (isBack) {
        NSString* tel = [NSString stringWithFormat:@"telPrompt://%@", number];
        NSURL* url = [[NSURL alloc] initWithString:tel];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        if (_webView == nil) {
            _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        }
        NSString* tel = [NSString stringWithFormat:@"tel://%@", number];
        NSURL* url = [[NSURL alloc] initWithString:tel];
        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    }
}

/**
 * @brief   短信
 * @param1  电话号码
 * @return
 */
- (void)messageWithNumber:(NSString *)number
{
    NSString* tel = [NSString stringWithFormat:@"sms://%@", number];
    NSURL* url = [[NSURL alloc] initWithString:tel];
    [[UIApplication sharedApplication] openURL:url];
}

/**
 * @brief   短信
 * @param1  电话号码
 * @return
 */
- (void)messageWithNumber:(NSString *)number presentBy:(UIViewController *)vc
{
    MFMessageComposeViewController *messageVc = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    messageVc.body = @"吃饭了没？";
    // 设置收件人列表
    messageVc.recipients = @[@"10010", @"02010010"];
    // 设置代理
    messageVc.messageComposeDelegate = self;
    
    // 显示控制器
    [vc presentViewController:messageVc animated:YES completion:nil];
}

/**
 * @brief   邮件
 * @param1  邮箱
 * @return
 */
- (void)mailWithAddress:(NSString *)email
{
    
}

/**
 * @brief   邮件
 * @param1  邮箱
 * @return
 */
- (void)mailWithAddress:(NSString *)email presentBy:(UIViewController *)vc
{
    MFMailComposeViewController *mailVc = [[MFMailComposeViewController alloc] init];
    
    // 设置邮件主题
    [mailVc setSubject:@"会议"];
    // 设置邮件内容
    [mailVc setMessageBody:@"今天下午开会吧" isHTML:NO];
    // 设置收件人列表
    [mailVc setToRecipients:@[@"565606458@qq.com"]];
    // 设置抄送人列表
    [mailVc setCcRecipients:@[@"565606458@qq.com"]];
    // 设置密送人列表
    [mailVc setBccRecipients:@[@"565606458@qq.com"]];
    
    // 添加附件（一张图片）
    UIImage *image = [UIImage imageNamed:@"apper.png"];
    NSData *data = UIImagePNGRepresentation(image);
    [mailVc addAttachmentData:data mimeType:@"image/png" fileName:@"lufy.png"];
    
    // 设置代理
    mailVc.mailComposeDelegate = self;
    // 显示控制器
    [vc presentViewController:mailVc animated:YES completion:nil];
}

/**
 *  点击取消按钮会自动调用
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
