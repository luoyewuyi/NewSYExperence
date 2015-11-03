//
//  SYHandPaintViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/23.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYHandPaintViewController.h"
#import "SYPaintLinesView.h"
@interface SYHandPaintViewController ()

@property (strong, nonatomic) IBOutlet SYPaintLinesView *paintLinesView;
@end

@implementation SYHandPaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绘图";
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

- (IBAction)clearUp:(UIButton *)sender
{
    [_paintLinesView clearUp];
}

- (IBAction)undo:(UIButton *)sender
{
    [_paintLinesView unDo];
}

- (IBAction)saveImage:(UIButton *)sender
{
    [_paintLinesView saveToPhoneAlbum];
}
@end
