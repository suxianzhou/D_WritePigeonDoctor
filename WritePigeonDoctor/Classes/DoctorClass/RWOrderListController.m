//
//  RWOrderListController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/23.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWOrderListController.h"
#import "RWMainTabBarController.h"
#import "RWOrderController.h"
#import "RWOrderListCell.h"
#import "RWDropDownMenu.h"
#import "MJRefresh.h"
@interface RWOrderListController ()

<
    UITableViewDelegate,
    UITableViewDataSource,
    RWRequsetDelegate,
    RWDropDownMenuDelegate
>

@property (nonatomic,strong)UITableView *orderList;

@property (nonatomic,strong)NSArray *orderResource;

@property (nonatomic,strong)RWRequsetManager *requestManager;
@property (nonatomic,strong)RWUser *user;

@property (nonatomic,strong)RWDropDownMenu *dropDownMeun;

@end

@implementation RWOrderListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _searchType = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _requestManager = [[RWRequsetManager alloc] init];
    _requestManager.delegate = self;
    
    _user = [[RWDataBaseManager defaultManager] getDefualtUser];

    [self initNavigationBar];
    
    _orderList = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    [self.view addSubview:_orderList];
    
    [_orderList mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    _orderList.delegate = self;
    _orderList.dataSource = self;
    _orderList.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(refreshHeaderAction:)];
    _orderList.mj_header.tintColor=[UIColor blueColor];
    _orderList.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                              refreshingAction:@selector(refreshFooterAction:)];
    _orderList.mj_footer.hidden = YES;

    [_orderList registerClass:[RWOrderListCell class]
       forCellReuseIdentifier:NSStringFromClass([RWOrderListCell class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
    if (_segmentControl)
    {
        if (!_segmentControl.superview)
        {
            [self.navigationController.navigationBar addSubview:_segmentControl];
        }
        
        _segmentControl.selectedSegmentIndex = 1;
    }
    
    if (_searchType == 0)
    {
        if (_user.username)
        {
            [_requestManager searchOrderWithDoctorUserName:_user.username
                                               orderStatus:0];
        }
    }
    else
    {
        [_requestManager searchOrderWithOrderStatus:_searchType];
    }
    
    if (_orderResource.count >= 10)
    {
        _orderList.mj_footer.hidden = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_dropDownMeun removeFromSuperview];
    [_segmentControl removeFromSuperview];
}

- (void)searchResultOrders:(NSArray *)orders responseMessage:(NSString *)responseMessage
{
    if (orders)
    {
        _orderResource = orders;
        [_orderList reloadData];
        
        return;
    }
    
    [RWSettingsManager promptToViewController:self
                                        Title:responseMessage
                                     response:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderResource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWOrderListCell class]) forIndexPath:indexPath];
    
    cell.order = _orderResource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWOrderController *orderController = [[RWOrderController alloc] init];
    orderController.order = _orderResource[indexPath.row];
    
    [_segmentControl removeFromSuperview];
    [self pushNextWithViewcontroller:orderController];
}

- (void)initNavigationBar
{
    self.navigationItem.hidesBackButton = YES;
    
    if (_searchType == 0)
    {
        UIBarButtonItem *faceConsult = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStyleDone target:self action:@selector(toFaceConsult)];
        
        self.navigationItem.rightBarButtonItem = faceConsult;
    }
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction action:^(UIBarButtonItem *barButtonItem) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)toFaceConsult
{
    if (_dropDownMeun.superview)
    {
        [_dropDownMeun removeFromSuperview];
        _orderList.userInteractionEnabled = YES;
        
        return;
    }
    
    _orderList.userInteractionEnabled = NO;
    
    RWMainTabBarController *mainTab = (RWMainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    NSArray *functions = mainTab.faceOrder?
                        [RWMenuItem hasOrderItems]:
                        [RWMenuItem notHasOrderItems];
    
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
    _orderList.userInteractionEnabled = YES;
    
    if (!item && !indexPath)
    {
        return;
    }
    
    switch (item.function)
    {
        case RWFunctionOfFaceOrder:
        {
            RWMainTabBarController *mainTBar = (RWMainTabBarController *)self.tabBarController;
            
            [mainTBar searchProceedingOrder];
            
            break;
        }
        case RWFunctionOfCancelOrder:
        {
            RWMainTabBarController *mainTBar = (RWMainTabBarController *)self.tabBarController;
            
            [mainTBar cancelFaceOrder];
            
            break;
        }
        case RWFunctionOfCustom:
        {
            //协议
            
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
#pragma --- Action

-(void)refreshHeaderAction:(MJRefreshHeader *) header
{
    if (_searchType == 0)
    {
        if (_user.username)
        {
            [_requestManager searchOrderWithDoctorUserName:_user.username
                                               orderStatus:0];
        }
    }
    else
    {
        [_requestManager searchOrderWithOrderStatus:_searchType];
    }
    [_orderList.mj_header endRefreshing];
}

-(void)refreshFooterAction:(MJRefreshFooter *) footer
{
    if (_searchType == 0)
    {
        if (_user.username)
        {
            [_requestManager searchOrderWithDoctorUserName:_user.username
                                               orderStatus:0];
        }
    }
    else
    {
        [_requestManager searchOrderWithOrderStatus:_searchType];
    }
    [_orderList.mj_footer endRefreshing];
}

@end
