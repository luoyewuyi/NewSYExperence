//
//  SYBDMainMapViewController.m
//  SYExperence
//
//  Created by yuhang on 15/10/30.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import "SYBDMainMapViewController.h"
#import "SYBDMapKit.h"
#import "MBProgressHUD+SY.h"

@interface SYBDMainMapViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate,BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>
{
    BMKMapView*             _mapView;
    // search
    bool                    _isGeoSearch;
    int                     _curPage;
    NSString*               _cityName;
    // navi
    CLLocationCoordinate2D  _destination;
}

@property (nonatomic, strong)   BMKGeoCodeSearch*   geocodesearch;
@property (nonatomic, strong)   BMKPoiSearch*       poiSearch;
@end


@implementation SYBDMainMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(getCityName)];
    //
    [self setupMap];
}

- (void)setupMap
{
    __weak SYBDMainMapViewController *weakSelf = self;
    if (![SYBDMapKit sharedInstance].isMapSuc)
    {
        [[SYBDMapKit sharedInstance] startupMap:^(BOOL isSuc) {
            //
            if (isSuc)
            {
                //
                _mapView = (BMKMapView*)[SYBDMapKit sharedInstance].mapView;
                [weakSelf.view addSubview:_mapView];
                [_mapView viewWillAppear];
                _mapView.delegate = self;
            }
        }];
    }else
    {
        _mapView = (BMKMapView*)[SYBDMapKit sharedInstance].mapView;
        [weakSelf.view addSubview:_mapView];
    }
    //
    if (![SYBDMapKit sharedInstance].isNaviSuc) {
        [[SYBDMapKit sharedInstance] startupNavi:^(BOOL isSuc) {
            //
            NSLog(@"navi initialize %d", isSuc);
        }];
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poiSearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poiSearch.delegate = nil;
}

#pragma mark -
#pragma mark 获取当前城市名称
- (BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch) {
        _geocodesearch = [[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}

- (void)getCityName
{
    _isGeoSearch = false;
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = [SYBDMapKit sharedInstance].locService.userLocation.location.coordinate;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
        [MBProgressHUD showMessage:@"获取当前城市城市"];
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
//        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//        item.coordinate = result.location;
//        item.title = result.addressDetail.city;
//        [_mapView addAnnotation:item];
//        _mapView.centerCoordinate = result.location;
//        NSString* titleStr;
//        NSString* showmeg;
//        titleStr = @"反向地理编码";
//        showmeg = [NSString stringWithFormat:@"%@",item.title];
        _cityName = result.addressDetail.city;
        [self getPoiInfo];
    }
    else
    {
        [MBProgressHUD hideHUD];
    }
    
}

#pragma mark -
#pragma mark 获取当前城市的停车场信息
- (BMKPoiSearch *)poiSearch
{
    if (!_poiSearch) {
        _poiSearch = [[BMKPoiSearch alloc] init];
        _poiSearch.delegate = self;
    }
    return _poiSearch;
}

-(void)getPoiInfo
{
    _curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = _curPage;
    citySearchOption.pageCapacity = 20;
    citySearchOption.city= _cityName;
    citySearchOption.keyword = @"停车场";
    BOOL flag = [self.poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
    [MBProgressHUD hideHUD];
}
#pragma mark - 点击气泡
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    NSLog(@"mapViewDidFinishLoading");
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    _destination = view.annotation.coordinate;
    
    [self realNavi];
}

#pragma mark -
#pragma mark 导航
//真实GPS导航
- (void)realNavi
{
    if (![self checkServicesInited])
    {
        return;
    }
    [self startNavi];
}

- (BOOL)checkServicesInited
{
    if(![BNCoreServices_Instance isServicesInited])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"引擎尚未初始化完成，请稍后再试"
                                                           delegate:nil
                                                  cancelButtonTitle:@"我知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)startNavi
{
    NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
    //起点 传入的是原始的经纬度坐标，若使用的是百度地图坐标，可以使用BNTools类进行坐标转化
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = /*113.936392;*/[SYBDMapKit sharedInstance].locService.userLocation.location.coordinate.longitude;
    startNode.pos.y = /*22.547058;*/[SYBDMapKit sharedInstance].locService.userLocation.location.coordinate.latitude;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    
    //也可以在此加入1到3个的途经点
    
    
    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = /*114.077075;*/_destination.longitude;
    endNode.pos.y = /*22.543634;*/_destination.latitude;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
    
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Highway naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}

#pragma mark - BNNaviRoutePlanDelegate
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI:BN_NaviTypeReal delegete:self isNeedLandscape:YES];
}

//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    if ([error code] == BNRoutePlanError_LocationFailed) {
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_LocationServiceClosed)
    {
        NSLog(@"定位服务未开启");
    }
}

//算路取消回调
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}

@end
