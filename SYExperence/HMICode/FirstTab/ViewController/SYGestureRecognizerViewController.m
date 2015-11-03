//
//  SYGestureRecognizerViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/24.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYGestureRecognizerViewController.h"

@interface SYGestureRecognizerViewController ()<UIGestureRecognizerDelegate>
{
    
}


@property (nonatomic, strong)   UIImageView* imageView;

@end

@implementation SYGestureRecognizerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageView = [[UIImageView alloc] initWithImage:[UIImage SYResizedImageWithName:@"minion"]];
    
    _imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:_imageView];
    
    _imageView.frame = CGRectMake(10, 150, 300, 200);
    //
    [self _testGesture];
    
}


- (void)_testGesture
{
    [self _addPanGesture];
    [self _addPinchGesture];
    [self _addRotateGesture];
}


#pragma mark -
#pragma mark pan
- (void)_addPanGesture
{
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    [_imageView addGestureRecognizer:pan];
    pan.delegate = self;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer
{
    CGPoint pos = [recognizer translationInView:recognizer.view];
    //
    CGPoint center = _imageView.center;
    center.x += pos.x;
    center.y += pos.y;
    
    _imageView.center = center;
    
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
//        代码实现解析：
//        1 计算速度向量的长度（估计大部分都忘了）这些知识了。
//        2 如果速度向量小于200，那就会得到一个小于的小数，那么滑行会很短
//        3 基于速度和速度因素计算一个终点
//        4 确保终点不会跑出父View的边界
//        5 使用UIView动画使view滑动到终点
    }
}

#pragma mark -
#pragma mark rotate
- (void)_addRotateGesture
{
    UIRotationGestureRecognizer* rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureRecongnizerAction:)];
    [_imageView addGestureRecognizer:rotation];
    rotation.delegate = self;
}

- (void)rotationGestureRecongnizerAction:(UIRotationGestureRecognizer *)recongnizer
{
    CGFloat rotation = recongnizer.rotation;
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotation);
    // 注意置位操作
    recongnizer.rotation = 0;
}
#pragma mark -
#pragma mark pinch
- (void)_addPinchGesture
{
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognizerAction:)];
    [_imageView addGestureRecognizer:pinch];
    pinch.delegate = self;
}

- (void)pinchGestureRecognizerAction:(UIPinchGestureRecognizer *)recongnizer
{
    CGFloat scale = recongnizer.scale;
    _imageView.transform = CGAffineTransformScale(_imageView.transform, scale, scale);
    // 注意置位操作
    recongnizer.scale = 1;
}

#pragma mark -
#pragma mark delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark -
#pragma mark 计算速度

@end
