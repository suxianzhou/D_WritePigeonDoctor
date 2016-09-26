//
//  FEAppraiseView.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/20.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEStarView.h"
#import "FEStarRateView.h"
@interface FEbackgrondView : UIView



@end



@protocol FEAppraiseViewDelegate <NSObject>
/**
 *  退出该页面
 */
-(void)dismissToView;
/**
 *  点击提交订单
 */
-(void)commitIndent;
/**
 *  点击有问题
 */
-(void)feedbackclick;
/**
 * 返回数值
 */
- (void)starView:(FEStarRateView *)starView scorePercentDidChange:(CGFloat)newScorePercent;
@end

@interface FEAppraiseView : UIView

@property(nonatomic,assign)id<FEAppraiseViewDelegate>delegate;

@property(nonatomic,strong)UIView  * backgrondView;
/**
 *  头像
 */
@property(nonatomic,strong)UIImageView * headerView;
/**
 *  姓名
 */
@property(nonatomic,strong)UILabel * nameLabel;
/**
 *  工作地点
 */
@property(nonatomic,strong)UILabel * officeLabel;
/**
 *  成功接单次数
 */
@property(nonatomic,strong)UILabel * succeedLabel;
/**
 *  历史评星
 */
@property(nonatomic,strong)FEStarView * starImageView;

/**
 *  历史评分
 */
@property(nonatomic,assign)float succeedNumber;
/**
 *  花费
 */
@property(nonatomic,strong)UILabel  * moneyLabel;
/**
 *  评星
 */
@property(nonatomic,strong)FEStarRateView * pl_startImageView;

@end
