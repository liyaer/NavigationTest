//
//  NextVC.m
//  NavigationTest
//
//  Created by 杜文亮 on 2017/9/9.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//


#import "SetNavBarAlphaVC.h"
#import "UINavigationController+SetNavBarAlpha.h"
#import "UIImage+CreatImageByColor.h"




#pragma mark - 类的扩展

@interface SetNavBarAlphaVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *pop;//为完全隐藏导航栏提供的返回按钮

@property (nonatomic,strong) UITableView *tableView;

@end




#pragma mark - 类的实现

@implementation SetNavBarAlphaVC

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

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}




#pragma mark - tableView dateSource and delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"du"];
    }
    cell.textLabel.text = @"实现导航栏颜色渐变";
    cell.imageView.image = [UIImage imageNamed:@"2"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma mark - 跟随滑动实现导航栏颜色渐变

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DLog(@"%f",scrollView.contentOffset.y);
    
    CGFloat minAlphaOffset = -64;
    CGFloat maxAlphaOffset = 60;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
}




#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}




#pragma mark - viewWillAppear------设置导航栏透明（可以响应Item点击事件，要求translucent = YES）

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*
     *            总结（根据具体需求看代码是放在【viewDidLoad】还是【viewWillAppear】）
     *   1，1、2只能设置导航栏透明效果；3可以通过alpha属性设置不同颜色、不同梯度的透明效果，3其实是2的升级版，本质是一样的
     *   2，由于是直接对于navigationBar的操作，所以在Push、Pop到其他的控制器,其他的控制器导航栏也是会变得透明,所以为了防止这类情况的发生,最好在【- (void)viewWillDisappear:(BOOL)animated】方法中,把导航栏的颜色还原过来
     */
    
    switch (self.index)
    {
        case 0:
        {
            //完全隐藏导航栏（无法响应Item点击事件，对于translucent无要求）
            self.navigationController.navigationBar.hidden = YES;
            [self.view addSubview:self.pop];
        }
            break;
        case 1:
        {
            //方式一（aView = self.navigationController.navigationBar.subviews.firstObject，这是简便写法，以后可以不用遍历，直接获取就行）
            for (UIView *aView in self.navigationController.navigationBar.subviews)
            {
                if ([aView isKindOfClass:NSClassFromString(@"_UIBarBackground")] || [aView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
                {
                    aView.hidden = YES;
                }
            }
        }
            break;
        case 2:
        {
            //方式二
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage new];//去除 navigationBar 底部的细线
        }
            break;
        case 3:
        {
            //方式三
            [self.navigationController setNavigationBarAlphaWithColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.2] andTintColor:[UIColor whiteColor]];
        }
            break;
        case 4:
        {
            [self.view addSubview:self.tableView];
            //为实现导航栏渐变色提供一个颜色
            self.navigationController.navigationBar.barTintColor = [UIColor brownColor];
        }
            break;
        default:
            break;
    }
}




#pragma mark - viewWillDisappear------恢复对导航栏的透明设置，防止影响其他的控制器

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
     *                                 总结
     *   方式一恢复对导航栏的透明设置，控制器切换时衔接完美；
     *   方式2、3会看到短暂的黑色，目前不知道如何优化，而且下面阴影线高度变高了，想要恢复原状，可以参考这片文章http://www.jianshu.com/p/55dc07c71609
     */
    
    switch (self.index)
    {
        case 0:
        {
            self.navigationController.navigationBar.hidden = NO;
        }
            break;
        case 1:
        {
            //方式一
            for (UIView *aView in self.navigationController.navigationBar.subviews)
            {
                if ([aView isKindOfClass:NSClassFromString(@"_UIBarBackground")] || [aView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
                {
                    aView.hidden = NO;
                }
            }
        }
            break;
        case 2: case 3:
        {
            //方式二、方式三
            [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor greenColor]] forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage createImageWithColor:[UIColor blackColor]];//去除 navigationBar 底部的细线
        }
            break;
        case 4:
        {
            //恢复导航栏颜色和子控件的透明度（效果不是很友好）
            self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
        }
            break;

        default:
            break;
    }
}




#pragma mark - 点击事件集合

-(void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
