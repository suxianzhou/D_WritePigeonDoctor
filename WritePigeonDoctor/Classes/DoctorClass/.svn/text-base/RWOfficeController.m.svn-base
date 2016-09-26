//
//  RWOfficeController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/6.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWOfficeController.h"
#import "RWDataBaseManager+NameCardCollectMessage.h"
#import "RWDescriptionView.h"
#import "RWDropDownMenu.h"
#import "MyAccountViewController.h"
#import "RWVisitSettingsController.h"
#import "RWConsultHistoryController.h"
#import "RWOrderListController.h"
#import "RWMainTabBarController.h"

@protocol RWWorkingViewDelegate;
typedef NS_ENUM(NSInteger,RWWorkingViewType);
@interface RWWorkingView : UIView

+ (instancetype)workingWithUser:(RWUser *)user
                       delegate:(id<RWWorkingViewDelegate>)delegate;

@end

@protocol RWWorkingViewDelegate <NSObject>

- (void)workingWithType:(RWWorkingViewType)type;

@end

typedef NS_ENUM(NSInteger,RWWorkingViewType)
{
    RWWorkingViewTypeWorking,
    RWWorkingViewTypeHistory,
    RWWorkingViewTypeHomeVisit
};

@interface RWOfficeController ()

<
    UITableViewDelegate,
    UITableViewDataSource,
    RWWorkingViewDelegate,
    RWDropDownMenuDelegate
>

@property (nonatomic,strong)UITableView *workView;

@property (nonatomic,strong)RWUser *user;

@property (nonatomic,strong)RWDropDownMenu *dropDownMeun;

@end

@implementation RWOfficeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的工作室";
    [self initNavigationBar];
    
    _workView = [[UITableView alloc] initWithFrame:self.view.bounds
                                             style:UITableViewStyleGrouped];
    [self.view addSubview:_workView];
    
    [_workView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    _workView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _workView.bounces = NO;
    _workView.showsVerticalScrollIndicator = NO;
    _workView.showsHorizontalScrollIndicator = NO;
    
    _workView.delegate = self;
    _workView.dataSource = self;
    
    [_workView registerClass:[RWDescriptionCell class]
      forCellReuseIdentifier:NSStringFromClass([RWDescriptionCell class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([RWChatManager defaultManager].connectionState)
    {
        [self.tabBarController toLoginViewControllerAndVerifyStatus];
        return;
    }
    
    _user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    [_workView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _user?1:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWDescriptionCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.user = _user;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return tableView.bounds.size.height - 230;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _user?[RWWorkingView workingWithUser:_user delegate:self]:nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAccountViewController * vc = [[MyAccountViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)workingWithType:(RWWorkingViewType)type
{
    NSArray *office = [RWRequsetManager getOffice];
    
    switch (type)
    {
        case RWWorkingViewTypeWorking:
        {
            if (_user.groupID != office.count + 10)
            {
                // 上线接单 或 离线下班
            }
            
            break;
        }
        case RWWorkingViewTypeHistory:
        {
            if (_user.groupID == office.count + 10)
            {
                RWOrderListController *order = [[RWOrderListController alloc] init];
                
                [self.navigationController pushViewController:order animated:YES];
            }
            else
            {
                RWConsultHistoryController *consult =
                                            [[RWConsultHistoryController alloc] init];
                [self.navigationController pushViewController:consult animated:YES];
            }
            
            break;
        }
        case RWWorkingViewTypeHomeVisit:
        {
            if (_user.groupID == office.count + 10)
            {
                RWOrderListController *order = [[RWOrderListController alloc] init];
                order.searchType = RWOrderStatusWaitService;
                
                [self.navigationController pushViewController:order animated:YES];
            }
            else
            {
                RWVisitSettingsController *visit = [[RWVisitSettingsController  alloc] init];
                
                [self.navigationController pushViewController:visit animated:YES];
            }
             break;
        }
        default: break;
    }
}

- (void)initNavigationBar
{
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *faceConsult = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStyleDone target:self action:@selector(toFaceConsult)];
    
    self.navigationItem.rightBarButtonItem = faceConsult;
}

- (void)toFaceConsult
{
    if (_dropDownMeun.superview)
    {
        [_dropDownMeun removeFromSuperview];
        _workView.userInteractionEnabled = YES;
        
        return;
    }
    
    _workView.userInteractionEnabled = NO;
    
    NSArray *functions = [RWMenuItem hasOrderItems];
    
    CGFloat w = self.view.bounds.size.width - 10 - 100;
    
    if (!_dropDownMeun)
    {
        _dropDownMeun = [RWDropDownMenu dropDownMenuWithFrame:CGRectMake(w, 5, 100, 80)
                                                    functions:functions];
    }
    else
    {
        _dropDownMeun.functions = functions;
    }
    
    _dropDownMeun.arrowheadOffset = 80;
    _dropDownMeun.delegate = self;
    
    [self.view addSubview:_dropDownMeun];
}

- (void)dropDownMenu:(RWDropDownMenu *)dropDownMenu didSelectItem:(RWMenuItem *)item atIndexPath:(NSIndexPath *)indexPath
{
    _workView.userInteractionEnabled = YES;
    
    if (!item && !indexPath)
    {
        return;
    }
    
    switch (item.function)
    {
        case RWFunctionOfBuildOrder:
        {
//            RWMainTabBarController *mainTBar = (RWMainTabBarController *)self.tabBarController;
//            
//            [mainTBar buildOrder];
            
            break;
        }
        case RWFunctionOfFaceOrder:
        {
//            RWMainTabBarController *mainTBar = (RWMainTabBarController *)self.tabBarController;
//            
//            [mainTBar searchProceedingOrder];
            
            break;
        }
        case RWFunctionOfCancelOrder:
        {
//            RWMainTabBarController *mainTBar = (RWMainTabBarController *)self.tabBarController;
//            
//            [mainTBar cancelFaceOrder];
            
            break;
        }
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    if (touch.view == self.view)
    {
        [_dropDownMeun removeFromSuperview];
    }
}


@end

@interface RWWorkingView ()

@property (nonatomic,strong)UIButton *working;
@property (nonatomic,strong)UIButton *history;
@property (nonatomic,strong)UIButton *homeVisit;

@property (nonatomic,strong)RWUser *user;

@property (nonatomic,strong)id<RWWorkingViewDelegate> delegate;

@end

@implementation RWWorkingView

+ (instancetype)workingWithUser:(RWUser *)user delegate:(id<RWWorkingViewDelegate>)delegate
{
    RWWorkingView *working = [[RWWorkingView alloc] init];
    working.user = user;
    working.delegate = delegate;
    
    return working;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _working = [[UIButton alloc] init];
        _history = [[UIButton alloc] init];
        _homeVisit = [[UIButton alloc] init];
        
        [_working setTitle:@"上线坐诊" forState:UIControlStateNormal];
        [_history setTitle:@"查看历史" forState:UIControlStateNormal];
        [_homeVisit setTitle:@"出诊信息" forState:UIControlStateNormal];
        
        [_working setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_history setTitleColor:__WPD_MAIN_COLOR__ forState:UIControlStateNormal];
        [_homeVisit setTitleColor:__WPD_MAIN_COLOR__ forState:UIControlStateNormal];
        
        _working.backgroundColor = __WPD_MAIN_COLOR__;
        _history.layer.borderColor = [__WPD_MAIN_COLOR__ CGColor];
        _history.layer.borderWidth = 1.5f;
        _homeVisit.layer.borderColor = [__WPD_MAIN_COLOR__ CGColor];
        _homeVisit.layer.borderWidth = 1.5f;
        
        [self addSubview:_working];
        [self addSubview:_history];
        [self addSubview:_homeVisit];
        
        [_working addTarget:self
                     action:@selector(responseButton:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_history addTarget:self
                     action:@selector(responseButton:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [_homeVisit addTarget:self
                     action:@selector(responseButton:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)responseButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"上线坐诊"])
    {
        [_delegate workingWithType:RWWorkingViewTypeWorking];
    }
    else if ([button.titleLabel.text isEqualToString:@"查看历史"])
    {
        [_delegate workingWithType:RWWorkingViewTypeHistory];
    }
    else
    {
        [_delegate workingWithType:RWWorkingViewTypeHomeVisit];
    }
}

- (void)setUser:(RWUser *)user
{
    _user = user;
    
    NSArray *office = [RWRequsetManager getOffice];
    
    if (_user.groupID == office.count + 10)
    {
        [_working setTitle:@"去接单" forState:UIControlStateNormal];
    }
    else
    {
        [_working setTitle:@"上线坐诊" forState:UIControlStateNormal];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    NSArray *office = [RWRequsetManager getOffice];
    
    if (_user.groupID == office.count + 10)
    {
        [self servicerAutoLayout];
    }
    else
    {
        [self consultOnLineAutoLayout];
    }
}

- (void)consultOnLineAutoLayout
{
    CGFloat w = self.bounds.size.width / 2 - 30;
    CGFloat h = 40.f;
    
    [_history mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];
    
    [_homeVisit mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
        make.left.equalTo(_history.mas_right).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];
    
    [_working mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.bottom.equalTo(_history.mas_top).offset(-15);
    }];
}

- (void)servicerAutoLayout
{
    CGFloat w = self.bounds.size.width / 2 - 30;
    CGFloat h = 40.f;
    
    [_working mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];
    
    [_history mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
        make.left.equalTo(_working.mas_right).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];
}

@end
