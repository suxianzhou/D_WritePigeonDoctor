//
//  FEStarView.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/22.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FEStarView : UIView
@property (nonatomic, assign)CGFloat scorePercent;//0到1,评分
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStar;
@end
