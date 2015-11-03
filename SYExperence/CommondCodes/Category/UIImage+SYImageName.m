//
//  UIImage+SYImageName.m
//  SYExperence
//
//  Created by yuhang on 15/8/29.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "UIImage+SYImageName.h"
#import <CoreFoundation/CoreFoundation.h>


@implementation UIImage (SYImageName)

/**
 * @brief   加载图片
 * @param1  图片名称
 * @return
 */
+ (UIImage *)SYImageWithName:(NSString *)imageName
{
    if (SYIOS7)
    {
        NSString* imageNameIos7 = [imageName stringByAppendingString:@"_os7"];
        UIImage*  image = [UIImage imageNamed:imageNameIos7];
        if (!image)
        {
            image = [UIImage imageNamed:imageName];
        }
        return image;
    }
    return [UIImage imageNamed:imageName];
}

/**
 * @brief   返回一张自由拉伸的图片
 * @param
 * @return
 */
+ (UIImage *)SYResizedImageWithName:(NSString *)imageName
{
    UIImage* image = [self SYImageWithName:imageName];
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
    return image;
}

/**
 * @brief   返回水印图片
 * @param1  背景图片
 * @param2  水印图片
 * @return
 */
+ (UIImage *)SYWaterMarkerWithBackground:(UIImage *)backgroundImage waterMarker:(UIImage *)waterMarker
{
    CGSize contextSize = backgroundImage.size;
    CGRect rcBackground = CGRectMake(0, 0, contextSize.width, contextSize.height);
    //
    CGFloat margin = 5;
    CGFloat waterMarkerW = contextSize.width/3;
    CGFloat waterMarkerH = contextSize.height/4;
    CGFloat waterMarkerX = contextSize.width - waterMarkerW - margin;
    CGFloat waterMarkerY = contextSize.height - waterMarkerH - margin;
    
    CGRect rcWaterMarker = CGRectMake(waterMarkerX, waterMarkerY, waterMarkerW, waterMarkerH);
    //
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 1.0);
    
    [backgroundImage drawInRect:rcBackground];
    
    [waterMarker drawInRect:rcWaterMarker];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 * @brief   返回裁剪的图片
 * @param1  外圆半径
 * @param2  内圆半径
 * @param3  图片
 * @param4  颜色
 * @return
 */
+ (UIImage *)SYClipImage:(UIImage *)originalImage innerCircleRadius:(CGFloat)inRadius borderWidth:(CGFloat)borderWidth  borderColor:(UIColor *)borderColor
{
    // 1 开启上下文
    CGFloat imageW = originalImage.size.width;
    CGFloat imageH = originalImage.size.height;
    CGSize  imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 2 取得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 3 画大圆
    [borderColor set];
    CGFloat exRadius = inRadius+borderWidth;
    CGFloat centerX = imageW/2;
    CGFloat centerY = imageH/2;
    CGContextAddArc(context, centerX, centerY, exRadius, 0, M_PI_2, 0);
    CGContextFillPath(context);
    
    // 4 小圆
    CGContextAddArc(context, centerX, centerY, inRadius, 0, M_PI_2, 0);
    CGContextClip(context);
    
    // 5 画图
    [originalImage drawInRect:CGRectMake(0, 0, imageW, imageH)];
    
    // 6 取图
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 * @brief   获取某个视图的截图
 * @param1  视图
 * @return
 */
+ (UIImage *)SYSnapshotOfView:(UIView *)view
{
    //
    CGSize imageSize = view.frame.size;
    //
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
