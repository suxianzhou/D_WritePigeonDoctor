//
//  FELoginViewController.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/16.
//  Copyright © 2016年 Fergus. All rights reserved.
//
#import "FEUser.h"
#import "FELoginViewController.h"
#import "Masonry.h"
#import "UIColor+Wonderful.h"
#import "FEAboutPassWordViewController.h"
#import "SXColorGradientView.h"
#import "RWRequsetManager+UserLogin.h"
#import "RWDataBaseManager.h"
#import "FEAuthentViewController.h"
#import "RWMainTabBarController.h"

@interface FELoginViewController ()
<UITableViewDelegate,UITableViewDataSource,FEButtonCellDelegate,FETextFiledCellDelegate,RWRequsetDelegate>

@property (strong, nonatomic)RWRequsetManager *requestManager;
@end


static NSString * const textFieldCell=@"textFieldCell";
static NSString *const buttonCell = @"buttonCell";

@implementation FELoginViewController

@synthesize requestManager;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (requestManager && requestManager.delegate == nil)
    {
        requestManager.delegate = self;
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    requestManager.delegate = nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.viewList addGestureRecognizer:self.tap];
    self.viewList.delegate = self;
    self.viewList.dataSource = self;
    [self createBottomView];
}

-(void)createBottomView{
    
    UIView * bottomView=[[UIView alloc]init];
    
    bottomView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:bottomView];
    
    UIButton * bottomButton=[[UIButton alloc]init];
    
    bottomButton.titleLabel.font=[UIFont systemFontOfSize:13];
    
    
//    [bottomButton setTitleColor:__WPD_MAIN_COLOR__ forState:(UIControlStateNormal)];
    
    [bottomButton setTitle:@"跳过登录使用" forState:(UIControlStateNormal)];
    
    [bottomButton addTarget:self action:@selector(jumpMain) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bottomView addSubview:bottomButton];
    
    __weak typeof (self) weakself =self;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself.view.mas_centerX);
        
        make.left.equalTo(weakself.view.mas_left).offset(weakself.view.frame.size.width/6);
        
        make.height.equalTo(@(50));
        
        make.bottom.equalTo(weakself.view.mas_bottom).offset(-weakself.view.frame.size.height/10);

    }];
    
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bottomView);
        make.left.equalTo(bottomView.mas_left).offset(40);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        
    }];
    
    
}


#pragma mark    -------UITableViewDataSource代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        
        return self.viewList.frame.size.height/5.5;
    }
    
    return self.viewList.frame.size.height/6;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
        
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.textField.keyboardType=UIKeyboardTypeDecimalPad;
        cell.placeholder = @"请输入账号";
        
        cell.textField.text = user?user.username:nil;
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.placeholder = @" 请输入密码";
        cell.textField.secureTextEntry=YES;
        
        if ([SETTINGS_VALUE(__AUTO_LOGIN__) boolValue])
        {
            RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
            cell.textField.text = user?user.password:nil;
        }
        
        return cell;
    }
    else
    {
        FEButtonCell * cell=[tableView dequeueReusableCellWithIdentifier:buttonCell forIndexPath:indexPath];
        cell.delegate=self;
        [cell setTitle:@"登录"];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.viewList.frame.size.height/4;
    }
    if (section==2) {
        return self.viewList.frame.size.height/10;
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
        
        titleLabel.text = @"登录窗口";
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.shadowColor = [UIColor greenColor];
        
        [backView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(backView.mas_left).offset(40);
            make.right.equalTo(backView.mas_right).offset(-40);
            make.top.equalTo(backView.mas_top).offset(20);
            make.bottom.equalTo(backView.mas_bottom).offset(-20);
        }];
        
        return backView;
    }

    if (section==2) {
        UIView *backView = [[UIView alloc]init];
        
        backView.backgroundColor = [UIColor clearColor];
        
        UIButton * ForgotButton=[[UIButton alloc]init];
        [ForgotButton setTitle:@"忘记密码" forState:(UIControlStateNormal)];
        ForgotButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
        
        UIButton *registerButton=[[UIButton alloc]init];
        
        registerButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
        
        [registerButton setTitle:@"新用户注册" forState:(UIControlStateNormal)];
        
        [ForgotButton addTarget:self action:@selector(jumpForgotController) forControlEvents:(UIControlEventTouchUpInside)];
        
        [registerButton addTarget:self action:@selector(jumpRegisterController) forControlEvents:(UIControlEventTouchUpInside)];
        
        [backView addSubview:ForgotButton];
        
        [backView addSubview:registerButton];
        
        [ForgotButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backView).offset(-(self.viewList.frame.size.width/1.5));
            make.left.equalTo(backView).offset(10);
            make.top.equalTo(backView).offset(10);
            make.height.equalTo(@(30));
            
        }];
        
        
        
        [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backView).offset(-10);
            make.left.equalTo(ForgotButton).offset(self.viewList.frame.size.width/1.7);
            make.top.equalTo(backView).offset(10);
            make.height.equalTo(@(30));
        }];
        
        
        
        return backView;
    }
    

    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==2){
        UIView * backgroundView=[[UIView alloc]init];
        
        UIButton * chickButton=[[UIButton  alloc]init];
        
        if ([SETTINGS_VALUE(__AUTO_LOGIN__ )boolValue])
        {
            [chickButton setImage:[UIImage imageNamed:@"duihao"] forState:(UIControlStateNormal)];
        }else{
            [chickButton setImage:[UIImage imageNamed:@"duihao_nil"] forState:(UIControlStateNormal)];
        }
        
        [chickButton addTarget:self action:@selector(chickAutoButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [backgroundView addSubview:chickButton];
        
        [chickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(backgroundView).offset(-20);
            make.centerY.equalTo(backgroundView);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        
        UILabel * label=[[UILabel alloc]init];
        
        label.text=@" 自动登录";
        
        label.textColor=[UIColor whiteColor];
        
        label.font=[UIFont systemFontOfSize:12];
        
        [backgroundView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(chickButton.mas_right);
            make.right.equalTo(backgroundView);
            make.height.equalTo(@(20));
            make.top.equalTo(chickButton);
        }];
        
        
        return backgroundView;
    }
    return nil;
}

#pragma mark  是否自动登录
-(void)chickAutoButton:(UIButton *)button
{
    if ([SETTINGS_VALUE(__AUTO_LOGIN__) boolValue])
    {
        if (SETTINGS(__AUTO_LOGIN__, @(NO)))
        {
            [button setImage:[UIImage imageNamed:@"duihao_nil"]
                    forState:(UIControlStateNormal)];
        }
        else
        {
            MESSAGE(@"变更失败");
        }
    }
    else
    {
        if (SETTINGS(__AUTO_LOGIN__, @(YES)))
        {
            [button setImage:[UIImage imageNamed:@"duihao"]
                    forState:(UIControlStateNormal)];
        }
        else
        {
            MESSAGE(@"变更失败");
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return self.viewList.frame.size.height/11;
    }
    return 0;
}


/**
 *  跳转到忘记密码的页面
 */
-(void)jumpForgotController{
    
    FEAboutPassWordViewController * registerVC=[[FEAboutPassWordViewController alloc]init];
    registerVC.typePassWord=TypeForgetPassWord;
    [self presentViewController:registerVC animated:YES completion:nil];

    
}

-(void)jumpRegisterController{

    FEAboutPassWordViewController * registerVC=[[FEAboutPassWordViewController alloc]init];
    registerVC.typePassWord=TypeRegisterPassWord;
    [self presentViewController:registerVC animated:YES completion:nil];
}




//改变窗口的大小
-(void)changeViewFrame
{
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.height/15);
        make.top.equalTo(self.view.mas_top).offset(self.view.frame.size.height/5);
        
    }];
    [self.viewList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.height/15);
        make.top.equalTo(self.view.mas_top).offset(self.view.frame.size.height/5);
    }];
}
#pragma  mark 改变placeholder
- (void)textFiledCell:(FETextFiledCell *)cell DidBeginEditing:(NSString *)placeholder
{
    self.facePlaceHolder = placeholder;
}
#pragma  mark 点击按钮
-(void)button:(UIButton *)button ClickWithTitle:(NSString *)title
{
    
    [self userLogin];
}


-(void)jumpMain{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark 登录触发
#pragma mark - views

- (void)obtainRequestManager
{
    
    if (!requestManager)
    {
        requestManager = [[RWRequsetManager alloc]init];
        requestManager.delegate = self;
    }
}

-(void)userLogin
{
    [self obtainRequestManager];
    __block FETextFiledCell *textCell = [self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSString *phoneNumber = textCell.textField.text;
    
    __block FETextFiledCell *verCell = [self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    NSString *userPassword = verCell.textField.text;
    
    [FEUser shareDataModle].phoneNumber=phoneNumber;
    [FEUser shareDataModle].password=userPassword;
    
//    InfoViewController * ifVC=[[InfoViewController alloc]init];
//    
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    [root presentViewController:ifVC animated:YES completion:nil];
//    
//    return;
//
    
    if ([requestManager verificationPhoneNumber:phoneNumber])
    {
        
        if ([requestManager verificationPassword:userPassword])
            
        {
            SHOWLOADING;
            [requestManager userinfoWithUsername:phoneNumber AndPassword:userPassword];
            
        }
        else{
            
            [RWSettingsManager promptToViewController:self Title:@"密码输入错误" response:^{
                
                textCell.textField.text = nil;
                [textCell.textField becomeFirstResponder];
            }];
        }
    }else{
        
        [RWSettingsManager promptToViewController:self
                                            Title:@"手机号输入错误，请重新输入"
                                         response:^{
                                             
                                             verCell.textField.text = nil;
                                             [verCell.textField becomeFirstResponder];
                                         }];
    }

}
-(void)userLoginSuccess:(BOOL)success responseMessage:(NSString *)responseMessage
{
    DISSMISS;
    
    if (success) {
      
        [self dismissViewControllerAnimated:YES completion:^{
           
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            
            RWMainTabBarController *mainTab = (RWMainTabBarController *)keyWindow.rootViewController;
            
            [mainTab verifyStatus];
        }];
      
    }
    else
    {
        [RWSettingsManager promptToViewController:self
                                            Title:responseMessage
                                         response:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
