//
//  FEAppraiseViewController.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/22.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEStarView.h"

@protocol FEAppraiseViewControllerDelegate <NSObject>

- (void)scorePercentDidChange:(CGFloat)newScorePercent;
@end

@interface FEAppraiseViewController : UIViewController

@property(nonatomic,assign)id<FEAppraiseViewControllerDelegate> delegate;
@property(nonatomic,assign)float ScorePercentStar;
/**
 *
 *  @param headerImage   头像
 *  @param name          姓名
 *  @param hospital      工作地点
 *  @param succeedNumber 历史接单
 *  @param succeedStar   历史平均评分
 *  @param money         花费
 */
-(void)setHeaderImage:(NSString *) headerImage name:(NSString *) name hospital:(NSString *) hospital succeedNumber:(NSString *) succeedNumber succeedStar:(float) succeedStar howMoney:(NSString *)money;
@end
