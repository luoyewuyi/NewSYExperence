//
//  SYRegularExpressionDemo.m
//  SYExperence
//
//  Created by yuhang on 15/10/29.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYRegularExpressionDemo.h"


//http://www.iciba.com/ios
#define yDicBaseUrl     @"http://dict.cn/"

@implementation SYRegularExpressionDemo



- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    NSString* html = [self loadHtmlWithWord:@"hello"];
    
    [self loadWordContentHtml:html];

    //
}

//- (NSString *)loadWordContentHtml:(NSString *)html
//{
//    //
////    <ul class="dict-basic-ul">
////    
////    <li><span>int.</span><strong>(打招呼)喂；你好</strong></li>
//    //
//    NSString* pattern = @"<ul class=\"dict-basic-ul\">.*?<li><span>(.*?)</span><strong>(.*?)</strong></li>";
//    NSRegularExpression* expression; = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
//    
//    
//    return nil;
//    
//}
- (NSString *)loadWordContentHtml:(NSString *)html
{
    NSString *pattern = @"<ul class=\"dict-basic-ul\">.*?<li><span>(.*?)</span><strong>(.*?)</strong></li>";
    NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
    //
    
    NSTextCheckingResult * result = [expression firstMatchInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    NSArray* ranges = result.grammarDetails;
    NSInteger number = result.numberOfRanges;
    for (NSInteger i = 0; i<number; i++)
    {
        NSRange range = [result rangeAtIndex:i];
        NSString* title = [html substringWithRange:range];
        NSLog(@"Word:%@, %ld", title, i);
    }
    

    
    return nil;
}



- (NSString *)loadHtmlWithWord:(NSString *)word
{
    //
    NSString* urlStr = [yDicBaseUrl stringByAppendingString:word];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        //
        NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return html;
    }
    return nil;
}
@end
