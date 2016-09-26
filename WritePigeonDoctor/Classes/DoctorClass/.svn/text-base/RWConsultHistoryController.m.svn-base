//
//  RWConsultHistoryController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/9.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWConsultHistoryController.h"
#import "RWDoctorListCell.h"
#import "RWDataBaseManager+ChatCache.h"
#import "RWMainTabBarController.h"
#import "RWConsultNotesController.h"
#import "RWMainTabBarController.h"
#import "RWOrderListController.h"
#import "RWDropDownMenu.h"

@interface RWConsultHistoryController ()

<
    UITableViewDelegate,
    UITableViewDataSource,
    RWDropDownMenuDelegate
>

@property (nonatomic,strong)UITableView *historyList;
@property (nonatomic,strong)NSArray *historys;
@property (nonatomic,strong)UISegmentedControl *segment;

@property (nonatomic,strong)RWDataBaseManager *baseManager;

@property (nonatomic,strong)RWDropDownMenu *dropDownMeun;

@end

@implementation RWConsultHistoryController

- (void)initViews
{
    _historyList = [[UITableView alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStylePlain];
    [self.view addSubview:_historyList];
    
    _historyList.showsVerticalScrollIndicator = NO;
    _historyList.showsHorizontalScrollIndicator = NO;
    
    _historyList.delegate = self;
    _historyList.dataSource = self;
    
    [_historyList registerClass:[RWDoctorListCell class]
         forCellReuseIdentifier:NSStringFromClass([RWDoctorListCell class])];
    
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"咨询历史",@"订单列表"]];
    
    _segment.tintColor = [UIColor whiteColor];
    _segment.selectedSegmentIndex = 0;
    
    [_segment addTarget:self
                 action:@selector(segmentSelected:)
       forControlEvents:UIControlEventValueChanged];
    
    [self.navigationController.navigationBar addSubview:_segment];
    
    CGRect frame = self.navigationController.navigationBar.bounds;
    CGPoint center = CGPointMake(frame.size.width / 2 , frame.size.height / 2);
    
    frame.size.width -= 150;
    frame.size.height -= 15;
    
    _segment.frame = frame;
    _segment.center = center;
}

- (void)segmentSelected:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex)
    {
        RWOrderListController *orderList = [[RWOrderListController alloc] init];
        orderList.segmentControl = _segment;
        
        [self.navigationController pushViewController:orderList animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _historys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWDoctorListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWDoctorListCell class]) forIndexPath:indexPath];
    
    cell.history = _historys[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWConsultNotesController *notesController = [[RWConsultNotesController alloc] init];
    
    notesController.history = _historys[indexPath.row];
    
    RWMainTabBarController *tabBar = (RWMainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [tabBar updateUnreadNumber];
    
    [_segment removeFromSuperview];
    [self pushNextWithViewcontroller:notesController];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_baseManager removeCacheMessageWith:_historys[indexPath.row]])
    {
        if ([_baseManager removeConsultHistory:_historys[indexPath.row]])
        {
            _historys = [_baseManager getConsultHistory];
            
            [_historyList reloadData];
        }
        else
        {
            MESSAGE(@"删除历史咨询失败");
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _baseManager = [RWDataBaseManager defaultManager];
    
    [self initNavigationBar];
    [self initViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_segment.superview)
    {
        [self.navigationController.navigationBar addSubview:_segment];
    }
    
    _segment.selectedSegmentIndex = 0;
    
    _historys = [_baseManager getConsultHistory];
    
    [_historyList reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_segment removeFromSuperview];
}

- (void)initNavigationBar
{
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *faceConsult = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStyleDone target:self action:@selector(toFaceConsult)];
    
    self.navigationItem.rightBarButtonItem = faceConsult;
    
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
        _historyList.userInteractionEnabled = YES;
        
        return;
    }
    
    _historyList.userInteractionEnabled = NO;

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
    _historyList.userInteractionEnabled = YES;
    
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

@end
