//
//  RWOrderController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/19.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWOrderController.h"
#import "RWMainTabBarController.h"

@interface RWOrderController ()

<
    RWNextStepViewDelegate,
    RWRequsetDelegate
>

@property (nonatomic,strong)RWRequsetManager *requestManager;

@end

@implementation RWOrderController

NSString *buttonTitle(RWOrderStatus orderstatus)
{
    if (orderstatus == RWOrderStatusWaitService)
    {
        return @"接单";
    }
    else if (orderstatus > RWOrderStatusWaitService &&
             orderstatus < RWOrderStatusUserConfirmEnd)
    {
        return @"取消订单";
    }
    else
    {
        return @"关闭";
    }
}

- (void)initViews
{
    RWOrderView *orderView = [RWOrderView orderViewAutoLayout:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
    } order:_order];
    
    [self.view addSubview:orderView];
    
    NSString *money = _order.orderstatus >= RWOrderStatusNotPay &&
                      _order.orderstatus < RWOrderStatusUserConfirmEnd?
                      [NSString stringWithFormat:@"￥%.2f 元",_order.money]:nil;
    
    RWNextStepView *nextStep =
                    [RWNextStepView nextStepTitle:buttonTitle(_order.orderstatus)
                                      information:money
                                       autoLayout:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(orderView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [self.view addSubview:nextStep];
    
    nextStep.delegate = self;
}

- (void)toNextStep:(RWNextStepView *)nextStep
{
    if (_order.orderstatus == RWOrderStatusWaitService)
    {
        RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
        _order.serviceid = user.username;
        [_requestManager updateOrderWithOrder:_order
                                  orderStatus:_order.orderstatus+1];
    }
    else if (_order.orderstatus > RWOrderStatusWaitService &&
             _order.orderstatus < RWOrderStatusUserConfirmEnd)
    {
#warning 取消订单
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)updateOrderStatusAtOrder:(RWOrder *)order responseMessage:(NSString *)responseMessage
{
    if (order)
    {
        _order = order;
        
        RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
        
        NSString *message = [NSString stringWithFormat:@"%@已接单，单击查看",user.name];
        
        [RWChatManager sendUpdateOrderStatusMessageTo:_order.payid
                                          orderStatus:_order.orderstatus
                                          sendMessage:message];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        RWMainTabBarController *tabBar = (RWMainTabBarController *)keyWindow.rootViewController;
        
        [tabBar searchProceedingOrder];
    }
    else
    {
        [RWSettingsManager promptToViewController:self
                                            Title:responseMessage
                                         response:nil];
    }
}

-(void)scorePercentDidChange:(CGFloat)newScorePercent
{
//    上传获得评分
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _requestManager = [[RWRequsetManager alloc] init];
    _requestManager.delegate = self;
    
    self.navigationItem.title = @"订单详情";
    
    if (_order.orderid)
    {
        [self initViews];
    }
    else
    {
        SHOWLOADING;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:
                                        [UIImage imageNamed:@"MainColor"]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:
                                            [UIImage imageNamed:@"渐变"]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)orderReceipt:(RWOrder *)order responseMessage:(NSString *)responseMessage
{
    DISSMISS;
    
    if (order && self.view.window)
    {
        _order = order;
        [self initViews];
    }
    else
    {
        if (self)
        {
            NSString *message = responseMessage?responseMessage:@"订单创建失败";
            
            [RWSettingsManager promptToViewController:self
                                                Title:message
                                             response:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
