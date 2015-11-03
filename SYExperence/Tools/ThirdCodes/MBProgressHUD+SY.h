//
//  MBProgressHUD+SY.h
//  SYExperence
//
//  Created by yuhang on 15/9/16.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (SY)
{
    
}


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
