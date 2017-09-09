//
//  NextVC.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/9.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "NextVC.h"

@interface NextVC ()

@property (nonatomic,strong) UIButton *pop;

@end




@implementation NextVC

#pragma mark - 懒加载

-(UIButton *)pop
{
    if (!_pop)
    {
        _pop = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
        [_pop setTitle:@"pop" forState:UIControlStateNormal];
        [_pop addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pop;
}




#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pop];
    
    //方式一：完全隐藏导航栏，不可点击（对于translucent无要求）
//    self.navigationController.navigationBar.hidden = YES;
}




//方式二：部分隐藏导航栏，可以点击（要求translucent = YES，才会看到透明效果；否则会是黑色）
#pragma mark - viewWillAppear

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *aView in self.navigationController.navigationBar.subviews)
    {
        if ([aView isKindOfClass:NSClassFromString(@"_UIBarBackground")] || [aView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
        {
            aView.hidden = YES;
        }
    }
}
#pragma mark - viewWillDisappear

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView *aView in self.navigationController.navigationBar.subviews)
    {
        if ([aView isKindOfClass:NSClassFromString(@"_UIBarBackground")] || [aView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
        {
            aView.hidden = NO;
        }
    }
}




#pragma mark - 点击事件集合

-(void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
