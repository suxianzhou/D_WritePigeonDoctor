//
//  FEStarRateView.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/22.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FEStarRateView;

typedef NS_ENUM(NSInteger, RateStyle)
{
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};
@protocol FEStarRateViewDelegate <NSObject>
- (void)starView:(FEStarRateView *)starView scorePercentDidChange:(CGFloat)newScorePercent;
@end
@interface FEStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0~1，默认1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<FEStarRateViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end
