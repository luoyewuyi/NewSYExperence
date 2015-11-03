//
//  SYVideoTool.h
//  SYExperence
//
//  Created by yuhang on 15/10/23.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYVideoTool : NSObject
{
    
}

- (NSArray *)parseXMLData:(NSData *)data;

- (NSArray *)parseJSONData:(NSData *)data;

@end
