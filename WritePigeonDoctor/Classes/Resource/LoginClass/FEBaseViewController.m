//
//  FEBaseViewController.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/16.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEBaseViewController.h"
#import "Masonry.h"

@interface FEBaseViewController ()

@property(nonatomic,strong)RWUser * user;

@end

static NSString * const textFieldCell=@"textFieldCell";
static NSString *const buttonCell = @"buttonCell";
static NSString * const chickCell=@"chickCell";
static NSString * const agreementCell=@"agreementCell";
static NSString * const TextViewCell=@"textViewCell";
static NSString * const imageViewCell=@"imageViewCell";
@implementation FEBaseViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated ];
    self.navigationController.navigationBar.hidden=YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO ;
    
    if (!_user)
    {
        _user = [[RWDataBaseManager defaultManager] getDefualtUser];
        [self.viewList reloadData];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createBackImageView];
    [self createUI];
    [self createId];
    
    [self changeViewFrame];
      _tap=[self addTapGesture];
}
-(void)createUI{
    
    UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    _effectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    
    _effectView.alpha=0.8;
    _effectView.layer.cornerRadius=12;
    
    _effectView.layer.masksToBounds=YES;
    
    [self.view addSubview:_effectView];
     _viewList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _viewList.backgroundColor=[UIColor clearColor];
    _viewList.scrollEnabled=NO;
    _viewList.allowsSelection = NO;
    _viewList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_viewList];
}

-(void)createId
{
    [self.viewList registerClass:[FEAgreementCell class] forCellReuseIdentifier:agreementCell];
    [self.viewList registerClass:[FEChecButtonCell class] forCellReuseIdentifier:chickCell];
    [self.viewList registerClass:[FETextFiledCell class] forCellReuseIdentifier:textFieldCell];
    [self.viewList registerClass:[FEButtonCell class] forCellReuseIdentifier:buttonCell];
    [self.viewList registerClass:[FETextViewCell class] forCellReuseIdentifier:TextViewCell];
    [self.viewList registerClass:[FEImageCell class] forCellReuseIdentifier:imageViewCell];
}

-(void)changeViewFrame
{
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.height/15);
        make.top.equalTo(self.view.mas_top).offset(self.view.frame.size.height/7);
        
    }];
    [_viewList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.height/15);
        make.top.equalTo(self.view.mas_top).offset(self.view.frame.size.height/7);
    }];
}


//创建背景图
-(void)createBackImageView{
    
    _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    _backImageView.frame=[UIScreen mainScreen].bounds;
//    _backImageView.backgroundColor = UIColorHex(2B8DF1);
//    _backImageView.image=[UIImage imageNamed:@"bg1"];
    
    [self.view addSubview:_backImageView];
    
}

-(UIView *)createHeaderView:(NSString *)titleText
{
    UIView *backView=[[UIView alloc]init];
    
    backView.backgroundColor=[UIColor clearColor];
    
    UILabel * label=[[UILabel alloc]init];
    
    label.text=titleText;
    
    label.textAlignment=NSTextAlignmentCenter;
    
    label.font=[UIFont systemFontOfSize:17];
    
    label.textColor=[UIColor whiteColor];
    
    label.shadowOffset = CGSizeMake(0, 1);
    
    label.shadowColor = [UIColor greenColor];
    
    [backView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.top.equalTo(backView.mas_top).offset(0);
        make.bottom.equalTo(backView.mas_bottom).offset(0);
    }];
    
    return backView;
}


- (UITapGestureRecognizer *)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(releaseFirstResponder)];
    
    tap.numberOfTapsRequired = 1;
    
    return tap;
}



/**
 *  触摸时后的事件
 */

- (void)releaseFirstResponder
{
    [self.view endEditing:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
