//
//  SYSystemFunctionViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/22.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYSystemFunctionViewController.h"

#import "SYSystemFunction.h"
#import "SYBaseTableViewKit.h"

#import "SYStrongView.h"

@interface SYSystemFunctionViewController ()
{
    
}

@property (nonatomic, strong) SYStrongView* strongView;

@end

@implementation SYSystemFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addGroup0];
    self.title = @"系统功能";
    //
    _strongView = [[SYStrongView alloc] init];
    _strongView.backgroundColor = [UIColor greenColor];
    _strongView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_strongView];
    //
    SYStrongView* subView = [[SYStrongView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    subView.backgroundColor = [UIColor redColor];
    subView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [_strongView addSubview:subView];
    
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        CGRect rc = _strongView.frame;
//        [_strongView setFrame:CGRectMake(10, 10, 150, 150)];
        NSLog(@"strongView rc: %@\n", NSStringFromCGRect(rc));
    });
    return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(10, 10, 160, 160)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(10, 10, 170, 170)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(10, 10, 180, 190)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(20, 10, 200, 100)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(20, 10, 200, 110)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(11 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(20, 10, 200, 120)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(20, 10, 200, 130)];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(13 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_strongView setFrame:CGRectMake(20, 10, 200, 130)];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addGroup0
{
    SYBaseGroup* group = [[SYBaseGroup alloc] init];
    __weak typeof(self) weakVc = self;
    // 打电话
    SYBaseItem* item1 = [SYBaseArrowItem itemWithTitle:@"直接打电话" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] callWithNumber:@"10086"];
        [weakVc _testBlockReference];
    }];
    
    SYBaseItem* item2 = [SYBaseArrowItem itemWithTitle:@"打电话提示框(prompt)" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] showCallPromptWithNumber:@"10086" backApp:NO];
    }];
    
    SYBaseItem* item3 = [SYBaseArrowItem itemWithTitle:@"打电话提示框(webView)" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] showCallPromptWithNumber:@"10086" backApp:YES];
    }];
    
    // 发消息
    SYBaseItem* item4 = [SYBaseArrowItem itemWithTitle:@"发消息一" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] messageWithNumber:@"10086"];
    }];
    
    SYBaseItem* item5 = [SYBaseArrowItem itemWithTitle:@"发消息二(可返回)" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] messageWithNumber:@"10086" presentBy:weakVc];
    }];
    // 发邮件
    SYBaseItem* item6 = [SYBaseArrowItem itemWithTitle:@"发邮件" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] mailWithAddress:@"yuhang.li@alibaba-inc.com" presentBy:weakVc];
    }];
    // 打开其他程序
    SYBaseItem* item7 = [SYBaseArrowItem itemWithTitle:@"打开淘宝" iconStr:nil action:^{
        [[SYSystemFunction sharedInstance] openAppWithUrl:@"taobao://"];
    }];
    
    group.headTitle = @"系统功能调用";
    
    group.items = (NSMutableArray *) @[item1, item2, item3, item4, item5, item6, item7];
    
    [self.data addObject:group];
    
}

- (void)_testBlockReference
{
    NSLog(@"blockReference\n");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)dealloc
{
    NSLog(@"SYSystemFunctionViewController dealloc -----!\n");
}
@end
