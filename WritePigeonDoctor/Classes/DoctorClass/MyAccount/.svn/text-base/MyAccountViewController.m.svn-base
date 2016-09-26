//
//  MyAccountViewController.m
//  WritePigeonDoctor
//
//  Created by ZYJY on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "MyAccountViewController.h"
#import "AccountHeaderCell.h"
#import "DrawWayViewController.h"

@interface MyAccountViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * accountTV;


@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    [self initTableView];
}

- (void)initTableView
{
    _accountTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    _accountTV.backgroundColor = Wonderful_GrayColor1;
    _accountTV.backgroundView.backgroundColor = [UIColor clearColor];
    _accountTV.showsVerticalScrollIndicator = NO;
    _accountTV.delegate = self;
    _accountTV.dataSource = self;
    _accountTV.tableFooterView = [UIView new];
    [self.view addSubview:_accountTV];
    
    [_accountTV registerClass:[AccountHeaderCell class] forCellReuseIdentifier:NSStringFromClass([AccountHeaderCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    AccountHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AccountHeaderCell class]) forIndexPath:indexPath];
    [cell.helpBtn addTarget:self action:@selector(helpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    }else
    {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"提现";
    cell.imageView.image = [UIImage imageNamed:@"提现"];
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
    DrawWayViewController * draw = [[DrawWayViewController alloc]init];
    [self.navigationController pushViewController:draw animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    return 300;
   
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    
    return 18;
}

#pragma - Action

- (void)helpBtnClick
{
    [SVProgressHUD showInfoWithStatus:@"你点击了帮助"];
}

@end
