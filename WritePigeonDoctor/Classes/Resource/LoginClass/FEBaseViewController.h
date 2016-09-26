//
//  FEBaseViewController.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/16.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FELoginTableCell.h"
@interface FEBaseViewController : UIViewController

@property(nonatomic,strong)UITapGestureRecognizer *tap;
@property(nonatomic,strong)UITableView * viewList;
@property (nonatomic ,strong)NSString *facePlaceHolder;
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UIVisualEffectView * effectView;



-(UIView *)createHeaderView:(NSString *)titleText;

@end
