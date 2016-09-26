//
//  RWOrderProgressController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/31.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWOrderProgressController.h"
#import "RWProceedingController.h"
#import "RWFlowChartView.h"

@interface RWOrderProgressController ()

<
    RWFlowChartViewDelegate,
    RWRequsetDelegate
>

@property (nonatomic,strong)RWFlow *flow;

@property (nonatomic,strong)RWFlowChartView *flowChart;

@property (nonatomic,strong)RWRequsetManager *requestManager;

@end

@implementation RWOrderProgressController

- (void)initNavigationBar
{
    RWFlowItem *item = _flow.items[_flow.faceStatus];
    
    self.navigationItem.title = item.faceDescription;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"箭头向下"] style:UIBarButtonItemStylePlain target:self action:@selector(returnMainView)];
    
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)returnMainView
{
    RWProceedingController *proceed = (RWProceedingController *)self.navigationController;
    [proceed returnMainView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addObserver];
    
    _requestManager = [[RWRequsetManager alloc] init];
    _requestManager.delegate = self;
    
    _flow = _flow?_flow:[[RWFlow alloc] initWithOrder:_order];
    
    [self initNavigationBar];
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 64;
    
    _flowChart = [RWFlowChartView flowViewWithFrame:frame
                                               flow:_flow];
    [self.view addSubview:_flowChart];
    _flowChart.updateStatus = self;
    
    NSIndexPath *indexPath = _flow.faceStatus == RWOrderStatusUserConfirmEnd?
                        [NSIndexPath indexPathForRow:_flow.faceStatus inSection:0]:
                        [NSIndexPath indexPathForRow:_flow.faceStatus + 1 inSection:0];
    
    [_flowChart scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:NO];
}

- (void)setOrder:(RWOrder *)order
{
    _order = order;
    
    _flow = _flow?_flow:[[RWFlow alloc] initWithOrder:_order];
    [_flow updateWithOrder:_order];
    
    if (self.view.window && _flowChart)
    {
        [_flowChart reloadData];
    }
}

- (void)addObserver
{
    notification_observe(DownloadFinishNotification,^(NSNotification * _Nonnull note) {
        
        NSString *message = note.userInfo[DownloadFinishNotification];
        
        if (!message)
        {
            if (_flowChart)
            {
                [_flowChart reloadData];
            }
        }
    });
    
    notification_observe(RWHeaderDownLoadFinishNotification,^(NSNotification * _Nonnull note)
    {
        if (self.view.window && _flowChart)
        {
            [_flowChart reloadData];
        }
    });
    
    notification_observe(RWUpdateOrderStatusNotification,^(NSNotification * _Nonnull note)
                         
    {
        [_requestManager searchProceedingOrderWithUsername:_order.payid];
        
    });
}

- (void)searchResultOrders:(NSArray *)orders responseMessage:(NSString *)responseMessage
{
    if (orders.count == 1)
    {
        RWOrder *order = [orders firstObject];
        
        _order = order;
    }
}

- (void)updateOrderStatus:(RWOrderStatus)orderStatus
{
    [_requestManager updateOrderWithOrder:_order orderStatus:orderStatus + 1];
}

- (void)updateOrderStatusAtOrder:(RWOrder *)order responseMessage:(NSString *)responseMessage
{
    if (order)
    {
        _order = order;
        [_flow updateWithOrder:_order];
        
        if (self.view.window && _flowChart)
        {
            [_flowChart reloadData];
        }
        
        switch (_order.orderstatus)
        {
            case RWOrderStatusWaitUserStart:
            {
                RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
                
                NSString *message = [NSString stringWithFormat:@"%@已接单，单击查看",user.name];
                
                [RWChatManager sendUpdateOrderStatusMessageTo:_order.payid
                                                  orderStatus:_order.orderstatus
                                                  sendMessage:message];
                
                break;
            }
            case RWOrderStatusServiceStart:
            {
                RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
                
                NSString *message = [NSString stringWithFormat:@"%@开始为您服务开始",user.name];
                
                [RWChatManager sendUpdateOrderStatusMessageTo:_order.payid
                                                  orderStatus:_order.orderstatus
                                                  sendMessage:message];
                
                break;
            }
            case RWOrderStatusServiceServiceEnd:
            {
                NSString *message = [NSString stringWithFormat:@"服务已结束，为本次服务打个分吧~~"];
                
                [RWChatManager sendUpdateOrderStatusMessageTo:_order.payid
                                                  orderStatus:_order.orderstatus
                                                  sendMessage:message];
                
                break;
            }
            default: break;
        }
    }
    else
    {
        [RWSettingsManager promptToViewController:self
                                            Title:responseMessage
                                         response:nil];
    }
}

- (void)callOtherPartyAtFlowChartView:(RWFlowChartView *)flowChartView
{
    NSURL *teleUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_order.serviceid]];
    
    [[UIApplication sharedApplication] openURL:teleUrl];
}

- (void)flowChartView:(RWFlowChartView *)flowChartView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    RWFlowItem *item = _flow.items[indexPath.row];
    
    if (item.nextStep.length > 0)
    {
        [RWSettingsManager promptToViewController:self
                                            Title:item.nextStep
                                         response:nil];
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
