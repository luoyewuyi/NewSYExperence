//
//  SYMapDataTool.h
//  SYExperence
//
//  Created by yuhang on 15/9/2.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYMapDataRespond.h"


/*
 * versions
 */
#define VersionMap      @"V29.1.030005.0003"

#define Syscode             @"41501"// 41506长安，41501航盛

#define AppVersion          @"20"
// 数据下载地址
// http://mlbsdown.autonavi.com
// http://ctest.mapabc.com:8086/nis/mapUpdate?
#define _URL_MAP_DOWNLOAD_CHECK_CITIES_LIST(screenResolution)   \
[NSString stringWithFormat:@"http://mlbsdown.autonavi.com/nis/mapUpdate?os=%@&model=%@&imei=%@&userid=&mapversion=%@&pid=2&resolution=%@&syscode=%@&apkversion=%@",[[UIDevice currentDevice] systemVersion],[[UIDevice currentDevice] model],[[UIDevice currentDevice] identifierForVendor].UUIDString,VersionMap,screenResolution,Syscode,AppVersion]

//#define MapDataUrl @"http://nis.autonavi.com/nis/mapUpdate?os=7.1.2&model=iPhone&imei=F113B339-6348-4823-8C1C-21CA6572B3BC&userid=&mapversion=V27.2.030005.0014&pid=2&resolution=640x1136_7&syscode=41501&apkversion=20"

@interface SYMapDataTool : NSObject
{
    
}

/**
 * @brief   实例化
 * @return
 */
+ (instancetype)sharedInstance;


/**
 * @brief   获取城市列表
 * @return
 */
- (void)getMapDataListFromServer;


@end
