//
//
//  FEPayMoneyViewController.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/24.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEPayMoneyViewController.h"
#import "FELoginTableCell.h"
#import "Masonry.h"
#import "UIColor+Wonderful.h"
@interface FEPayMoneyViewController ()<UITableViewDelegate,UITableViewDataSource,FETextFiledCellDelegate,FEButtonCellDelegate>

@end
static NSString * const textFieldCell=@"textFieldCell";
static NSString *const buttonCell = @"buttonCell";
@implementation FEPayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * headView=[self createHeaderView:@"③结算信息提交"];
    headView.frame=CGRectMake(0, 0, self.viewList.frame.size.width, self.viewList.frame.size.height/16);
    [self.viewList addGestureRecognizer:self.tap];
    self.viewList.delegate = self;
    self.viewList.dataSource = self;
    self.viewList.tableHeaderView=headView;
}

#pragma mark    -------UITableViewDataSource代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(section==0)
    {
        return self.viewList.frame.size.height/20;
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *backView = [[UIView alloc]init];
        
        backView.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        
        titleLabel.text = @"以下信息仅作为认证使用，不会公开";
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.font = [UIFont systemFontOfSize:13];
        
        titleLabel.textColor = [UIColor gainsboroColor];
        
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(backView.mas_left).offset(20);
            make.right.equalTo(backView.mas_right).offset(-20);
            make.top.equalTo(backView.mas_top).offset(3);
            make.bottom.equalTo(backView.mas_bottom).offset(-3);
        }];
        
        return backView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        
        return self.viewList.frame.size.height/5.5;
    }
    
    return self.viewList.frame.size.height/6;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
     {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.textField.keyboardType=UIKeyboardTypeDecimalPad;
        cell.textField.userInteractionEnabled=NO;
        cell.placeholder = @"请选择您的结算方式";
         
         UIButton * button=[[UIButton alloc]init];
         
         button.backgroundColor=[UIColor clearColor];
         [button addTarget:self action:@selector(chickPay) forControlEvents:(UIControlEventTouchUpInside)];
         
         [cell addSubview:button];
         [button mas_makeConstraints:^(MASConstraintMaker *make) {
             make.center.equalTo(cell);
             make.size.equalTo(cell);
         }];
        return  cell;
     }
    else if(indexPath.section==1)
     {
         FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
         
         cell.delegate = self;
         cell.placeholder = @"请输入账号";
         
         return  cell;
     }
    else if(indexPath.section==2)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.placeholder = @" 请输入账户名称";
        return cell;
    }
    
    else if(indexPath.section==3)
    {
        FEButtonCell * cell=[tableView dequeueReusableCellWithIdentifier:buttonCell forIndexPath:indexPath];
        cell.delegate=self;
        [cell setTitle:@"上一步"];
        return cell;
    }
    
    else
    {   FEButtonCell * cell=[tableView dequeueReusableCellWithIdentifier:buttonCell forIndexPath:indexPath];
        cell.delegate=self;
        [cell setTitle:@"完成"];
        return cell;
    }


}

-(void)textFiledCell:(FETextFiledCell *)cell DidBeginEditing:(NSString *)placeholder
{
     self.facePlaceHolder = placeholder;
}
-(void)dismissToRootViewController
{
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}
-(void)button:(UIButton *)button ClickWithTitle:(NSString *)title
{
    [self dismissToRootViewController];
}

-(void)chickPay
{
    FETextFiledCell * cell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择结算方式" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.textField.text=@"支付宝";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.textField.text=@"微信";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
