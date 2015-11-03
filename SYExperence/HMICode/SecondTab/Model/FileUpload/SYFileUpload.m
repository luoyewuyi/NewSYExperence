//
//  SYFileUpload.m
//  SYExperence
//
//  Created by yuhang on 15/10/26.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYFileUpload.h"

#define SYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

#define SYFileUploadBoundary @"splitLine"

@implementation SYFileUpload


+ (void)upload:(NSString *)name
      fileName:(NSString *)fileName
      mimeType:(NSString *)mimeType
          data:(NSData *)data
        params:(NSDictionary *)params
{
    // 设置请求头
    /*
    Content-Type
    multipart/form-data; boundary=边界值
     */
    // 设置POST数据
    /*
     --边界值\r\n
     Content-Disposition: form-data;name ="";filename=""\r\n
     Content-Type:""\r\n
     \r\n
     file data
     \r\n
     --边界值\r\n
     Content-Disposition: form-data;name=""\r\n
     \r\n
     data
     \r\n
     --边界值--\r\n
     
     */
    
    // 文件上传
    NSURL* url = [NSURL URLWithString:@"http://localhost:localhost:8080/MJServer/upload"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求
    NSMutableData *body = [NSMutableData data];
    
    // 文件参数
    NSString* headLine = [NSString stringWithFormat:@"--%@\r\n", SYFileUploadBoundary];
    [body appendData:SYEncode(headLine)];
    
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName];
    [body appendData:SYEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:SYEncode(type)];
    
    [body appendData:SYEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:SYEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:SYEncode(headLine)];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:SYEncode(disposition)];
        
        [body appendData:SYEncode(@"\r\n")];
        [body appendData:SYEncode(obj)];
        [body appendData:SYEncode(@"\r\n")];
    }];
    
    /***************参数结束***************/
    // heima--\r\n
    NSString* footLine = [NSString stringWithFormat:@"--%@--\r\n", SYFileUploadBoundary];
    [body appendData:SYEncode(footLine)];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", SYFileUploadBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dict);
        } else {
            NSLog(@"上传失败");
        }
    }];
}
@end
