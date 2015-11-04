//
//  SYBDMapKit.m
//  SYExperence
//
//  Created by yuhang on 15/10/30.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYBDMapKit.h"


static NSString* mapKey = @"yq1DQurGurxA0mxMEjur7R5z";

static BOOL isFirstTime = NO;

@interface SYBDMapKit ()<BMKGeneralDelegate,BMKLocationServiceDelegate>
{
    BMKMapManager*      _mapManager;
}

@property (nonatomic, assign)   BOOL isMapSuc;
@property (nonatomic, assign)   BOOL isNaviSuc;

@property (nonatomic, copy)     void(^mapHander)(BOOL isSuc);
@property (nonatomic, copy)     void(^naviHander)(BOOL isSuc);

@end

@implementation SYBDMapKit

SYSharedInstance_m();

#pragma mark -
#pragma mark 初始化地图
/*
 * @brief 初始化
 * return
 */
- (void)startupMap:(void (^)(BOOL isSuc))hander
{
    self.mapHander = hander;
    // 初始化地图SDK
    if (!_isMapSuc)
    {
        _mapManager = [[BMKMapManager alloc]init];
        BOOL ret = [_mapManager start:mapKey generalDelegate:self];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
    }
    //
    if (!isFirstTime)
    {
        isFirstTime = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    }
}

/*
 * @brief 初始化
 * return
 */
- (void)startupNavi:(void (^)(BOOL isSuc))hander
{
    self.naviHander = hander;
    //初始化导航SDK
    if (!_isNaviSuc) {
                [BNCoreServices_Instance initServices:mapKey];
                [BNCoreServices_Instance startServicesAsyn:^{
                    //
                    _isNaviSuc = YES;
                    self.naviHander(YES);
                } fail:^{
                    //
                    _isNaviSuc = NO;
                    self.naviHander(YES);
                }];
    }
}

- (void)applicationDidBecomeActive
{
    [BMKMapView didForeGround];
}

- (void)applicationWillResignActive
{
    [BMKMapView willBackGround];
}




- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
        
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
        _isMapSuc = YES;
        self.mapHander(YES);
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
        self.mapHander(NO);
    }
}

#pragma mark -
#pragma mark 返回地图
- (UIView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SYScreenWidth, SYScreenHeight)];
        // 比例尺
        _mapView.showMapScaleBar = YES;
        _mapView.mapScaleBarPosition = CGPointMake(SYScreenWidth-60, SYScreenHeight-100);
        
        // 指南针
       _mapView.compassPosition = CGPointMake(10, 100);

        // 定位模式
        _locService = [[BMKLocationService alloc]init];
        [_locService startUserLocationService];
        _locService.delegate = self;
        
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层
        //
        _mapView.isSelectedAnnotationViewFront = YES;
        
        // 回车位按钮
        UIButton* userPos = [UIButton buttonWithType:UIButtonTypeCustom];
        [userPos setBackgroundImage:[UIImage imageNamed:@"mainBackCar"] forState:UIControlStateNormal];
        [userPos setBackgroundImage:[UIImage imageNamed:@"mainBackCar"] forState:UIControlStateHighlighted];
        userPos.frame = CGRectMake(10, SYScreenHeight - 100, 50, 50);
        [_mapView addSubview:userPos];
        [userPos addTarget:self action:@selector(actionUserPos:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mapView;
}

#pragma mark -
#pragma mark 初始化导航

#pragma mark -
#pragma mark 定位
/*
 * @brief 开始定位
 * return
 */
- (void)openLocService
{
    if (!_locService) {
        _locService = [[BMKLocationService alloc]init];
        [_locService startUserLocationService];
        _locService.delegate = self;
    }
}

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"willStartLocatingUser");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"didStopLocatingUser");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}


- (void)actionUserPos:(id)sender
{
    // 指南针
    _mapView.compassPosition = CGPointMake(10, 100);
    _mapView.centerCoordinate = _locService.userLocation.location.coordinate;
}
@end
