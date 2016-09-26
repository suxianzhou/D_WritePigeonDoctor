//
//  AuditLoggingViewController.m
//  WritePigeonDoctor
//
//  Created by ZYJY on 16/9/12.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "AuditLoggingViewController.h"
#import "RWMainTabBarController.h"

@interface AuditLoggingViewController ()

@property (nonatomic,strong) UIImageView * AuditStatusImgV;

@property (nonatomic,strong) UILabel * AuditStatusLab;

@property (nonatomic,strong) UILabel * AuditDetailLab;

@property (nonatomic,strong) UIButton * AuditPopBtn;

@end

@implementation AuditLoggingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"审核状态";
    [self initView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    if (user.doctorStatus == RWDoctorStatusWaitCheck)
    {
        _AuditStatusImgV.image = [UIImage imageNamed:@"审核中"];
        _AuditStatusLab.text = @"正在审核";
        [_AuditPopBtn setTitle:@"返回" forState:UIControlStateNormal];
    }else if (user.doctorStatus == RWDoctorStatusPass)
    {
        _AuditStatusImgV.image = [UIImage imageNamed:@"审核通过"];
        _AuditStatusLab.text = @"审核通过";
         [_AuditPopBtn setTitle:@"返回" forState:UIControlStateNormal];
    }else if (user.doctorStatus == RWDoctorStatusReject)
    {
        _AuditStatusImgV.image = [UIImage imageNamed:@"审核未通过"];
        _AuditStatusLab.text = @"审核被驳回";
         [_AuditPopBtn setTitle:@"修改个人信息" forState:UIControlStateNormal];
    }else if (user.doctorStatus == RWDoctorStatusUnUpload)
    {
        _AuditStatusImgV.image = [UIImage imageNamed:@"未审核"];
        _AuditStatusLab.text = @"还未审核身份";
         [_AuditPopBtn setTitle:@"填写个人信息" forState:UIControlStateNormal];
    }else
    {
        _AuditStatusImgV.image = [UIImage imageNamed:@"吊销"];
        _AuditStatusLab.text = @"审核被吊销";
        [_AuditPopBtn setTitle:@"重新填写个人信息" forState:UIControlStateNormal];
    }
}

- (void)initView
{
    //审核状态图片
    _AuditStatusImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _AuditStatusImgV.centerX = self.view.centerX;
    _AuditStatusImgV.centerY = self.view.centerY - 60;
    [self.view addSubview:_AuditStatusImgV];
    //审核状态文字
    _AuditStatusLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _AuditStatusImgV.bottom + 10, SCREEN_WIDTH -20, 20)];
    _AuditStatusLab.textColor = __WPD_MAIN_COLOR__;
    _AuditDetailLab.font = [UIFont systemFontOfSize:20];
    _AuditStatusLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_AuditStatusLab];
    //审核状态描述
    _AuditDetailLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _AuditStatusLab.bottom + 10, SCREEN_WIDTH - 20, 200)];
    _AuditDetailLab.textColor = [UIColor blackColor];
    _AuditDetailLab.font = [UIFont systemFontOfSize:14];
    _AuditDetailLab.textAlignment = NSTextAlignmentCenter;
    _AuditDetailLab.numberOfLines = 0;
    [self.view addSubview:_AuditDetailLab];
    //审核跳转
    _AuditPopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _AuditPopBtn.backgroundColor = __WPD_MAIN_COLOR__;
    _AuditPopBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 108, SCREEN_WIDTH, 44);
    [_AuditPopBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_AuditPopBtn];
}

#pragma - Action

- (void)BtnClick
{
    
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    if (user.doctorStatus == RWDoctorStatusWaitCheck || user.doctorStatus == RWDoctorStatusPass)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
    UIWindow * window = [[UIApplication sharedApplication]keyWindow];
    RWMainTabBarController * tab = (RWMainTabBarController *)window.rootViewController;
    [tab verifyStatus];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
