//
//  SYCoreAnimationViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/25.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYCoreAnimationViewController.h"

@interface SYCoreAnimationViewController ()


@property (nonatomic, strong)   UIView* redView;

@property (nonatomic, strong)   NSTimer* viewTime;

@end

@implementation SYCoreAnimationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSBundle mainBundle] loadNibNamed:nil owner:nil options:nil];
    
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
    
    _redView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 200, 80, 30);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"开始" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btn1Cliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(160, 200, 80, 30);
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setTitle:@"开始" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.text = @"开始";
    btn2.tag = 1;
    [btn2 addTarget:self action:@selector(btn2Cliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    // 1 CABasicAnimation(只能两个值之间)
    [self _addLayer];
    
    // 2 CAKeyframeAnimation
    
}

- (void)btn1Cliked:(UIButton *)button
{
    [_redView.layer removeAnimationForKey:@"redView"];
    
    CAKeyframeAnimation* animation = [[CAKeyframeAnimation alloc] init];
    
    animation.keyPath = @"transform.rotation.z";
    
    NSValue* pos1 = @(SYAngleToRadian(-5));
    NSValue* pos2 = @(SYAngleToRadian(5));
    
    animation.values = @[pos1, pos2, pos1];
    
    animation.duration = 0.5;
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    [_redView.layer addAnimation:animation forKey:@"redView"];
}

- (void)btn2Cliked:(UIButton *)button
{
    [_redView.layer removeAnimationForKey:@"redView"];
}
#pragma mark -
#pragma mark basic
- (void)_addLayer
{
    CALayer* layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 200);
    layer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    [self _addBasicAnimation:layer];
}


- (void)_addBasicAnimation:(CALayer *)layer
{
    // 1 create
    CABasicAnimation* animation = [[CABasicAnimation alloc] init];
    // 2 set
    animation.duration = 2;
    
    // 指定动画对象
    animation.keyPath = @"position";
    
    // byValue 是相对原值改变
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    
    // 两个属性联合使用，才能使图层保持动画结束后的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    animation.delegate = self;
    
    // 3 提交动画
    [layer addAnimation:animation forKey:nil];
}

#pragma mark -
- (void)_addKeyframeAnimation1:(CALayer *)layer
{
    CAKeyframeAnimation* animation = [[CAKeyframeAnimation alloc] init];
    
    animation.keyPath = @"position";
    
    NSValue* pos1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue* pos2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue* pos3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue* pos4 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    
    animation.values = @[pos1, pos2, pos3, pos4, pos1];
    
    animation.duration = 3;
    
    [layer addAnimation:animation forKey:nil];
}

- (void)_addKeyframeAnimation2:(CALayer *)layer
{
    CAKeyframeAnimation* animation = [[CAKeyframeAnimation alloc] init];
    
    animation.keyPath = @"position";
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(100, 100, 100, 100));
    animation.path = path;
    CGPathRelease(path);
    
    animation.duration = 3;
    
    [layer addAnimation:animation forKey:nil];
}

// 抖动效果
- (void)_addkeyframeAnimation3:(CALayer *)layer
{
    int random = arc4random()%10;
    CGFloat angle = random*M_PI/180.0;
    
    CAKeyframeAnimation* animation = [[CAKeyframeAnimation alloc] init];
    
    animation.keyPath = @"transform.rotation.z";
    
    NSValue* pos1 = @(angle);
    NSValue* pos2 = @(0);
    NSValue* pos3 = @(-angle);
    NSValue* pos4 = @(0);
    
    animation.values = @[pos1, pos2, pos3, pos4];
    
    animation.duration = 0.5;
    
    [layer addAnimation:animation forKey:nil];
}

#pragma mark -
#pragma mark CATransition(页面过渡)
- (void)_addTransitionAnimation:(CALayer *)layer
{
    CATransition* animation = [[CATransition alloc] init];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromLeft;
    
    [layer addAnimation:animation forKey:nil];
    
    return;
    
    /*
     * 对应的UIView的操作
     */
//    UIView transitionFromView:(UIView *) toView:(UIView *) duration:(NSTimeInterval) options:(UIViewAnimationOptions) completion:^(BOOL finished)
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_viewTime == nil)
    {
        _viewTime = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeCallback) userInfo:nil repeats:YES];
    }

//    [self _addKeyframeAnimation1:_redView.layer];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self _addKeyframeAnimation2:_redView.layer];
//    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_viewTime) {
        [_viewTime invalidate];
        _viewTime = nil;
    }
}

- (void)timeCallback
{
    [self _addkeyframeAnimation3:_redView.layer];
}
#pragma mark -
#pragma mark delegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}
@end
