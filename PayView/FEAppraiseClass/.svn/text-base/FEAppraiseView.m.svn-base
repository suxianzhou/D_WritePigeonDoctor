//
//  FEAppraiseView.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/20.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEAppraiseView.h"
#import "Masonry.h"
#import "UIColor+Wonderful.h"
#define MainColor [UIColor colorWithRed:43.f/255.f green:141.f/255.f blue:241.f/255.f alpha:1.0]
@interface FEAppraiseView ()<FEStarRateViewDelegate>

@end

@implementation FEAppraiseView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self createLayoutUI];
        [self createLayoutUIToBackgrondView];
        [self createLayoutMoneyView];
    }
    return self;
}

-(void)createLayoutUI
{
    
    self.backgrondView=[[UIView alloc]init];
    
    self.backgrondView.backgroundColor=[UIColor whiteColor];
    
    self.backgrondView.layer.cornerRadius=5;
    self.backgrondView.layer.masksToBounds=YES;
    [self addSubview:self.backgrondView];
    
    [self.backgrondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(self.frame.size.width/9);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.top.equalTo(self.mas_top).offset(self.frame.size.height/6);
    }];
    
    UIView * disButtonView=[[UIView alloc]init];
    
    disButtonView.backgroundColor=[UIColor clearColor];
    
    [self addSubview:disButtonView];
    [disButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgrondView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.left.equalTo(_backgrondView.mas_left);
        make.right.equalTo(_backgrondView.mas_right);
    }];
    UIButton * button=[[UIButton alloc]init];
    
    [button setBackgroundImage:
                    [UIImage imageNamed:@"叉"]
                      forState:(UIControlStateNormal)];
    
    [button addTarget:self
               action:@selector(dismissView)
            forControlEvents:(UIControlEventTouchUpInside)];
    
    [disButtonView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(disButtonView.mas_centerX);
        make.centerY.equalTo(disButtonView.mas_centerY).offset(5);
        make.width.equalTo(@(self.frame.size.width/8));
        make.height.equalTo(@(self.frame.size.width/8));
    }];
    
 
}

-(void)createLayoutUIToBackgrondView
{
    UILabel *titleLabel=[[UILabel alloc]init];
    
    titleLabel.text=@"评价";
    
    titleLabel.layer.cornerRadius=20;
    
    
    
    titleLabel.textColor=[UIColor whiteColor];
    
    titleLabel.backgroundColor=MainColor;
    
    titleLabel.textAlignment=NSTextAlignmentCenter;
    
    [self.backgrondView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_backgrondView.mas_top);
        
        make.left.equalTo(_backgrondView.mas_left);
        
        make.right.equalTo(_backgrondView.mas_right);
        
        make.height.equalTo(@(self.frame.size.height/11.5));
    }];
    
    _headerView=[[UIImageView alloc]init];
    
    _headerView.layer.masksToBounds=YES;
    
    _headerView.layer.cornerRadius=self.frame.size.height*1.5/12/2;
    
    [self.backgrondView addSubview:_headerView];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        
        make.centerX.equalTo(self.mas_centerX);
        
        make.width.equalTo(@(self.frame.size.height*1.5/12));
        
        make.height.equalTo(@(self.frame.size.height*1.5/12));
    }];
    
    _nameLabel=[[UILabel alloc]init];
    
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    
    _nameLabel.font=[UIFont systemFontOfSize:12];
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.backgrondView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom).offset(1);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(_headerView.mas_width);
        make.height.equalTo(@(self.frame.size.height*1.5/12/4));
    }];
    
    _officeLabel=[[UILabel alloc]init];
    
    _officeLabel.textAlignment=NSTextAlignmentCenter;
    
    _officeLabel.font=[UIFont systemFontOfSize:10];
    
    _officeLabel.textColor=[UIColor dimGray];
    
    _officeLabel.adjustsFontSizeToFitWidth=YES;
    
    [self.backgrondView addSubview:_officeLabel];
    
    [_officeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(2);
        make.left.equalTo(self.backgrondView.mas_left).offset(self.frame.size.width/65);
        make.centerX.equalTo(self.backgrondView.mas_centerX);
        make.height.equalTo(@(self.frame.size.height*1.5/12/4));
    }];
    
    _succeedLabel=[[UILabel alloc]init];
    
    _succeedLabel.textAlignment=NSTextAlignmentCenter;
    
    _succeedLabel.font=[UIFont systemFontOfSize:10];
    
    _succeedLabel.textColor=[UIColor dimGray];
    
    _succeedLabel.adjustsFontSizeToFitWidth=YES;
    
    [self.backgrondView addSubview:_succeedLabel];
    
    [_succeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_officeLabel.mas_bottom).offset(0);
        make.left.equalTo(_officeLabel.mas_left);
        make.centerX.equalTo(self.backgrondView.mas_centerX);
        make.height.equalTo(@(self.frame.size.height*1.5/12/4));
        
    }];
    
    _starImageView=[[FEStarView alloc]initWithFrame:CGRectMake((self.frame.size.width/9), self.frame.size.height/6+self.frame.size.height*1.5/12/4*3+8+self.frame.size.height/11.5/2,self.frame.size.width-((2*self.frame.size.width/9+self.frame.size.width/65)*2), self.frame.size.height*1.5/12/4) numberOfStars:5];
    
    _starImageView.scorePercent = 1;
    
    [self.backgrondView addSubview:_starImageView];
    
    [_starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_succeedLabel.mas_bottom).offset(0);
        make.left.equalTo(_officeLabel.mas_left).offset(self.frame.size.width/9);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(self.frame.size.height*1.5/12/4));
        
    }];
    
  }

-(void)createLayoutMoneyView
{
    UILabel * moneyLabel=[[UILabel alloc]init];
    moneyLabel.textAlignment=NSTextAlignmentRight;
    
    moneyLabel.font=[UIFont systemFontOfSize:13];
    moneyLabel.text=@"您支付了：";
    [self.backgrondView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.equalTo(_officeLabel.mas_left);
         make.top.equalTo(_officeLabel.mas_bottom).offset(2*self.frame.size.height*1.5/12/4);
         make.width.equalTo(@(self.frame.size.height/4-2*self.frame.size.height*1.5/12/6));
         make.height.equalTo(@(self.frame.size.height/10));
    }];
    _moneyLabel=[[UILabel alloc]init];
    _moneyLabel.textAlignment=NSTextAlignmentLeft;
    
    _moneyLabel.font=[UIFont systemFontOfSize:40];
    [self.backgrondView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(moneyLabel.mas_right).offset(self.frame.size.height*1.5/12/6);
        make.top.equalTo(_officeLabel.mas_bottom).offset(2*self.frame.size.height*1.5/12/4);
        make.right.equalTo(_officeLabel.mas_right);
        make.height.equalTo(@(self.frame.size.height/10));
    }];
    
    _pl_startImageView =[[FEStarRateView alloc]initWithFrame:CGRectMake((self.frame.size.width/9), self.frame.size.height/6+self.frame.size.height*1.5/12/4*3+8+self.frame.size.height/11.5/2,self.frame.size.width-((2*self.frame.size.width/9+self.frame.size.width/65)*2), self.frame.size.height/13)];
    


    
    _pl_startImageView.allowIncompleteStar = YES;
    _pl_startImageView.hasAnimation = YES;
    _pl_startImageView.delegate=self;
    [self.backgrondView addSubview:_pl_startImageView];
    
    [_pl_startImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
    
        make.top.equalTo(_moneyLabel.mas_bottom).offset(0);
        make.left.equalTo(_officeLabel.mas_left).offset(self.frame.size.width/9);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(self.frame.size.height/13));
    
    }];
    
    UIButton * CommitButton=[[UIButton alloc]init];
    CommitButton.backgroundColor=[UIColor doderBlue];
    [CommitButton setTitle:@"提交评价" forState:(UIControlStateNormal)];
    [CommitButton addTarget:self action:@selector(commitIndent) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backgrondView addSubview:CommitButton];
    
    [CommitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.frame.size.width/2));
        make.top.equalTo(_pl_startImageView.mas_bottom).offset(3);
        make.height.equalTo(@(self.frame.size.height/13));
    }];
    
    UIButton * feedbackButton=[[UIButton alloc]init];
    
    feedbackButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    
    [feedbackButton setTitle:@"有问题？请联系我们"
                    forState:(UIControlStateNormal)];
    [feedbackButton setTitleColor:[UIColor doderBlue]
                    forState:(UIControlStateNormal)];
    [feedbackButton addTarget:self
                       action:@selector(feedbackclick)
             forControlEvents:(UIControlEventTouchUpInside)];
    [self.backgrondView addSubview:feedbackButton];
    [feedbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CommitButton.mas_bottom).offset(2);
        make.bottom.equalTo(self.backgrondView.mas_bottom).offset(-2);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(self.frame.size.width/3.5));
    }];
    
}

-(void)feedbackclick
{
    [self.delegate feedbackclick];
}

-(void)commitIndent
{
    [self.delegate commitIndent];
}

-(void)dismissView
{
    [self.delegate dismissToView];
}
- (void)starView:(FEStarRateView *)starView scorePercentDidChange:(CGFloat)newScorePercent
{
    [self.delegate starView:starView scorePercentDidChange:newScorePercent];
}
@end
