//
//  SYTouchLockViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/24.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYTouchLockViewController.h"
#import "SYTouchLockView.h"
@interface SYTouchLockViewController ()<SYTouchLockViewDelegate>


@property (nonatomic, strong) SYTouchLockView* lockView;

@end

@implementation SYTouchLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _lockView = [[SYTouchLockView alloc] initWithFrame:CGRectMake(10, 100, 300, 400)];
    _lockView.delegate = self;
    [self.view addSubview:_lockView];

}

- (void)touchLockView:(SYTouchLockView *)lcokView didFinishPath:(NSString *)path
{
    NSLog(@"lockview:-----%@\n", path);
}

- (void)dealloc
{
    NSLog(@"SYTouchLockViewController dealloc\n");
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
