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
@interface SYBDMainMapViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate>
{
    BMKMapView*     _mapView;
    // search
    bool            _isGeoSearch;
    int             _curPage;
    NSString*       _cityName;

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

@end
