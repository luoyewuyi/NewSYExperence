//
//  SYCALayerDemoViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/25.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//
// View的完整显示过程
/*
 1 view.layer会准备一个Layer Graphics Context（图层类型的上下文）
   注意内部函数- (void)drawInContext:(CGContextRef)ctx需要setNeadDisplay
 2 调用view.layer.delegate（view）的drawLayer:inContext:, 并传入刚才准备好的上下文
 3 drawLayer:inContext:方法内部又会调用drawRect:方法
 4 view就可以在drawRect:方法中实现绘制代码，所有东西最终都绘制到view.layer上面
 5 系统再将view.layer的内容拷贝到屏幕，于是完成了view的显示
 */


/*
 1 CALayer 的基本属性
 2 CALayer和UIView的关系
 3 CALayer使用CG不使用UI的疑惑
 4 隐式动画
 */

/* 1
 在iOS中，你能看得见摸得着的东西基本上都是UIView，比如一个按钮、一个文本标签、一个文本输入框、一个图标等等，这些都是UIView
 
 其实UIView之所以能显示在屏幕上，完全是因为它内部的一个图层
 
 在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，通过UIView的layer属性可以访问这个层
 @property(nonatomic,readonly,retain) CALayer *layer;
 
 当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示
 
 换句话说，UIView本身不具备显示的功能，是它内部的层才有显示功能
 */

/* 3
 CALayer是定义在QuartzCore框架中的
 CGImageRef、CGColorRef两种数据类型是定义在CoreGraphics框架中的
 UIColor、UIImage是定义在UIKit框架中的
 */

/* 4
 可以通过动画事务(CATransaction)关闭默认的隐式动画效果
 [CATransaction begin];
 [CATransaction setDisableActions:YES];
 self.myview.layer.position = CGPointMake(10, 10);
 [CATransaction commit];

 */
#import "SYCALayerDemoViewController.h"
#import "SYCustomLayer.h"

@interface SYCALayerDemoViewController ()
{
    
}

@end

@implementation SYCALayerDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _layerDemo];
}

- (void)_layerDemo
{
    [self _uiviewLayerDemo];
    
    [self _customLayer];
    
    [self _transform];
}

/*
  基本调用
 */
- (void)_uiviewLayerDemo
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    //
    view.layer.borderWidth = 10;
    view.layer.backgroundColor = [UIColor redColor].CGColor;
    view.layer.borderColor = [UIColor greenColor].CGColor;
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds  = NO;                            // 超出不显示标志
    
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.layer.shadowColor = [UIColor redColor].CGColor;
    view.layer.shadowOpacity = 0.5;
}

/*
  自定义Layer
 */
- (void)_customLayer
{
//    CALayer* layer =[[CALayer alloc] init];
//    layer.backgroundColor = [UIColor blackColor].CGColor;
//    layer.bounds = CGRectMake(0, 0, 80, 80);
//    layer.position = CGPointMake(140, 240);
//    [self.view.layer addSublayer:layer];
    SYCustomLayer* layer= [[SYCustomLayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 80, 80);
    layer.position = CGPointMake(140, 240);
//    layer.delegate = self;
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

/* If defined, called by the default implementation of -drawInContext: */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    int i = 0;
    i++;
}

/*
 transform
 1 view使用的是2D的transform， layer使用的是3D的transform
 2
 */
- (void)_transform
{
    UIView* aView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [self.view addSubview:aView];
    aView.backgroundColor = [UIColor blueColor];
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        aView.layer.transform = CATransform3DMakeRotation(M_PI/4, 1, 1, 0);
    });
    // 搜索CATransform key path
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [aView.layer setValue:@(0.5) forKeyPath:@"transform.scale.x"];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [aView.layer setValue:@(10.0) forKeyPath:@"transform.translation.x"];
        
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [aView.layer setValue:[NSNumber numberWithFloat:10.0] forKeyPath:@"transform.translation.y"];
    });
    
    
}


@end
