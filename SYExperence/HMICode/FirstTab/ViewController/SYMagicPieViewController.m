//
//  SYMagicPieViewController.m
//  SYExperence
//
//  Created by yuhang on 15/10/13.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYMagicPieViewController.h"
#import "Example2PieView.h"
@interface SYMagicPieViewController ()

@end

@implementation SYMagicPieViewController

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Example2PieView* pie = [[Example2PieView alloc] init];
    pie.frame = CGRectMake( 0, 100, 320, 250);
    pie.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pie];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    MyPieElement *ele1 = [MyPieElement pieElementWithValue:1000.0 color:[UIColor redColor]];
    ele1.title = @"房租";
    
    MyPieElement *ele2 = [MyPieElement pieElementWithValue:100.0 color:[UIColor blueColor]];
    ele2.title = @"水电";
    
    
    [pie.layer addValues:@[ele1] animated:YES];
    [pie.layer addValues:@[ele2] animated:YES];
    
    
    // 设置每一块标题的内容
    pie.layer.transformTitleBlock = ^(PieElement* elem, float percent){
        MyPieElement *myele = (MyPieElement *)elem;
        NSString* title = [NSString stringWithFormat:@"%@, %0.1f", myele.title, percent];
        return title;
    };
    
    
    // 设置每一块的标题的显示样式
    pie.layer.showTitles = ShowTitlesAlways;
}



@end
