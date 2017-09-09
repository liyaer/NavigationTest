//
//  UINavigationController+SetNavBarAlpha.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/9.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "UINavigationController+SetNavBarAlpha.h"

@implementation UINavigationController (SetNavBarAlpha)

-(void)setNavigationBarAlphaWithColor:(UIColor *)color andTintColor:(UIColor *)tintColor
{
    [self.navigationBar  setBackgroundImage:[self createImageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar  setShadowImage:[self createImageWithColor:color]];//去除下方的边框黑线
    [self.navigationBar  setTintColor:tintColor];
    [self.navigationBar  setTranslucent:YES];//想设置导航栏透明效果，必须开启YES
}

//颜色填充返回图片
-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
