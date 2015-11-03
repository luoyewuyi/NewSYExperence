//
//  SYDynamicViewController.m
//  SYExperence
//
//  Created by yuhang on 15/9/30.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYDynamicViewController.h"

@interface SYDynamicViewController ()


@property (nonatomic, strong)   UIDynamicAnimator*  animator;

@property (nonatomic, strong)   UIView*             redView;

@end

@implementation SYDynamicViewController


- (UIDynamicAnimator *)animator
{
    if (!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UIGravityBehavior* behavior = [[UIGravityBehavior alloc] initWithItems:@[_redView]];
    
    [self.animator addBehavior:behavior];
}

@end
