//
//  RWMainTabBarController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/7/25.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWMainTabBarController.h"
#import "RWMainViewController.h"
#import "RWCommunityController.h"
#import "RWSettingsViewController.h"
#import "RWOfficeController.h"
#import "RWCustomNavigationController.h"
#import "RWDataBaseManager+ChatCache.h"
#import "UITabBar+badge.h"
#import "RWProceedingController.h"
#import "InfoViewController.h"
#import "FEAuthentViewController.h"
#import "RWRequsetManager+ExamineVersion.h"
#import "FEUserSettingViewController.h"
#import "AuditLoggingViewController.h"

@interface RWMainTabBarController ()

<
    RWRequsetDelegate
>

@property (nonatomic,strong)UIView *coverLayer;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSArray *selectImages;
@property (nonatomic,strong)NSArray *views;

@end

@implementation RWMainTabBarController

@synthesize coverLayer;

- (void)toRootViewController
{
    [self selectWithIndex:0];
}

- (void)addObservers
{
    notification_observe(RWNewMessageNotification,^(NSNotification * _Nonnull note) {
        
        [self updateUnreadNumber];
    });
    
    notification_observe(RWLoginFinishNotification,^(NSNotification * _Nonnull note) {
        
        if ([[note.userInfo objectForKey:RWLoginFinishNotification] boolValue])
        {
            [self examineDefaultSettings];
            [self verifyStatus];
        }
    });
    
    notification_observe(RWUpdateOrderStatusNotification,^(NSNotification * _Nonnull note)
    {
        UIViewController *viewController = self.parentViewController;
        
        Class proceed = [RWProceedingController class];
        
        if (!viewController || ![viewController isKindOfClass:proceed])
        {
            NSString *text = note.userInfo[RWUpdateOrderStatusNotification];
            
            [RWSettingsManager multipleCustomPromptToViewController:self title:text certainTitle:@"立即查看" cancelTitle:@"取消" certainResponse:^{
                
                [self searchProceedingOrder];
            } cancelResponse:nil];
        }
    });
}

- (void)verifyStatus
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    if (!user.name || !user.gender || !user.age || !user.header)
    {
        InfoViewController * Info=[[InfoViewController alloc]init];
        
        [self presentViewController:Info animated:YES completion:nil];
        
        return;
    }
    
    switch (user.doctorStatus)
    {
        case RWDoctorStatusRevoke:
        {
            NSString *title = @"您的医护资格已经被注销或者被封禁\n\n查看原因请点击 -> 查看原因\n返回请点击 -> 取消\n\n也可以到\n 我 -> 个人设置 -> 账号状态 \n查看原因";
            
            [RWSettingsManager multipleCustomPromptToViewController:self
                                                              title:title
                                                       certainTitle:@"查看原因"
                                                        cancelTitle:@"取消"
                                                    certainResponse:^
             {
                
                 [self toMyInformationView];
                 
             } cancelResponse:^{
                 [self toRootViewController];
             }];
            
            break;
        }
        case RWDoctorStatusUnUpload:
        {
            NSString *title = @"白鸽医护（医护端）需要验证个人信息以及从业资质才能使用。如果需要在线问诊，陪诊服务请下载白鸽医护客户端。\n\n验证个人信息请点击 -> 马上验证\n返回请点击 -> 取消";
            
            [RWSettingsManager multipleCustomPromptToViewController:self
                                                              title:title
                                                       certainTitle:@"马上验证"
                                                        cancelTitle:@"取消"
                                                    certainResponse:^
             {
                 [self toRootViewController];
                 
                
                 FEAuthentViewController * FEAVC=[[FEAuthentViewController alloc]init];
                 
                 [self presentViewController:FEAVC animated:YES completion:nil];
                 
             } cancelResponse:^{
                 [self toRootViewController];
             }];

            break;
        }
        case RWDoctorStatusReject:
        {
            NSString *title = @"您的验证申请被驳回\n\n查看原因请点击 -> 查看原因\n返回请点击 -> 取消\n\n也可以到\n 我 -> 个人设置 -> 账号状态 \n查看原因";
            
            [RWSettingsManager multipleCustomPromptToViewController:self
                                                              title:title
                                                       certainTitle:@"查看原因"
                                                        cancelTitle:@"取消"
                                                    certainResponse:^
             {
                 [self toMyInformationView];
                 
             } cancelResponse:^{
                 [self toRootViewController];
             }];
            
            break;
        }
        case RWDoctorStatusWaitCheck:
        {
            NSString *title = @"您的身份验证信息我们正在努力审核，一般需要三个工作日，请耐心等待。";
            
            [RWSettingsManager promptToViewController:self
                                                Title:title
                                             response:^
            {
            
                [self toRootViewController];
            }];
            
            break;
        }
        case RWDoctorStatusPass: [self searchProceedingOrder];break;
        default:break;
    }
}

- (void)toMyInformationView
{
    [self selectWithIndex:3];
    
    UIViewController *settings = [self.viewControllers lastObject];
    
    FEUserSettingViewController * FESV=[[FEUserSettingViewController alloc]init];
    
    [settings.navigationController pushViewController:FESV animated:YES];
    
    AuditLoggingViewController * ALVC = [[AuditLoggingViewController alloc]init];
    
    [FESV.navigationController pushViewController:ALVC animated:YES];
}

- (void)updateUnreadNumber
{
    NSInteger number = [[RWDataBaseManager defaultManager] getUnreadNumber];
    
    if (number)
    {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNumber value:number atIndex:1];
    }
    else
    {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:number atIndex:1];
    }
    
    
}

- (void)examineDefaultSettings
{
    if (!SETTINGS_VALUE(__SERVICES_CACHE__))
    {
        RWRequsetManager *requestManager = [[RWRequsetManager alloc] init];
        [requestManager obtainServicesList];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initResource];
    [self compositonViewControllers];
    [self compositionCoverLayer];
    [self compositionButton];
    [self addObservers];
    [RWRequsetManager examineVersionWithController:self];
}

- (void)initResource
{
    _images = @[[UIImage imageNamed:@"资讯"],
                [UIImage imageNamed:@"工作室"],
                [UIImage imageNamed:@"社区"],
                [UIImage imageNamed:@"我"]];
    
    _selectImages = @[[UIImage imageNamed:@"资讯z"],
                      [UIImage imageNamed:@"工作室z"],
                      [UIImage imageNamed:@"社区z"],
                      [UIImage imageNamed:@"我z"]];
}

- (void)compositionCoverLayer
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    coverLayer = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    
    [self.tabBar addSubview:coverLayer];
    
    coverLayer.backgroundColor = [UIColor whiteColor];
}

- (void)compositonViewControllers
{
    
    RWMainViewController *main = [[RWMainViewController alloc]init];

    RWCustomNavigationController *mainNav = [[RWCustomNavigationController alloc]initWithRootViewController:main];

    RWOfficeController *office = [[RWOfficeController alloc]init];
    
    RWCustomNavigationController *officeNav = [[RWCustomNavigationController alloc]initWithRootViewController:office];
    
    RWCommunityController *community = [[RWCommunityController alloc]init];
    
    RWCustomNavigationController *communityNav = [[RWCustomNavigationController alloc]initWithRootViewController:community];
    
    RWSettingsViewController *settings = [[RWSettingsViewController alloc]init];
    
    RWCustomNavigationController *settingsNav = [[RWCustomNavigationController alloc]initWithRootViewController:settings];
    
    
    self.viewControllers = @[mainNav,officeNav,communityNav,settingsNav];
}

- (void)compositionButton
{
    CGFloat w = self.tabBar.frame.size.width / _images.count;
    
    CGFloat h = self.tabBar.frame.size.height;
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _images.count; i++)
    {
        [views addObject:[self tabBarButtonWithFrame:CGRectMake(w * i, 0, w, h) AndTag:i+1]];
    }
    
    _views = [views copy];
    
    [self selectWithIndex:0];
}

- (UIView *)tabBarButtonWithFrame:(CGRect)frame AndTag:(NSInteger)tag
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    view.tag = tag;
    
    [coverLayer addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.tag = tag * 10;
    imageView.image = _images[tag-1];
    
    [view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(view.mas_top).offset(1);
        make.bottom.equalTo(view.mas_bottom).offset(-1);
        make.width.equalTo(@(frame.size.height - 2));
        make.centerX.equalTo(view.mas_centerX).offset(0);
    }];
    
    [self addGestureRecognizerToView:view];
    
    return imageView;
}

- (void)addGestureRecognizerToView:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cutViewControllerWithGesture:)];
    
    tap.numberOfTapsRequired = 1;
    
    [view addGestureRecognizer:tap];
}

- (void)cutViewControllerWithGesture:(UITapGestureRecognizer *)tapGesture
{
    [self selectWithIndex:tapGesture.view.tag - 1];
}

- (void)selectWithIndex:(NSInteger)index
{
    for (int i = 0; i < _views.count; i++)
    {
        UIImageView *imageItem = _views[i];
        
        imageItem.image = _images[i];
    }
    
    UIImageView *imageItem = _views[index];
    
    imageItem.image = _selectImages[index];
    
    self.selectedIndex = index;
}

#pragma mark - handle

- (void)searchProceedingOrder
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    RWRequsetManager *requestManager = [[RWRequsetManager alloc] init];
    requestManager.delegate = self;
    
    [requestManager searchProceedingOrderWithUsername:user.username];
}

- (void)searchResultOrders:(NSArray *)orders responseMessage:(NSString *)responseMessage
{
    if (orders && orders.count == 1)
    {
        RWOrder *order = [orders firstObject];
        
        _faceOrder = order;
        UINavigationController *navigation = self.viewControllers[1];
        [navigation popToRootViewControllerAnimated:NO];
        
        [self selectWithIndex:1];
        
        UIViewController *history = [navigation.viewControllers firstObject];
        
        RWProceedingController *proceeding =
                            [RWProceedingController proceedingWithOrder:_faceOrder];
        
        [history presentViewController:proceeding animated:YES completion:nil];
    }
}

- (void)cancelFaceOrder
{
    UINavigationController *navigation = self.viewControllers[1];
    UIViewController *viewController = [navigation.viewControllers lastObject];
    
    NSString *title = @"如果医生已经接单，30分钟内我们不收取任何费用，超过30分钟将支付护士30元补偿金/n/n确认取消请点击 -> 确认 \n返回请点击 -> 取消";
    
    [RWSettingsManager multiplePromptToViewController:viewController
                                                Title:title
                                      certainResponse:^
    {
        RWRequsetManager *requestManager = [[RWRequsetManager alloc] init];
        requestManager.delegate = self;
        
        [requestManager updateOrderWithOrder:_faceOrder
                                 orderStatus:RWOrderStatusUserCancel];
                                                    
    } cancelResponse:nil];
}

- (void)updateOrderStatusAtOrder:(RWOrder *)order responseMessage:(NSString *)responseMessage
{
    if (order && order.orderstatus == RWOrderStatusUserCancel )
    {
        [MBProgressHUD Message:@"订单已取消" For:self.view];
    }
    else
    {
        NSString *message = responseMessage?responseMessage:@"订单取消失败，请稍后再试";
        
        [RWSettingsManager promptToViewController:self Title:message response:nil];
    }
}

@end
