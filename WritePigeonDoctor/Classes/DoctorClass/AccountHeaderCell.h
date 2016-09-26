//
//  AccountHeaderCell.h
//  WritePigeonDoctor
//
//  Created by ZYJY on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface AccountHeaderCell : UITableViewCell

@property(nonatomic,strong) UIView * bankgroundView;

@property(nonatomic,strong) UILabel * accountDefult;

@property(nonatomic,strong) UILabel * moneyLab;

@property(nonatomic,strong) UIButton * helpBtn;

@property(nonatomic,strong) UILabel * detailLab;

@property(nonatomic,strong) AccountModel * model;

@end
