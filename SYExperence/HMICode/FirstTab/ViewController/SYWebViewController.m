//
//  SYWebViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/28.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

/*
 * 关于屏幕旋转问题
 1 
 // New Autorotation support.
 - (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0);
 - (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0);
 2
 - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
 1）willRotateToInterfaceOrientation在viewWillTransitionToSize没有实现的情况下，会调用
 2）viewWillTransitionToSize注意父视图调用问题
 */

#import "SYWebViewController.h"

typedef enum : NSUInteger {
    SVBack,
    SVForward,
    SVRefresh,
} SVSubViewIndex;


@interface SYWebViewController ()<UIWebViewDelegate>


@property (nonatomic, strong)   UIButton*   btnBack;

@property (nonatomic, strong)   UIButton*   btnForword;

@property (nonatomic, strong)   UIButton*   btnRefresh;

@property (nonatomic, strong)   UIWebView*  webview;

@end

@implementation SYWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self _initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setUrl:(NSURL *)url
{
    _webviewUrl = url;
    //
    if (_webview) {
        [_webview loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    }
}

- (void)_initControls
{
    [self _addButtons];
    [self _addWebview];
}

- (void)_addButtons
{
    CGFloat btnH = 30;
    CGFloat btnW = self.view.frame.size.width/3;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    _btnBack = [self _createButton];
    _btnBack.tag = SVBack;
    [_btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [_btnBack setFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    //
    _btnForword = [self _createButton];
    _btnForword.tag = SVForward;
    [_btnForword setTitle:@"Forward" forState:UIControlStateNormal];
    [_btnForword setFrame:CGRectMake(btnX+btnW, btnY, btnW, btnH)];
    //
    _btnRefresh = [self _createButton];
    _btnRefresh.tag = SVRefresh;
    [_btnRefresh setTitle:@"Refresh" forState:UIControlStateNormal];
    [_btnRefresh setFrame:CGRectMake(btnX+2*btnW, btnY, btnW, btnH)];
}

- (void)_addWebview
{
    CGFloat webX = 5;
    CGFloat webY = 30;
    CGFloat webW = self.view.frame.size.width - webX*2;
    CGFloat webH = self.view.frame.size.height - webY;
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(webX, webY, webW, webH)];
    _webview.scalesPageToFit = YES;
    if (_webviewUrl)
    {
        NSURLRequest* requese = [[NSURLRequest alloc] initWithURL:_webviewUrl];
        [_webview loadRequest:requese];
    }
    [self.view addSubview:_webview];
    _webview.delegate = self;
    
}

- (void)_setSubviewsFrame:(CGSize)rc
{
    //
    CGFloat webX = 5;
    CGFloat webY = 30;
    CGFloat webW = rc.width - webX*2;
    CGFloat webH = rc.height - webY;
    _webview.frame = CGRectMake(webX, webY, webW, webH);
    //
    CGFloat btnH = 30;
    CGFloat btnW = rc.width/3;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    [_btnBack setFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    
    [_btnForword setFrame:CGRectMake(btnX+btnW, btnY, btnW, btnH)];

    [_btnRefresh setFrame:CGRectMake(btnX+2*btnW, btnY, btnW, btnH)];
}

- (UIButton *)_createButton
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

- (void)buttonClicked:(UIButton *)button
{
    NSInteger index = button.tag;
    switch (index) {
            case SVBack:
        {
            if (_webview.canGoBack) {
                [_webview goBack];
            }
        }
            break;
            case SVForward:
        {
            if (_webview.canGoForward) {
                [_webview goForward];
            }
        }
            break;
            case SVRefresh:
        {
            [_webview reload];
        }
            break;
        default:
            break;
    }
}



#pragma mark -
#pragma mark webview delegate

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self _setSubviewsFrame:size];
}
@end
