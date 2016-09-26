//
//  RWVisitSettingsController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWVisitSettingsController.h"
#import "RWFlowChartView.h"
#import "RWEditVisitController.h"

@interface RWVisitSettingsController ()

<
    UITableViewDelegate,
    UITableViewDataSource,
    RWRequsetDelegate
>

@property (nonatomic,strong)UITableView *settings;

@property (nonatomic,strong)RWWeekHomeVisit *visit;

@property (nonatomic,assign)BOOL edit;

@property (nonatomic,strong)RWRequsetManager *requestManager;

@end

@implementation RWVisitSettingsController

- (void)initNavgaitionBar
{
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editing)];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addVisit)];
    
    self.navigationItem.rightBarButtonItems = @[edit,add];
}

- (void)editing
{
    _edit = _edit?NO:YES;
    [_settings setEditing:_edit animated:YES];
    
    [_settings reloadData];
}

- (void)addVisit
{
    RWEditVisitController *edit = [RWEditVisitController visitWithSave:^(RWVisit *visit)
   {
       _visit = _visit?_visit:[[RWWeekHomeVisit alloc] init];
       id obj = [_visit valueForKey:SWITCH_WEEK(visit.week)];
       
       if (!obj)
       {
           [_visit setValue:[[RWHomeVisitItem alloc] init]
                     forKey:SWITCH_WEEK(visit.week)];
           
           obj = [_visit valueForKey:SWITCH_WEEK(visit.week)];
       }

       [obj setValue:visit.mergeInformation forKey:SWITCH_TIME_SECTION(visit.time)];
       
       [_requestManager updateHomeVisitWithHomeVisit:_visit];
   }];
    
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _requestManager = [[RWRequsetManager alloc] init];
    _requestManager.delegate = self;
    
    [self initNavgaitionBar];
    
    _settings = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:_settings];
    
    [_settings mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    _settings.editing = _edit;
    _settings.showsVerticalScrollIndicator = NO;
    _settings.showsHorizontalScrollIndicator = NO;
    
    _settings.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settings.allowsSelection = NO;
    
    _settings.delegate = self;
    _settings.dataSource = self;
    
    [_settings registerClass:[RWFlowChartCell class]
      forCellReuseIdentifier:NSStringFromClass([RWFlowChartCell class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _edit = NO;
    [_settings setEditing:_edit animated:YES];
    
    if (!_visit)
    {
        [_requestManager obtainMyHomeVisit];
    }
}

- (void)requsetVisitHome:(RWWeekHomeVisit *)visitHome responseMessage:(NSString *)responseMessage
{
    if (visitHome)
    {
        _visit = visitHome;
        if (self.view.window) [_settings reloadData];
    }
    else
    {
        if (responseMessage)
        {
            [RWSettingsManager promptToViewController:self
                                                Title:responseMessage
                                             response:nil];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    
    for (NSString *key in __WEEK__)
    {
        if ([_visit valueForKey:SWITCH_WEEK(key)])
        {
            count ++;
        }
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id item = [_visit valueForKey:SWITCH_WEEK(__WEEK__[section])];
    
    NSInteger count = 0;
    
    for (NSString *key in __TIME_SECTION__)
    {
        if ([item valueForKey:SWITCH_TIME_SECTION(key)])
        {
            count++;
        }
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWFlowChartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWFlowChartCell class]) forIndexPath:indexPath];
    cell.faceContent.textColor = [UIColor grayColor];
    
    id item = [_visit valueForKey:SWITCH_WEEK(__WEEK__[indexPath.section])];
    
    for (int i = (int)indexPath.row; i < __TIME_SECTION__.count; i++)
    {
        NSString *text = [item valueForKey:SWITCH_TIME_SECTION(__TIME_SECTION__[i])];
        
        if (text)
        {
            NSString *information = [NSString stringWithFormat:@"%@ %@",__TIME_SECTION__[i],text];
            cell.faceContent.text = information;
        }
        else
        {
            continue;
        }
        
        NSInteger rows = [tableView numberOfRowsInSection:indexPath.section];
        
        if (rows == 1)
        {
            cell.statusImage.image = [UIImage imageNamed:@"full"];
        }
        else
        {
            if (!indexPath.row)
            {
                cell.statusImage.image = [UIImage imageNamed:@"start"];
            }
            else if (indexPath.row == rows - 1)
            {
                cell.statusImage.image = [UIImage imageNamed:@"end"];
            }
            else
            {
                cell.statusImage.image = [UIImage imageNamed:@"finish"];
            }
        }
        
        return cell;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = [NSString stringWithFormat:@"     %@",__WEEK__[section]];
    headerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _edit?UITableViewCellEditingStyleInsert:UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWEditVisitController *edit = [RWEditVisitController visitWithSave:^(RWVisit *visit)
    {
        id value = visit.isDelete?nil:visit.mergeInformation;
        id obj = [_visit valueForKey:SWITCH_WEEK(visit.week)];
        [obj setValue:value forKey:SWITCH_TIME_SECTION(visit.time)];
        
        [_requestManager updateHomeVisitWithHomeVisit:_visit];
    }];
    
    edit.revise = YES;
    edit.visit.week = __WEEK__[indexPath.section];
    
    id item = [_visit valueForKey:SWITCH_WEEK(__WEEK__[indexPath.section])];
    
    for (int i = (int)indexPath.row; i < __TIME_SECTION__.count; i++)
    {
        if ([item valueForKey:SWITCH_TIME_SECTION(__TIME_SECTION__[i])])
        {
            edit.visit.time = __TIME_SECTION__[i];
            
            break;
        }
    }
    
    [self.navigationController pushViewController:edit animated:YES];
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
