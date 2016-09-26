//
//  FEUserSettingViewController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/11.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "FEUserSettingViewController.h"
#import "RWUserInformation.h"
#import "UMComTools.h"
#import "AuditLoggingViewController.h"
#import "RWObjectModels.h"
#import "FELoginTableCell.h"


@interface FEUserSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * userTableView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel * nameLab;

@property(nonatomic,strong)RWUser * user;
@end

@implementation FEUserSettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SHOWLOADING;
    RWDataBaseManager *baseManager = [RWDataBaseManager defaultManager];
    
    _user = [baseManager getDefualtUser];
    
    [_userTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    DISSMISS;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
    
    self.view.backgroundColor=Wonderful_GrayColor1;
    
    [self.view addSubview:[self createTableView]];
    
//    [self initView];
   
    
//    [self createBackButton];
    
    [self.userTableView reloadData];
}

-(void)createBackButton
{
    
    UIButton * backButton=[[UIButton alloc]init];
    
    backButton.backgroundColor=__WPD_MAIN_COLOR__;
    
    [backButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [backButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    
    [backButton addTarget:self action:@selector(backUser) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:backButton];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.userTableView.mas_bottom).offset(5);
        make.bottom.equalTo(self.view).offset(0);
    }];
}

-(void)backUser
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"白鸽提示" message:@"是否退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([RWSettingsManager deviceVersion])
        {
            [SVProgressHUD setMinimumDismissTimeInterval:15];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showWithStatus:@"正在退出。。。"];
        }
        [RWRequsetManager userLogout:^(BOOL success) {
            
            if (success)
            {
                RWDataBaseManager *dataBase = [RWDataBaseManager defaultManager];
                
                RWUser *user = [dataBase getDefualtUser];
                user.defaultUser = NO;
                
                if ([dataBase updateUesr:user] && SETTINGS(__AUTO_LOGIN__, @(NO)))
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogoutSucceedNotification object:nil];
                    
                    
                        if ([RWSettingsManager deviceVersion])
                        {
                            [SVProgressHUD dismiss];
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    
                }
            }else{
                NSLog(@"未成功");
        }
        }];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(UITableView *)createTableView
{
    if (!_userTableView) {

        _userTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height - 64) style:(UITableViewStyleGrouped)];
        _userTableView.delegate=self;
        _userTableView.dataSource=self;
        _userTableView.backgroundColor=[UIColor clearColor];
        _userTableView.showsVerticalScrollIndicator = NO;
        
        [_userTableView registerClass:[FEUserInfoCell class] forCellReuseIdentifier:@"UserInfoCell"];
        
    }
    return _userTableView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section==0) {
        
        UIView * backView=[[UIView alloc]init];
        
        backView.backgroundColor=[UIColor clearColor];
        
        UILabel * accountLabel=[[UILabel alloc]init];
        
        accountLabel.text=@"(注:账号状态可点击查看或修改)";
        
        accountLabel.textAlignment=NSTextAlignmentLeft;
        
        accountLabel.font=[UIFont systemFontOfSize:12];
        
        accountLabel.textColor=__WPD_MAIN_COLOR__;
        
        [backView addSubview:accountLabel];
        
        [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(backView.mas_left).offset(20);
            make.width.equalTo(backView.mas_width).offset(-20);
            make.centerY.equalTo(backView.mas_centerY).offset(2);
            make.height.equalTo(backView.mas_height).offset(0);
        }];
        
        return  backView;
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _userInArray.count;
    
    if (section==0) {
        return 1;
    }
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{   if(section==0)
  {
    return 10;
  }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 60;
    }
    
    if (indexPath.row==7) {
        
        return 140;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }else
    {
        return 0;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier= @"userCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    
    if (indexPath.section==0) {
        
        cell.textLabel.text = @"账号状态：";
        
        cell.detailTextLabel.text = [self doctorStatusToNSString:_user.doctorStatus];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }
    

    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            cell.textLabel.text = @"姓名：";
            cell.detailTextLabel.text = _user.name;
            return cell;
        }else if (indexPath.row==1)
        {
            cell.textLabel.text = @"年龄：";
            cell.detailTextLabel.text =_user.age;
            return cell;
        }else if (indexPath.row==2)
        {
            cell.textLabel.text = @"性别：";
            cell.detailTextLabel.text = _user.gender;
            return cell;
        }else if (indexPath.row==3)
        {
            cell.textLabel.text = @"工作地址：";
            cell.detailTextLabel.text = _user.hospital;
            return cell;
        }else if (indexPath.row==4)
        {
           
            cell.textLabel.text = @"科室：";
            
            cell.detailTextLabel.text = [RWRequsetManager officeWithGroupID:[NSNumber numberWithInteger:_user.groupID]];
            return cell;
        }else if (indexPath.row==5)
        {
            cell.textLabel.text = @"职称：";
            cell.detailTextLabel.text =_user.professionTitle;
            
            return cell;
        }else if (indexPath.row==6)
        {
            cell.textLabel.text = @"科室电话：";
            cell.detailTextLabel.text =_user.officePhone;
    
            return cell;
        }else if (indexPath.row==7)
        {
            FEUserInfoCell * userCell=[tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
                userCell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                userCell.backgroundColor=[UIColor whiteColor];
                
                userCell.titleLabel.text=@"个人描述:";
    
                userCell.userLabel.text=_user.doctorDescription;
           
            CGSize size = [userCell.userLabel sizeThatFits:CGSizeMake(userCell.frame.size.width*3/4-20, MAXFLOAT)];
            userCell.userLabel.frame =CGRectMake(0, 0, userCell.frame.size.width*3/4-20, size.height);
            
            userCell.userScrollView.contentSize = CGSizeMake(userCell.frame.size.width*3/4-20, size.height);

            return userCell;
            
        }
        
     
    }
    
    return nil;
}

-(NSString *)doctorStatusToNSString:(RWDoctorStatus)doctorStatus
{
    if (doctorStatus==-3) {
        return @"已注销";
    }else if (doctorStatus==-2)
    {
        return @"被驳回，请检查信息";
    }else if (doctorStatus==-1)
    {
        return @"已提交，请等待审核";
    }else if (doctorStatus==0)
    {
        return @"未审核";
    }else
    {
        return @"已通过审核"; 
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section==0) {
        
        if (_user.doctorStatus==0) {
            
        }
        
        AuditLoggingViewController * ALVC=[[AuditLoggingViewController alloc]init];
        
        [self.navigationController pushViewController:ALVC animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
