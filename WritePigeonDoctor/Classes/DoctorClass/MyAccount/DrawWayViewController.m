//
//  DrawWayViewController.m
//  WritePigeonDoctor
//
//  Created by ZYJY on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "DrawWayViewController.h"
#import "PayTableViewCell.h"

@interface DrawWayViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * drawTableView;
@property (nonatomic,strong) UIButton * drawButton;
@property (nonatomic,assign) NSInteger  drawInt;
@property (nonatomic,strong) NSArray * dataSource;


@end

@implementation DrawWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _drawInt = 1;
    self.navigationItem.title = @"提现方式";
    [self initTableView];
    [self initData];
}
- (void)initData
{
    _dataSource = @[
//  @{@"title"    :@"支付宝",
//                      @"icon"     :@"36x36"},
  
                    @{@"title"    :@"微信",
                      @"icon"     :@"icon36_appwx_logo"}
                     ];
}

- (void)initTableView
{
    _drawTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStyleGrouped];
    _drawTableView.backgroundColor = Wonderful_GrayColor1;
    _drawTableView.backgroundView.backgroundColor = [UIColor clearColor];
    _drawTableView.showsVerticalScrollIndicator = NO;
    _drawTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _drawTableView.scrollEnabled = NO;
    _drawTableView.delegate = self;
    _drawTableView.dataSource = self;
    [self.view addSubview:_drawTableView];

    [_drawTableView registerClass:[setPayWayCell class] forCellReuseIdentifier:NSStringFromClass([setPayWayCell class])];

    _drawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _drawButton.frame = CGRectMake(0, SCREEN_HEIGHT-108, SCREEN_WIDTH, 44);
    _drawButton.backgroundColor = __WPD_MAIN_COLOR__;
    [_drawButton setTitle:@"立即提现" forState:(UIControlStateNormal)];
    [_drawButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_drawButton addTarget:self action:@selector(drawButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_drawButton];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    setPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([setPayWayCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_dataSource[indexPath.row][@"icon"]];
    cell.textLabel.text = _dataSource[indexPath.row][@"title"];

    if (indexPath.row == 0) {
        cell.rirImage.image = [UIImage imageNamed:@"选择"];
    }
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       NSIndexPath * path1 = [NSIndexPath indexPathForRow:0 inSection:0];
        setPayWayCell * cell1 = [tableView cellForRowAtIndexPath:path1];
        NSIndexPath * path2 = [NSIndexPath indexPathForRow:1 inSection:0];
        setPayWayCell * cell2 = [tableView cellForRowAtIndexPath:path2];
        
        if (indexPath.row == 0)
        {
            _drawInt = 1;
            cell1.rirImage.image = [UIImage imageNamed:@"选择"];
            cell2.rirImage.image = [UIImage imageNamed:@"没选择"];
        }
//        if(indexPath.row == 1)
//        {
//            
//            _drawInt = 2;
//            cell1.rirImage.image = [UIImage imageNamed:@"没选择"];
//            cell2.rirImage.image = [UIImage imageNamed:@"选择"];
//        }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return @"请选择提现方式:";
}

- (void)drawButtonClick
{
    if (_drawInt == 1)
    {
        
    }
    else
    {
        
    }
}
@end
