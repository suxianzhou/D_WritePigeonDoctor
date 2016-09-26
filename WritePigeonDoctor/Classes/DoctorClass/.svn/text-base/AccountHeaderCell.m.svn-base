//
//  AccountHeaderCell.m
//  WritePigeonDoctor
//
//  Created by ZYJY on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "AccountHeaderCell.h"

@implementation AccountHeaderCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    WEAKSELF
    if (!_bankgroundView) {
        _bankgroundView  = [[UIView alloc]init];
        _bankgroundView.backgroundColor = __WPD_MAIN_COLOR__;
        [self.contentView addSubview:_bankgroundView];
        
        [_bankgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf).offset(0);
            make.left.equalTo(weakSelf).offset(0);
            make.right.equalTo(weakSelf).offset(0);
            make.height.equalTo(@(160));
            
        }];
        
    }
    
    if (!_accountDefult) {
        
        _accountDefult  = [[UILabel alloc]init];
        _accountDefult.font = AdaptedFontSize(15);
        _accountDefult.textColor = Wonderful_GrayColor1;
        _accountDefult.text = @"余额账户(元)";
        [_bankgroundView addSubview:_accountDefult];
        
        [_accountDefult mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_bankgroundView).offset(20);
            make.left.equalTo(_bankgroundView).offset(10);
            make.width.equalTo(@(200));
            make.height.equalTo(@(30));
            
        }];
        
    }
    if (!_helpBtn) {
        
        _helpBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_helpBtn setImage:[UIImage imageNamed:@"帮助"] forState:UIControlStateNormal];
        [_bankgroundView addSubview:_helpBtn];
        [_helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_bankgroundView).offset(20);
            make.right.equalTo(_bankgroundView).offset(-15);
            make.width.equalTo(@(25));
            make.height.equalTo(@(25));
            
        }];
        
    }
    if (!_moneyLab) {
        
        _moneyLab  = [[UILabel alloc]init];
        _moneyLab.font = AdaptedFontSize(60);
        _moneyLab.textColor=[UIColor whiteColor];
        _moneyLab.text = @"10000.00";
        [_bankgroundView addSubview:_moneyLab];
        
        [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_accountDefult.mas_bottom).offset(20);
            make.left.equalTo(_bankgroundView).offset(10);
            make.right.equalTo(_bankgroundView).offset(-10);
            make.height.equalTo(@(60));
            
        }];
    }

}

- (void)setModel:(AccountModel *)model
{
    _moneyLab.text = model.money;
    
    _detailLab.text = model.descrip;
}

@end
