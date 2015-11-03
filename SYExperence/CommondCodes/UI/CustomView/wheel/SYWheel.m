//
//  SYWheel.m
//  SYExperence
//
//  Created by yuhang on 15/9/26.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYWheel.h"
#import "SYWheelButton.h"

@interface SYWheel ()
{
    
}


@property (strong, nonatomic)   IBOutlet        UIImageView *centerWheel;

@property (nonatomic, weak)     SYWheelButton* selectedBtn;

@property (nonatomic, strong)   CADisplayLink* link;

//
- (IBAction)startChoose:(UIButton *)sender;

@end


@implementation SYWheel

#pragma mark -
#pragma mark 初始化

+ (instancetype)wheel
{
    id nib = [[[NSBundle mainBundle] loadNibNamed:@"SYWheel" owner:nil options:nil] lastObject];
    return nib;
}

// nib初始化，会先调用initWithCoder（但是控件还没有加载好），awakeFromNib后才加载好
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)awakeFromNib
{
    // imageView默认不能进行用户交互
    self.centerWheel.userInteractionEnabled = YES;
    
    // 加载大图片
    UIImage *bigImage = [UIImage SYImageWithName:@"LuckyAstrology"];
    UIImage *bigImageSelected = [UIImage SYImageWithName:@"LuckyAstrologyPressed"];
    
    CGFloat smallW = bigImage.size.width/12*[UIScreen mainScreen].scale;
    CGFloat smallH = bigImage.size.height*[UIScreen mainScreen].scale;
    
    for (int index =0; index<12; index++)
    {
        SYWheelButton* btn = [SYWheelButton buttonWithType:UIButtonTypeCustom];
        
        CGRect smallRect = CGRectMake(index*smallW, 0, smallW, smallH);
        
        //
        CGImageRef smallImage = CGImageCreateWithImageInRect(bigImage.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        
        CGImageRef smallImageSelected = CGImageCreateWithImageInRect(bigImageSelected.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallImageSelected] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        btn.bounds = CGRectMake(0, 0, 68, 143);
        //        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        // 设置锚点和位置
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.centerWheel.frame.size.width * 0.5, self.centerWheel.frame.size.height * 0.5);
        
        // 设置旋转角度(绕着锚点进行旋转)
        CGFloat angle = (30 * index) / 180.0 * M_PI;
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.centerWheel addSubview:btn];
        
        if (index == 0) {
            [self btnClick:btn];
        }
    }
}

/**
 *  监听按钮点击
 */
- (void)btnClick:(SYWheelButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}



- (IBAction)startChoose:(UIButton *)sender
{
    [self stopRotating];
    //
    CABasicAnimation* animation = [[CABasicAnimation alloc] init];
    
    animation.duration = 2;
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(2*M_PI*3);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    
    [self.centerWheel.layer addAnimation:animation forKey:@"wheel"];
    
    self.userInteractionEnabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}

/*
 * @brief 开始
 * return
 */
- (void)startRotating
{
    if (_link)
    {
        return;
    }
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(wheelUpdate)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

/*
 * @brief 停止
 * return
 */
- (void)stopRotating
{
    [_link invalidate];
    _link = nil;
}

- (void)wheelUpdate
{
    _centerWheel.transform = CGAffineTransformRotate(_centerWheel.transform, M_PI_4/1000);
}
@end
