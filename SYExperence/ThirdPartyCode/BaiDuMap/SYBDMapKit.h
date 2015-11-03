//
//  SYBDMapKit.h
//  SYExperence
//
//  Created by yuhang on 15/10/30.
//  Copyright © 2015年 yuhang. All rights reserved.
//
/*
 百度地图
 1 manager start failed : info.plist 中必须添加 Bundle display name
 2 mapapi.bundle 需要从map.framework中取出添加
 3 Apple LLVM 7.0
    C++ Standard Library修改为Compiler Default
 4 NSLocationWhenInUseUsageDescription
    *打开定位服务
    *需要在info.plist文件中添加(以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription)：
    *NSLocationWhenInUseUsageDescription 允许在前台使用时获取GPS的描述
    *NSLocationAlwaysUsageDescription 允许永远可获取GPS的描述
 5 地图显示前，下面两个函数要注意调用
    [_mapView viewWillAppear];
    _mapView.delegate = self;
 */



#import <Foundation/Foundation.h>
//
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
// search
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
// location
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import "BNCoreServices.h"
@interface SYBDMapKit : NSObject
{
    
}


SYSharedInstance_h();

@property (nonatomic, readonly)     BOOL                isMapSuc;

@property (nonatomic, readonly)     BOOL                isNaviSuc;

@property (nonatomic, strong)       BMKMapView*         mapView;

@property (nonatomic, strong)       BMKLocationService* locService;

/*
 * @brief 初始化
 * return
 */
- (void)startupMap:(void (^)(BOOL isSuc))hander;

/*
 * @brief 初始化
 * return
 */
- (void)startupNavi:(void (^)(BOOL isSuc))hander;

/*
 * @brief 开始定位
 * return
 */
- (void)openLocService;

@end
