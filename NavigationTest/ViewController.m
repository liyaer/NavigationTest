//
//  ViewController.m
//  NavigationTest
//
//  Created by 杜文亮 on 17/7/15.
//  Copyright © 2017年 Company-DWL（公司名）. All rights reserved.
//

#import "ViewController.h"
#import "SetNavItemVC.h"
#import "SetNavBarAlphaVC.h"
#import "OtherSets.h"



#pragma mark - 类的扩展

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *ItemSets;

@property (nonatomic,strong) NSArray *BarSets;

@property (nonatomic,strong) NSArray *Others;

@end




#pragma mark - 类的实现

@implementation ViewController

#pragma mark - 懒加载

-(NSArray *)ItemSets
{
    if (!_ItemSets)
    {
        _ItemSets = @[@"修改NavItem中的title的颜色：系统默认",@"修改NavItem中的title的颜色：自定义",@"修改R、L-Item距离边缘的距离：方式一",@"修改R、L-Item距离边缘的距离：方式二",@"修改R、L-Item距离边缘的距离：方式三",@"设置prompt增加30px,好像很少用"];
    }
    return _ItemSets;
}

-(NSArray *)BarSets
{
    if (!_BarSets)
    {
        _BarSets = @[@"完全隐藏Bar",@"使Bar变透明：方式一",@"使Bar变透明：方式二",@"使Bar变透明：方式三",@"导航栏颜色渐变"];
    }
    return _BarSets;
}

-(NSArray *)Others
{
    if (!_Others)
    {
        _Others = @[@"设置全屏滑动返回"];
    }
    return _Others;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}




#pragma mark - tableView dateSource and delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return self.ItemSets.count; break;
        case 1: return self.BarSets.count; break;
        case 2: return self.Others.count; break;
        default: return 0; break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"du"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    switch (indexPath.section)
    {
        case 0: cell.textLabel.text = self.ItemSets[indexPath.row]; break;
        case 1: cell.textLabel.text = self.BarSets[indexPath.row]; break;
        case 2: cell.textLabel.text = self.Others[indexPath.row]; break;
        default:break;
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return @"对Navigation-Item的相关设置"; break;
        case 1: return @"对Navigation-Bar的相关设置"; break;
        case 2: return @"Others"; break;
        default: return nil; break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            SetNavItemVC *vc = [[SetNavItemVC alloc] init];
            vc.index = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            SetNavBarAlphaVC *vc = [[SetNavBarAlphaVC alloc] init];
            vc.index = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            OtherSets *vc = [[OtherSets alloc] init];
            vc.index = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}




#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"主页";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
}


@end
