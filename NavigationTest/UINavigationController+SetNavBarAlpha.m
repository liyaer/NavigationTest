//
//  UINavigationController+SetNavBarAlpha.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/9.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "UINavigationController+SetNavBarAlpha.h"
#import "UIImage+CreatImageByColor.h"

@implementation UINavigationController (SetNavBarAlpha)

-(void)setNavigationBarAlphaWithColor:(UIColor *)color andTintColor:(UIColor *)tintColor
{
    [self.navigationBar  setBackgroundImage:[UIImage createImageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar  setShadowImage:[UIImage createImageWithColor:color]];//去除下方的边框黑线
    
    [self.navigationBar  setTintColor:tintColor];
    [self.navigationBar  setTranslucent:YES];//想设置导航栏透明效果，必须开启YES
}

@end
