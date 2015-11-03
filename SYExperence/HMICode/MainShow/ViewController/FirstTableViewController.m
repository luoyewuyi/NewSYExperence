//
//  FirstTableViewController.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "FirstTableViewController.h"
#import "SYBaseTableViewKit.h"
#import "MBProgressHUD+SY.h"




#import "MBHUDView.h"

// map data
#import "SYMapDataTool.h"
// ViewController
#import "SYAppListCollectionViewController.h"
#import "SYSystemFunctionViewController.h"
#import "SYHandPaintViewController.h"
#import "SYTouchLockViewController.h"
#import "SYGestureRecognizerViewController.h"
#import "SYCALayerDemoViewController.h"
#import "SYCoreAnimationViewController.h"
#import "SYBigWheelViewController.h"
#import "SYWebViewController.h"
#import "SYDynamicViewController.h"

@interface FirstTableViewController ()
{
    
}


@end

@implementation FirstTableViewController

#pragma mark - 
#pragma mark 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGroup0];
    [self addGroup1];
    //
    
}


- (void)addGroup1
{
    SYBaseGroup* group0 = [[SYBaseGroup alloc] init];
    
    SYBaseItem* item0 = [SYBaseArrowItem itemWithTitle:@"MBAlertView" iconStr:@"tabbar_home_selected" action:^{
        [self _testMBAlertView];
    }];
    SYBaseItem* item1 = [SYBaseArrowItem itemWithTitle:@"CollectionView" iconStr:@"tabbar_home_selected" action:^{
        SYAppListCollectionViewController* vc = [[SYAppListCollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    SYBaseItem* item2 = [SYBaseSwitchItem itemWithTitle:@"Switch" iconStr:@"tabbar_home_selected" action:nil];
    SYBaseItem* item3 = [SYBaseArrowItem itemWithTitle:@"请求" iconStr:@"tabbar_home_selected" action:^{
        //
        [MBProgressHUD showMessage:@"正在拼命检查中....."];
        
#warning 发送网络请求
        // 几秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除HUD
            [MBProgressHUD hideHUD];
            
            // 提醒有没有新版本
            [MBProgressHUD showError:@"没有新版本"];
        });
        [[SYMapDataTool sharedInstance] getMapDataListFromServer];
    }];
    
    group0.items = (NSMutableArray *)@[item0, item1, item2, item3];
    
    [self.data addObject:group0];
}

- (void)addGroup0
{
    __weak typeof(self) weakVc = self;
    
    SYBaseGroup* group1 = [[SYBaseGroup alloc] init];
    
    SYBaseItem* item0 = [SYBaseArrowItem itemWithTitle:@"调用系统功能" iconStr:@"tabbar_home_selected" action:^{
        [weakVc _pushSystemFunctionViewController];
    }];
    SYBaseItem* item1 = [SYBaseArrowItem itemWithTitle:@"触摸划线和保存图片" iconStr:@"tabbar_home_selected" action:^{
        SYHandPaintViewController* vc = [[SYHandPaintViewController alloc] initWithNibName:@"SYHandPaintViewController" bundle:nil];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    //
    SYBaseItem* item2 = [SYBaseArrowItem itemWithTitle:@"手势加密" iconStr:@"tabbar_home_selected" action:^{
        SYTouchLockViewController* vc = [[SYTouchLockViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    //
    SYBaseItem* item3 = [SYBaseArrowItem itemWithTitle:@"手势识别" iconStr:@"tabbar_home_selected" action:^{
        SYGestureRecognizerViewController* vc = [[SYGestureRecognizerViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    //
    SYBaseItem* item4 = [SYBaseArrowItem itemWithTitle:@"CALayer Demo" iconStr:@"tabbar_home_selected" action:^{
        SYCALayerDemoViewController* vc = [[SYCALayerDemoViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    //
    SYBaseItem* item5 = [SYBaseArrowItem itemWithTitle:@"核心动画" iconStr:@"tabbar_home_selected" action:^{
        SYCoreAnimationViewController* vc = [[SYCoreAnimationViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    //
    SYBaseItem* item6 = [SYBaseArrowItem itemWithTitle:@"大转盘" iconStr:@"tabbar_home_selected" action:^{
        SYBigWheelViewController* vc = [[SYBigWheelViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    //
    SYBaseItem* item7 = [SYBaseArrowItem itemWithTitle:@"WebView" iconStr:@"tabbar_home_selected" action:^{
        SYWebViewController* vc = [[SYWebViewController alloc] init];
//        NSURL* url = [[NSURL alloc] initWithString:@"http://www.163.com"];
//        vc.webviewUrl = url;
        NSString* homeDirect = NSHomeDirectory();
        // 通讯录.pptx
        NSURL* url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Documents/通讯录.pptx", homeDirect]];
//        NSURL* url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Documents/The Swift Programming Language.pdf", homeDirect]];
        vc.webviewUrl = url;
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    
    SYBaseItem* item8 = [SYBaseArrowItem itemWithTitle:@"Dynamic" iconStr:@"tabbar_home_selected" action:^{
        SYDynamicViewController* vc = [[SYDynamicViewController alloc] init];
        [weakVc.navigationController pushViewController:vc animated:YES];
    }];
    
    SYBaseItem* item9 = [SYBaseArrowItem itemWithTitle:@"饼状图" iconStr:@"tabbar_home_selected" action:^{
        Class vcClass = NSClassFromString(@"SYMagicPieViewController");
        [weakVc.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
    }];
    
    
    group1.items = (NSMutableArray *)@[item0, item1, item2, item3, item4, item5, item6, item7, item8, item9];
    
    [self.data addObject:group1];
}

- (void)_pushSystemFunctionViewController
{
    SYSystemFunctionViewController* vc = [[SYSystemFunctionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_testMBAlertView
{
    [MBHUDView hudWithBody:@"Hello" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
    MBAlertView *alert = [MBAlertView alertWithBody:@"Do you want to see more? (Note: you don't have a choice)" cancelTitle:nil cancelBlock:nil];
    [alert addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
        [MBHUDView hudWithBody:@"Say please" type:MBAlertViewHUDTypeExclamationMark hidesAfter:1.5 show:YES];
        MBAlertView *please = [MBAlertView alertWithBody:@"Did you say please?" cancelTitle:nil cancelBlock:nil];
        please.size = CGSizeMake(320, 180);
        [please addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
            
            [MBHUDView hudWithBody:@"Good boy." type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
            [MBHUDView hudWithBody:@"Wait." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:4.0 show:YES];
            [MBHUDView hudWithBody:@"Ready?" type:MBAlertViewHUDTypeDefault hidesAfter:2.0 show:YES];
            
            MBAlertView *destruct = [MBAlertView alertWithBody:@"Do you want your device to self-destruct?" cancelTitle:nil cancelBlock:nil];
            destruct.imageView.image = [UIImage imageNamed:@"image.png"];
            [destruct addButtonWithText:@"Yes please" type:MBAlertViewItemTypeDestructive block:^{
                [MBHUDView hudWithBody:@"Ok" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"5" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"4" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"3" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"2" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"1" type:MBAlertViewHUDTypeDefault hidesAfter:2.0 show:YES];
                [self doSomething:^{
                    MBHUDView *hud = [MBHUDView hudWithBody:@"Goodbye" type:MBAlertViewHUDTypeExclamationMark hidesAfter:2.0 show:YES];
                    hud.uponDismissalBlock = ^{
                        [UIView animateWithDuration:0.5 animations:^{ [self.view setBackgroundColor:[UIColor blackColor]]; }];
                    };
                } afterDelay:2.0];
            }];
            [destruct addToDisplayQueue];
            
        }];
        [please addToDisplayQueue];
    }];
    [alert addToDisplayQueue];
}

-(void)doSomething:(id)block afterDelay:(float)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        ((void (^)())block)();
    });
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.strongView = [[SYStrongView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    
//    [self.view addSubview:self.strongView];
//    
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
////#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 10;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString* reusedIdentifier = @"FirstTableViewCell";
//    UITableViewCell *cell =
//    [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedIdentifier];
//    }
//    // Configure the cell...
//    cell.textLabel.text = @"title";
//    return cell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FirstTableViewController* viewController = [[FirstTableViewController alloc] init];
//    // animated
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////    Fade = 1,                   //淡入淡出
////    Push,                       //推挤
////    Reveal,                     //揭开
////    MoveIn,                     //覆盖
////    Cube,                       //立方体
////    SuckEffect,                 //吮吸
////    OglFlip,                    //翻转
////    RippleEffect,               //波纹
////    PageCurl,                   //翻页
////    PageUnCurl,                 //反翻页
////    CameraIrisHollowOpen,       //开镜头
////    CameraIrisHollowClose,      //关镜头
////    CurlDown,                   //下翻页
////    CurlUp,                     //上翻页
////    FlipFromLeft,               //左翻转
////    FlipFromRight,              //右翻转
//    transition.type = @"pageCurl";//kCATransitionReveal;
////    transition.subtype = kCATransitionFromTop;
////    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    //
//    [self.navigationController pushViewController:viewController animated:YES];
////    [[SYMapDataTool sharedInstance] getMapDataListFromServer];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
