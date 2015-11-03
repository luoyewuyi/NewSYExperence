//
//  MainTabBarViewController.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "MainTabBarViewController.h"


// view Controller
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"
#import "FourthTableViewController.h"
#import "FifthTableViewController.h"
// tabBar
#import "SYTabBar.h"
//
#import "SYNavigationController.h"

@interface MainTabBarViewController ()<SYTabBarDelegate>
{
    
}


@property (nonatomic, weak) SYTabBar* customTabBar;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabbar
    [self _setupTabBar];
    
    // 初始化子视图控制器
    [self _setAllSubViewControllers];
    
    NSString* path1 = @"abc";
    NSString* path2 = @"def";
    NSLog(@"t1:%@\n, t2:%@\n, t3:%@\n, t4:%@\n, t5:%@\n, t6:%@\n",
          [path1 stringByAppendingString:@"123"],
          [path1 stringByAppendingPathExtension:@"123"],
          [path1 stringByAppendingPathComponent:@"123"],
          [path2 stringByAppendingString:@"123"],
          [path2 stringByAppendingPathExtension:@"123"],
          [path2 stringByAppendingPathComponent:@"123"]
          );
//t1:abc123
//    , t2:abc.123
//    , t3:abc/123
//    , t4:def123
//    , t5:def.123
//    , t6:def/123
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 隐藏系统的UITabBarButton
    NSArray* subViews =  self.tabBar.subviews;
    for (UIView* aSubView in subViews)
    {
        NSLog(@"SubView :%@\r", aSubView);
        NSLog(@"SubView superView :%@\r", aSubView.superclass);
        if ([aSubView isKindOfClass:[UIControl class]])
        {
            [aSubView removeFromSuperview];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)_setupTabBar
{
    SYTabBar* tabBar = [[SYTabBar alloc] init];
//    tabBar.backgroundColor = [UIColor redColor];
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
    self.customTabBar = tabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(SYTabBar *)tabBar didSelectedButtonFrom:(NSInteger)fromIndex to:(NSInteger)toIndex

{
    self.selectedIndex = toIndex;
}

- (void)_setAllSubViewControllers
{
    FirstTableViewController* first = [[FirstTableViewController alloc] init];
    first.tabBarItem.badgeValue = @"13";
    [self _setupSubViewController:first title:@"常用工具" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    SecondTableViewController* second = [[SecondTableViewController alloc] init];
    [self _setupSubViewController:second title:@"编码练习" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    ThirdTableViewController* third = [[ThirdTableViewController alloc] init];
    [self _setupSubViewController:third title:@"文档查看" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    FourthTableViewController* fourth = [[FourthTableViewController alloc] init];
    [self _setupSubViewController:fourth title:@"常用工具简介" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    
}

- (void)_setupSubViewController:(UIViewController *)subViewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1 视图控制器
    subViewController.title = title;
    
    subViewController.tabBarItem.image = [UIImage SYImageWithName:imageName];
    
    UIImage* selectedImage;
    
    if (SYIOS7)
    {
        selectedImage = [[UIImage SYImageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        selectedImage = [UIImage SYImageWithName:selectedImageName];
    }
    
    subViewController.tabBarItem.selectedImage = selectedImage;
    
    SYNavigationController* navi = [[SYNavigationController alloc] initWithRootViewController:subViewController];
    
    [self addChildViewController:navi];
    
    // 2 TabBar
    [self.customTabBar addTabBarButtonWithItem:subViewController.tabBarItem];
}

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
//{
//    NSLog(@"Transition to size: %f, %f\r", size.width, size.height);
//}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
//    [self.selectedViewController willRotateToInterfaceOrientation:interfaceOrientation duration:duration];
}
@end
