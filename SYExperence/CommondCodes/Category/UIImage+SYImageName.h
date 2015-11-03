//
//  UIImage+SYImageName.h
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 *  一   平铺的功能
 *      1 ）设置视图的背景为一张小图片，将进行平铺，可以利用这个特性，使视图显示一行一行的线
 *      2 ）通过图片上下文绘制图片，获取一张新的图片进行平铺
 *  二   截取图片中的部分图片
 */

@interface UIImage (SYImageName)

/**
 * @brief   加载图片
 * @param1  图片名称
 * @return
 */
+ (UIImage *)SYImageWithName:(NSString *)imageName;


/**
 * @brief   返回一张自由拉伸的图片
 * @param
 * @return
 */
+ (UIImage *)SYResizedImageWithName:(NSString *)imageName;

/**
 * @brief   返回水印图片
 * @param1  背景图片
 * @param2  水印图片
 * @return
 */
+ (UIImage *)SYWaterMarkerWithBackground:(UIImage *)backgroundImage waterMarker:(UIImage *)waterMarker;

/**
 * @brief   返回裁剪的图片
 * @param1  图片
 * @param2  内圆半径
 * @param3  宽度
 * @param4  颜色
 * @return
 */
+ (UIImage *)SYClipImage:(UIImage *)originalImage innerCircleRadius:(CGFloat)inRadius borderWidth:(CGFloat)borderWidth  borderColor:(UIColor *)borderColor;

/**
 * @brief   获取某个视图的截图
 * @param1  视图
 * @return
 */
+ (UIImage *)SYSnapshotOfView:(UIView *)view;
@end
