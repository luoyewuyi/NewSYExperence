//
//  SYVideo.m
//  SYExperence
//
//  Created by yuhang on 15/10/23.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYVideo.h"

@implementation SYVideo


+ (instancetype)videoWithDict:(NSDictionary *)dict
{
    SYVideo* video = [[self alloc] init];
    
    video.name = dict[@"name"];
    video.image = dict[@"image"];
    video.url = dict[@"url"];
    video.length = [dict[@"length"] intValue];
    video.ID = [dict[@"id"] intValue];
    
    return video;
    //    [video setValuesForKeysWithDictionary:dict]; // KVC方法使用前提: 字典中的所有key 都能在 模型属性 中找到
}
@end
