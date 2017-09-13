//
//  UIImage+CreatImageByColor.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/13.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "UIImage+CreatImageByColor.h"

@implementation UIImage (CreatImageByColor)

//颜色填充返回图片
+(UIImage *) createImageWithColor: (UIColor *) color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

@end
