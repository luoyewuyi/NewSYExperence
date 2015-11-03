//
//  SYPaintLinesView.h
//  SYExperence
//
//  Created by yuhang on 15/9/23.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 手指点击，触摸屏幕划线
 */
@interface SYPaintLinesView : UIView
{
    
}


/**
 * @brief   清空
 * @return
 */
- (void)clearUp;

/*
 * @brief   回退
 * return
 */
- (void)unDo;

/*
 * @brief   保存到相册
 * return
 */
- (void)saveToPhoneAlbum;

@end
