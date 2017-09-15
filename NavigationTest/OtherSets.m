//
//  OtherSets.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/15.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "OtherSets.h"




#pragma mark - 类的扩展

@interface OtherSets ()<UIGestureRecognizerDelegate>

@end




#pragma mark - 类的实现

@implementation OtherSets

#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    
#warning 【self.navigationController.interactivePopGestureRecognizer.delegate = self;//自定义了Item，滑动返回手势失效，设置其重新生效】，如果设置了全屏滑动返回，如果之前写过上面这段代码，务必删掉，会冲突，导致全屏返回失效
    //设置全屏滑动返回
    [self setFullScreenBackGes];
    
    //在改变了导航栏样式，实现了全屏滑动返回之后，我们有了一个看起来还不错的导航栏。但是我们滑动时的切换依然是系统自带的动画，如果遇到前一个界面的NavigationBar为透明或前后两个Bar颜色不一样，这种渐变式的动画看起来就会不太友好，尤其当前后两个界面其中一个界面的NavigationBar为透明或隐藏时，其效果更是惨不忍睹。
}




#pragma mark - 封装方法调用集合

/*
 *   原理:其实就是自定义一个全屏滑动手势，并将滑动事件设置为系统滑动事件，然后禁用系统滑动手势即可。handleNavigationTransition就是系统滑动的方法，虽然系统并未提供接口，但是我们我们可以通过runtime找到这个方法，因此直接调用即可。两位，不必担心什么私有API之类的问题，苹果如果按照方法名去判断是否使用私有API，那得误伤多少App。
 */
-(void)setFullScreenBackGes
{
    // 获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}



@end
