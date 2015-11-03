//
//  SYBigWheelViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/26.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYBigWheelViewController.h"
#import "SYWheel.h"


@interface SYBigWheelViewController ()

@end

@implementation SYBigWheelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SYWheel* wheel = [SYWheel wheel];
    wheel.frame = CGRectMake(10, 100, 300, 300);
    [self.view addSubview:wheel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
