//
//  SetNavItemVC.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/14.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "SetNavItemVC.h"




#pragma mark - 类的扩展

@interface SetNavItemVC ()<UIGestureRecognizerDelegate>

@end




#pragma mark - 类的实现

@implementation SetNavItemVC

#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    
    switch (self.index)
    {
        case 0: [self setTitleColor1]; break;
        case 1: [self setTitleColor2]; break;
        case 2: [self setSpace1]; break;
        case 3: [self setSpace2]; break;
        case 4: [self setSpace3]; break;
        case 5: self.navigationItem.prompt = @"prompt增加30px,好像很少用"; break;
        default:break;
    }
    
    //自定义了Item，滑动返回手势失效，设置其重新生效
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

//修改title的颜色
-(void)setTitleColor1//对Bar的设置，全局生效
{
    self.title = @"测试tintColor";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];//通过富文本改变title颜色
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];//证明对title无效,对Item有效
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];//改变背景色（注意：这种写法设置alpha无法达到导航栏透明的效果）
}
-(void)setTitleColor2//对Item的设置，仅对该VC生效
{
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [settingButton addTarget:self action:@selector(rItemClick) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 44.0)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:settingButton];
    
    self.navigationItem.titleView = view;//通过设置自定义的titleView修改title颜色
}

/*
 *   设置item距离边缘距离的三种方式，其中第三种是前两种的综合优化，最优
 
 *   1，视觉效果法，影响用户体验             2，真正的符合要求
 
 *   分析：一般常见的Item类型主要有：文字、图片、图文、多个Item。其中文字和图片可以使用系统提供的【initWithImage】和【initWithTitle】来快速构建，但是通过这两种方式创建的Item的缺点比较多：
 --图片大小必须合适，过大的话会不正常。（高度不得超过44，宽度也不得超过某个数值）
 --图片，文字无法保持本身的颜色，都会显示系统蓝。虽然可以通过    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
 来修改文字、图片颜色，但是图片仅限于那种线框图如"<"类型的
 --点击范围不仅仅限于文字、图片的大小，会向右、向左扩大。（明明没点击到文字、或图片，也会响应点击）
 
 *   为了解决上述问题，诞生了第三种。（使用 initWithCustomView:构造item，因为这样可以自定义更多操作）
 1，方法一用来构造一个或者多个item，然后将多个item加到一层间接父试图上（就1个item的话就不用加间接父试图了，间接父试图用来调节多个item之间的距离）
 2，方法2用来调节距左边框、右边框的距离
 3，添加手势，规划点击范围
 
 */
-(void)setSpace1
{
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //修改按钮向右偏移20 point
    [settingButton setFrame:CGRectMake(20.0, 0.0, 44.0, 44.0)];
    [settingButton addTarget:self action:@selector(rItemClick) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    [view addSubview:settingButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}
-(void)setSpace2
{
    //leftItem
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = -16;// 设置边框距离，个人习惯设为-16，可以根据需要调节
    self.navigationItem.leftBarButtonItems = @[fixedItem, leftItem];
    
    //rightItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1"] style:UIBarButtonItemStylePlain target:self action:@selector(rItemClick)];
    self.navigationItem.rightBarButtonItems = @[fixedItem, rightItem];
}
-(void)setSpace3
{
    //1,使用initWithCustomView构造多样化的Item
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(40.0, 12.0, 20.0, 20.0)];
    image.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1@2x" ofType:@"png"]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 44.0)];
    view.backgroundColor = [UIColor orangeColor];
    [view addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor greenColor];
    label.text = @"哈哈";
    [view addSubview:label];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    //2，调整间距
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixItem.width = -16;
    
    self.navigationItem.rightBarButtonItems = @[fixItem,rightItem];
    
    //3，添加手势，实现点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rItemClick)];
    [view addGestureRecognizer:tap];
}




#pragma mark - 点击事件集合

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"tintColor 对title无效，对left、right Item 有效！");
}

-(void)rItemClick
{
    NSLog(@"这种方法的本质：父视图未设置clipToBounds = YES，子视图部分内容可以显示在父试图frame之外，从而达到视觉上的效果。\n缺点：超出父视图部分无法响应点击事件，所以如果修改的距离过大，会导致用户点击的有效区域变小");
}


@end
