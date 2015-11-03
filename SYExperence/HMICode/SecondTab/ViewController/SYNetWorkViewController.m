//
//  SYNetWorkViewController.m
//  SYExperence
//
//  Created by yuhang on 15/10/21.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYNetWorkViewController.h"
#import "MBProgressHUD+SY.h"
@interface SYNetWorkViewController ()<NSXMLParserDelegate>

/**
 *  用来存放服务器返回的所有数据
 */
@property (nonatomic, strong) NSMutableData *responseData;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *pwdField;
- (IBAction)login:(id)sender;
@end

@implementation SYNetWorkViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSArray* paths1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, NO);
    NSLog(@">>>>>%@\n%@", paths, paths1);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender
{
    //1 表单验证
    NSString* username = self.usernameField.text;
    if (username.length == 0) {
        [MBProgressHUD showError:@"please input username"];
        return;
    }
    
    NSString* pwd = self.pwdField.text;
    if (pwd.length == 0) {
        [MBProgressHUD showError:@"please input password"];
        return;
    }
    // hub
    [MBProgressHUD showMessage:@"login..."];
    
    //2 request
    
    //2.1
    NSString *urlStr = [NSString stringWithFormat:@"http://10.61.140.63:8080/MJServer/login?username=%@&pwd=%@", username, pwd];
//    NSString* urlStr = [NSString stringWithFormat:@"http://localhost:8080/MJServer/login?username=%@&pwd=%@", username, pwd];
    NSLog(@"%@", urlStr);
    // 转码，URL不能包含中文
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urlStr];
    // 2.2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.timeoutInterval = 5;
    
    // 2.3
    [self sendAsync:request];
    
    
}

/**
 *  发送异步请求的方式2: start方法, 代理
 */
- (void)sendAsync2:(NSURLRequest *)request
{
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start]; // 异步执行
}

/**
 *  发送异步请求的方式1: 类方法, block
 */
- (void)sendAsync:(NSURLRequest *)request
{
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {  // 当请求结束的时候调用 (拿到了服务器的数据, 请求失败)
        
        // 隐藏HUD (刷新UI界面, 一定要放在主线程, 不能放在子线程)
        [MBProgressHUD hideHUD];
        
        /**
         解析data :
         {"error":"用户名不存在"}
         {"error":"密码不正确"}
         {"success":"登录成功"}
         */
        if (data) { // 请求成功
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSString *error = dict[@"error"];
            if (error) { // 登录失败
                [MBProgressHUD showError:error];
            } else { // 登录成功
                NSString *success =  dict[@"success"];
                [MBProgressHUD showSuccess:success];
            }
        } else { // 请求失败
            [MBProgressHUD showError:@"网络繁忙, 请稍后再试"];
        }
        //
        [self printHttpUrlResponse:response];
    }];
}

- (void)printHttpUrlResponse:(NSHTTPURLResponse *)response
{
    NSLog(@"HttpUrlResponse->URL.absoluteString:%@\n", response.URL.absoluteString);
    NSLog(@"HttpUrlResponse->URL.relativeString:%@\n", response.URL.relativeString);
    NSLog(@"HttpUrlResponse->MIMEType:%@\n", response.MIMEType);
    NSLog(@"HttpUrlResponse->textEncodingName:%@\n", response.textEncodingName);
    NSLog(@"HttpUrlResponse->expectedContentLength:%lld\n", response.expectedContentLength);
    NSLog(@"HttpUrlResponse->suggestedFilename:%@\n", response.suggestedFilename);
    
    //
    NSLog(@"HttpUrlResponse->statusCode:%ld\n", response.statusCode);
    NSLog(@"HttpUrlResponse->allHeaderFields:%@\n", [response.allHeaderFields description]);
}

#pragma mark - NSURLConnectionDataDelegate 代理方法
/**
 *  请求错误(失败)的时候调用(请求超时\断网\没有网, 一般指客户端错误)
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection:didFailWithError:");
    [MBProgressHUD hideHUD];
    
    [MBProgressHUD showError:@"网络繁忙, 请稍后再试"];
}

/**
 *  当接受到服务器的响应(连通了服务器)就会调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"connection:didReceiveResponse:");
    
    // 初始化数据
    self.responseData = [NSMutableData data];
}

/**
 *  当接受到服务器的数据就会调用(可能会被调用多次, 每次调用只会传递部分数据)
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"connection:didReceiveData:");
    
    // 拼接(收集)数据
    [self.responseData appendData:data];
}

/**
 *  当服务器的数据接受完毕后就会调用
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading:");
    
    // 隐藏HUD
    [MBProgressHUD hideHUD];
    
    // 解析服务器返回的数据
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
    NSString *error =  dict[@"error"];
    if (error) { // 登录失败
        [MBProgressHUD showError:error];
    } else { // 登录成功
        NSString *success =  dict[@"success"];
        [MBProgressHUD showSuccess:success];
    }
}

#pragma mark -
#pragma mark XML 解析
- (void)parseXMLData:(NSData *)data
{
    // 1 创建解析器
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    // 2 设置代理
    parser.delegate = self;
    // 3 开始解析（同步解析）
    [parser parse];
    // 4 结束后操作
    
}

/*
 * 文本开始
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

/*
 *元素开始
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}


@end
