//
//  SYNetWorkViewController.h
//  SYExperence
//
//  Created by yuhang on 15/10/21.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 * 1 请求的链接不能有中文字符，
    - (nullable NSString *)stringByAddingPercentEscapesUsingEncoding:(NSStringEncoding)enc
 * 2 NSString转NSData
    - (nullable NSData *)dataUsingEncoding:(NSStringEncoding)encoding;
 * 3 下载的大文件不要放在Documents文件夹，会被用户iCloud备份，放在library/cash或者temp下面（temp可能会被删除）
 * 4 写入文件使用NSFileHandle
 */
@interface SYNetWorkViewController : UIViewController

@end
