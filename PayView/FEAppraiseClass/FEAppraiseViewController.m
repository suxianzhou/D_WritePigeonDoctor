//
//  FEAppraiseViewController.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/22.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEAppraiseViewController.h"
#import "FEAppraiseView.h"
@interface FEAppraiseViewController ()<FEAppraiseViewDelegate>

@property(nonatomic,assign)CGFloat * starNumber;

@end

@implementation FEAppraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setHeaderImage:(NSString *)headerImage name:(NSString *)name hospital:(NSString *)hospital succeedNumber:(NSString *)succeedNumber succeedStar:(float)succeedStar howMoney:(NSString *)money
{
    FEAppraiseView * FEASV=[[FEAppraiseView alloc]initWithFrame:self.view.bounds];
    
    [FEASV.headerView setImageWithURL:[NSURL URLWithString:headerImage] placeholder:[UIImage imageNamed:@"user_image"]];
    
    FEASV.nameLabel.text=name;
    
    FEASV.officeLabel.text=[NSString stringWithFormat:@"工作地点：%@",hospital];
    
    FEASV.succeedLabel.text=[NSString stringWithFormat:@"成功接单：%@",succeedNumber];
    
    FEASV.starImageView.scorePercent=succeedStar;
    
    FEASV.moneyLabel.text=[NSString stringWithFormat:@"¥%@",money];
    
    FEASV.delegate=self;
    
    [self.view addSubview:FEASV];
    
}

-(void)dismissToView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)commitIndent
{
    [self.delegate scorePercentDidChange:_ScorePercentStar];
}
-(void)feedbackclick
{
    NSLog(@"点击了有问题");
    
}
- (void)starView:(FEStarRateView *)starView scorePercentDidChange:(CGFloat)newScorePercent
{
    _ScorePercentStar=newScorePercent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
