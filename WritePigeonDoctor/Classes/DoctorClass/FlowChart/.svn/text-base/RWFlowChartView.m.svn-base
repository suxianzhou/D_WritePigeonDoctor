//
//  RWFlowChartView.m
//  RWOrderProgressViewDemo
//
//  Created by zhongyu on 16/8/31.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWFlowChartView.h"

@interface RWFlowChartView ()

<
    UITableViewDelegate,
    UITableViewDataSource,
    RWFlowChartViewDelegate
>

@end

@implementation RWFlowChartView

+ (instancetype)flowViewWithFrame:(CGRect)frame
                             flow:(RWFlow *)flow;
{
    RWFlowChartView *chartView = [[RWFlowChartView alloc] initWithFrame:frame];
    chartView.flow = flow;
    
    return chartView;
}

- (void)setFlow:(RWFlow *)flow
{
    _flow = flow;
    
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    if (self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.allowsSelection = NO;
        self.bounces = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[RWFlowChartCell class] forCellReuseIdentifier:NSStringFromClass([RWFlowChartCell class])];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _flow.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWFlowChartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWFlowChartCell class]) forIndexPath:indexPath];
    
    RWFlowItem *item = _flow.items[indexPath.row];

    cell.accessoryType = item.nextStep?
                         UITableViewCellAccessoryDetailButton:
                         UITableViewCellAccessoryNone;
    
    cell.statusImage.image = item.faceImage;
    cell.faceContent.text = item.faceDescription;
    cell.time.text = item.time;
    cell.detailString = item.nextStep;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [RWUpdateStatusView updateViewWithTitle:_flow.buttonTitle
                                        faceStatus:_flow.buttonStatus
                                         canSelect:_flow.canSelect
                                    updateResponse:^
    {
        
        [_updateStatus updateOrderStatus:_flow.faceStatus];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    if (_flow.faceStatus > RWOrderStatusWaitService)
    {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        
        RWDoctorHeaderView *headerView = [[RWDoctorHeaderView alloc] initWithFrame:CGRectMake(0, 0, w, 80)];
        [view addSubview:headerView];
        
        [headerView.headerImage setImageWithURL:[NSURL URLWithString:_flow.userItem.header] placeholder:[UIImage imageNamed:@"user_image"]];
        
        headerView.name.text = [NSString stringWithFormat:@"正在为 %@ 服务",_flow.userItem.nickName];
        
        headerView.delegate = self;
    }
    
    return view;
}

- (void)callOtherPartyAtFlowChartView:(RWFlowChartView *)flowChartView
{
    [_updateStatus callOtherPartyAtFlowChartView:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_flow.faceStatus > RWOrderStatusWaitService)
    {
        CGFloat h = self.bounds.size.height - 100 * _flow.items.count - 44;
        
        return h > 80?h:80;
    }
    else
    {
        CGFloat h = self.bounds.size.height - 100 * _flow.items.count - 44;
        
        return h > 20?h:20;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath
{
    [_updateStatus flowChartView:self accessoryButtonTappedForRowWithIndexPath:indexPath];
}

@end

@implementation RWFlowChartCell

- (void)initViews
{
    _statusImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_statusImage];
    
    _faceContent = [[UILabel alloc] init];
    [self.contentView addSubview:_faceContent];
    _faceContent.textColor = [UIColor blackColor];
    _faceContent.font = __RWGET_SYSFONT(14);
    _faceContent.numberOfLines = 2;
    
    _time = [[UILabel alloc] init];
    [self.contentView addSubview:_time];
    _time.textColor = [UIColor grayColor];
    _time.font = __RWGET_SYSFONT(12);
    _time.numberOfLines = 1;
    
    _nextDetail = [[UILabel alloc] init];
    [self.contentView addSubview:_nextDetail];
    _nextDetail.textColor = [UIColor grayColor];
    _nextDetail.font = __RWGET_SYSFONT(13);
    _nextDetail.numberOfLines = 4;
}

- (void)autoLayoutViews
{
    [_statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(15));
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(30);
    }];
    
    if (!_detailString)
    {
        [self notHasAutoLayout];
    }
}

- (void)notHasAutoLayout
{
    _nextDetail.hidden = YES;
    
    [_time mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(50));
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [_faceContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_statusImage.mas_right).offset(20);
        make.right.equalTo(_time.mas_left).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
}

- (void)hasNextAutoLayout
{
    _nextDetail.hidden = NO;
    _nextDetail.text = _detailString;
    
    CGRect frame = CGRectMake(0, 0, self.contentView.bounds.size.width - 165, 0);
    _nextDetail.frame = frame;
    
    [_nextDetail sizeToFit];
    
    [_nextDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(_nextDetail.bounds.size.width));
        make.height.equalTo(@(_nextDetail.bounds.size.height));
        make.left.equalTo(_statusImage.mas_right).offset(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [_time sizeToFit];
    
    [_time mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(_time.bounds.size.width));
        make.height.equalTo(@(_time.bounds.size.height));
        make.right.equalTo(self.contentView.mas_right).offset(-(50 - _time.bounds.size.width));
        
        if (_nextDetail.bounds.size.height < 30)
        {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        }
        else
        {
            make.bottom.equalTo(_nextDetail.mas_top).offset(-10);
        }
    }];
    
    [_faceContent sizeToFit];
    
    [_faceContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(_faceContent.bounds.size.width));
        make.height.equalTo(@(_faceContent.bounds.size.height));
        make.left.equalTo(_statusImage.mas_right).offset(20);
        
        if (_nextDetail.bounds.size.height < 30)
        {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        }
        else
        {
            make.bottom.equalTo(_nextDetail.mas_top).offset(-10);
        }
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initViews];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self autoLayoutViews];
}

- (void)setDetailString:(NSString *)detailString
{
    _detailString = detailString;
    
    if (_detailString && _detailString.length != 0)
    {
        [self hasNextAutoLayout];
    }
    else
    {
        [self notHasAutoLayout];
    }
}

@end

@implementation RWUpdateStatusView

+ (instancetype)updateViewWithTitle:(NSString *)title
                         faceStatus:(NSString *)facestatus
                          canSelect:(BOOL)canSelect
                     updateResponse:(void (^)(void))updateResponse
{
    RWUpdateStatusView *update = [[RWUpdateStatusView alloc] init];
    update.update = updateResponse;
    
    [update.updateButton setTitle:title
                         forState:UIControlStateNormal];
    update.faceStatus.text = facestatus;
    
    if (canSelect)
    {
        update.updateButton.userInteractionEnabled = YES;
        update.updateButton.backgroundColor = __WPD_MAIN_COLOR__;
    }
    else
    {
        update.updateButton.userInteractionEnabled = NO;
        update.updateButton.backgroundColor = [UIColor grayColor];
    }
    
    return update;
}

- (void)initViews
{
    _updateButton = [[UIButton alloc] init];
    [self addSubview:_updateButton];
    [_updateButton setTitleColor:[UIColor whiteColor]
                        forState:UIControlStateNormal];
    
    _updateButton.titleLabel.font = __RWGET_SYSFONT(13);
    _updateButton.layer.cornerRadius = 4;
    _updateButton.clipsToBounds = YES;
    
    [_updateButton addTarget:self
                      action:@selector(updateStatus)
            forControlEvents:UIControlEventTouchUpInside];
    
    _faceStatus = [[UILabel alloc] init];
    [self addSubview:_faceStatus];
    _faceStatus.numberOfLines = 0;
    _faceStatus.font = __RWGET_SYSFONT(12);
}

- (void)updateStatus
{
    _update();
}

- (void)autoLayoutView
{
    [_updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(100));
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [_faceStatus mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(_updateButton.mas_left).offset(-20);
    }];
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 8.f;
        self.layer.shadowOffset = CGSizeMake(0, -2);
        
        [self initViews];
    }
    
    return self;
}

- (void)didMoveToWindow
{
    [self autoLayoutView];
}

@end

@implementation RWDoctorHeaderView

- (void)initViews
{
    _headerImage = [[UIImageView alloc] init];
    [self addSubview:_headerImage];
    _headerImage.layer.cornerRadius = (self.bounds.size.height - 20) / 2;
    _headerImage.clipsToBounds = YES;
    
    _name = [[UILabel alloc] init];
    [self addSubview:_name];
    _name.textColor = [UIColor blackColor];
    _name.font = __RWGET_SYSFONT(14);
    
    _doctorDes = [[UILabel alloc] init];
    [self addSubview:_doctorDes];
    _doctorDes.textColor = [UIColor grayColor];
    _doctorDes.font = __RWGET_SYSFONT(12);
    
    _callDoctor = [[UIImageView alloc] init];
    [self addSubview:_callDoctor];
    _callDoctor.userInteractionEnabled = YES;
    _callDoctor.image = [UIImage imageNamed:@"拨打电话 "];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(callOther)];
    
    tap.numberOfTapsRequired = 1;
    
    [_callDoctor addGestureRecognizer:tap];
}

- (void)callOther
{
    [_delegate callOtherPartyAtFlowChartView:nil];
}

- (void)autoLayoutViews
{
    CGFloat imageH = self.bounds.size.height - 20;
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(imageH));
        make.height.equalTo(@(imageH));
        make.left.equalTo(self.mas_left).offset(20);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [_callDoctor mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
        make.right.equalTo(self.mas_right).offset(-30);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_headerImage.mas_right).offset(20);
        make.right.equalTo(_callDoctor.mas_left).offset(-20);
        make.top.equalTo(self.mas_top).offset(20);
        make.bottom.equalTo(self.mas_centerY).offset(-10);
    }];
    
    [_doctorDes mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headerImage.mas_right).offset(20);
        make.right.equalTo(_callDoctor.mas_left).offset(-20);
        make.top.equalTo(self.mas_centerY).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 8.f;
        self.layer.shadowOffset = CGSizeMake(0, -2);
        
        [self initViews];
        [self autoLayoutViews];
    }
    
    return self;
}

@end

#import "RWFlowIndex.h"

@implementation RWFlow

const NSString *DownloadFinishNotification = @"DownloadFinishNotification";

- (instancetype)initWithOrder:(RWOrder *)order
{
    self = [super init];
    
    if (self)
    {
        [self updateWithOrder:order];
    }
    
    return self;
}

- (NSString *)buttonStatus
{
    RWFlowItem *item = _items[_faceStatus];
    return item.faceDescription;
}

- (void)requsetUser:(RWUserItem *)user responseMessage:(NSString *)responseMessage
{
    if (user)
    {
        _userItem = user;
        
        send_notification(DownloadFinishNotification,responseMessage);
    }
}

- (void)updateWithOrder:(RWOrder *)order
{
    if (order.serviceid)
    {
        RWRequsetManager *requestManager = [[RWRequsetManager alloc] init];
        requestManager.delegate = self;
        
        [requestManager obtainUserWithUserID:order.payid];
    }
    
    _faceStatus = order.orderstatus;
    _canSelect = (_faceStatus == RWOrderStatusServiceStart ||
                  _faceStatus == RWOrderStatusWaitUserStart)?YES:NO;
    _buttonTitle = __BUTTON_STATUS__[_faceStatus];
    
    switch (order.pid)
    {
        case RWServiceTypeAccompanyTreat:
        {
            if (order.fid == RWServiceSiteInHome)
            {
                [self makeAccompanyTreatInHomeFlow];
            }
            else if (order.fid == RWServiceSiteInHospital)
            {
                [self makeAccompanyTreatInInHospitalFlow];
            }
            
            break;
        }
        case RWServiceTypeGetTestReport:
        {
            [self makeGetTestReportFlow];
            break;
        }
        case RWServiceTypeInject:
        {
            if (order.fid == RWServiceSiteInHome)
            {
                [self makeInjectInHomeFlow];
            }
            else if (order.fid == RWServiceSiteInHospital)
            {
                [self makeInjectInInHospitalFlow];
            }
            
            break;
        }
        default: break;
    }
    
    NSString *faceStatusDate = order.faceStatusDate;
    NSDate *date = [NSDate dateWithString:faceStatusDate format:@"yyyy-MM-dd HH:mm:ss"];
    
    RWFlowItem *item = _items[_faceStatus];
    item.time = [date stringWithFormat:@"HH:mm"];
}

- (void)makeAccompanyTreatInHomeFlow
{
    if (_items)
    {
        [self getFlowWithFlow:nil detial:__ACCOMPARNY_HOME_FLOW_DETAIL__];
    }
    else
    {
        [self getFlowWithFlow:__FLOW__ detial:__ACCOMPARNY_HOME_FLOW_DETAIL__];
    }
}

- (void)makeAccompanyTreatInInHospitalFlow
{
    if (_items)
    {
        [self getFlowWithFlow:nil detial:__ACCOMPARNY_HOSPITAL_FLOW_DETAIL__];
    }
    else
    {
        [self getFlowWithFlow:__FLOW__ detial:__ACCOMPARNY_HOSPITAL_FLOW_DETAIL__];
    }
}

- (void)makeInjectInHomeFlow
{
    if (_items)
    {
        [self getFlowWithFlow:nil detial:__INJECT_FLOW_DETAIL__];
    }
    else
    {
        [self getFlowWithFlow:__FLOW__ detial:__INJECT_FLOW_DETAIL__];
    }
}

- (void)makeInjectInInHospitalFlow
{
    if (_items)
    {
        [self getFlowWithFlow:nil detial:__ACCOMPARNY_HOSPITAL_FLOW_DETAIL__];
    }
    else
    {
        [self getFlowWithFlow:__FLOW__ detial:__ACCOMPARNY_HOSPITAL_FLOW_DETAIL__];
    }
}

- (void)makeGetTestReportFlow
{
    if (_items)
    {
        [self getFlowWithFlow:nil detial:__GETTESTREPORT_FLOW_DETAIL__];
    }
    else
    {
        [self getFlowWithFlow:__FLOW__ detial:__GETTESTREPORT_FLOW_DETAIL__];
    }
}

- (void)getFlowWithFlow:(NSArray *)flow detial:(NSArray *)detial
{
    if (flow)
    {
        if (flow.count != detial.count)
        {
            MESSAGE(@"流程创建失败");
            
            return;
        }
    }
    else
    {
        if (_items.count != detial.count)
        {
            MESSAGE(@"流程更新发生错误");
            
            return;
        }
    }
    
    NSMutableArray *items = flow?[[NSMutableArray alloc] init]:nil;
    
    for (int i = 0; i < detial.count; i++)
    {
        RWFlowItem *item = !flow?_items[i]:[[RWFlowItem alloc] init];
        
        if (i == RWOrderStatusDidPay)
        {
            item.faceImage = [UIImage imageNamed:@"start"];
            item.nextStep = detial[i];
        }
        else if (i < _faceStatus)
        {
            item.faceImage = [UIImage imageNamed:@"finish"];
            item.nextStep = detial[i];
        }
        else if (i == _faceStatus)
        {
            if (i == RWOrderStatusUserConfirmEnd)
            {
                item.faceImage = [UIImage imageNamed:@"end"];
            }
            else if (i != RWOrderStatusWaitService &&
                     i != RWOrderStatusServiceServiceEnd)
            {
                item.faceImage = [UIImage imageNamed:@"nextStep"];
            }
            else
            {
                item.faceImage = [UIImage imageNamed:@"finish"];
            }
            item.nextStep = detial[i];
        }
        else if (i == _faceStatus + 1)
        {
            if (i == RWOrderStatusServiceDidReceiveOrder ||
                i == RWOrderStatusUserConfirmEnd)
            {
                item.faceImage = [UIImage imageNamed:@"nextStepLong"];
            }
            else
            {
                item.faceImage = [UIImage imageNamed:@"wait"];
            }
        }
        else
        {
            if (i == RWOrderStatusUserConfirmEnd)
            {
                
            }
            
            item.faceImage = [UIImage imageNamed:@"wait"];
        }
        
        if (flow)
        {
            item.faceDescription = flow[i];
            [items addObject:item];
        }
    }

    _items = flow?items:_items;
}

@end

@implementation RWFlowItem @end

