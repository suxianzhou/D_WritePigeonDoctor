//
//  RWFlowChartView.h
//  RWOrderProgressViewDemo
//
//  Created by zhongyu on 16/8/31.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWFlow,RWFlowItem,RWFlowChartView;

@protocol RWFlowChartViewDelegate <NSObject>

@optional

- (void)updateOrderStatus:(RWOrderStatus)orderStatus;

- (void)flowChartView:(RWFlowChartView *)flowChartView
    accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath;
@required

- (void)callOtherPartyAtFlowChartView:(RWFlowChartView *)flowChartView;

@end

@interface RWFlowChartView : UITableView

+ (instancetype)flowViewWithFrame:(CGRect)frame
                             flow:(RWFlow *)flow;

@property (nonatomic,strong)id<RWFlowChartViewDelegate> updateStatus;

@property (nonatomic,strong)RWFlow *flow;

@end

@interface RWFlowChartCell : UITableViewCell

@property (nonatomic,strong)UIImageView *statusImage;
@property (nonatomic,strong)UILabel *faceContent;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong,readonly)UILabel *nextDetail;

@property (nonatomic,copy)NSString *detailString;

@end

@interface RWUpdateStatusView : UIView

+ (instancetype)updateViewWithTitle:(NSString *)title
                         faceStatus:(NSString *)facestatus
                          canSelect:(BOOL)canSelect
                     updateResponse:(void (^)(void))updateResponse;

@property (nonatomic,strong)UIButton *updateButton;
@property (nonatomic,strong)UILabel *faceStatus;

@property (nonatomic,copy)void(^update)();

@end

@interface RWDoctorHeaderView : UIView

@property (nonatomic,strong)id<RWFlowChartViewDelegate> delegate;

@property (nonatomic,strong)UIImageView *headerImage;

@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *doctorDes;

@property (nonatomic,strong)UIImageView *callDoctor;

@end

@interface RWFlow : NSObject <RWRequsetDelegate>

extern NSString *DownloadFinishNotification;

- (instancetype)initWithOrder:(RWOrder *)order;
- (void)updateWithOrder:(RWOrder *)order;

@property (nonatomic,strong,readonly)NSArray *items;
@property (nonatomic,strong,readonly)RWUserItem *userItem;

@property (nonatomic,assign,readonly)RWOrderStatus faceStatus;

@property (nonatomic,assign,readonly)BOOL canSelect;
@property (nonatomic,strong,readonly)NSString *buttonStatus;
@property (nonatomic,strong,readonly)NSString *buttonTitle;

@end

@interface RWFlowItem : NSObject

@property (nonatomic,strong)NSString *faceDescription;
@property (nonatomic,strong)NSString *nextStep;
@property (nonatomic,strong)UIImage *faceImage;
@property (nonatomic,strong)NSString *time;

@end
