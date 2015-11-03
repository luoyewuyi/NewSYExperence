//
//  SYTouchLockView.h
//  SYExperence
//
//  Created by yuhang on 15/9/24.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYTouchLockView;

@protocol SYTouchLockViewDelegate <NSObject>

- (void)touchLockView:(SYTouchLockView *)lcokView didFinishPath:(NSString *)path;

@end




@interface SYTouchLockView : UIView
{
    
}

@property (nonatomic, weak) id<SYTouchLockViewDelegate> delegate;

@end
