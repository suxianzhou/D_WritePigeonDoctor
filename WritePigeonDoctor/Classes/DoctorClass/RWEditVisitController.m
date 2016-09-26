
//
//  RWEditVisitController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/9.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWEditVisitController.h"
#import "RWCustomPicker.h"

@interface RWTextFieldCell :UITableViewCell
@property (nonatomic,strong)UITextField *textField;
@end

@interface RWEditVisitController ()

<
    UITableViewDelegate,
    UITableViewDataSource,
    RWAlertPickerDelegate,
    RWAlertPickerDataSource,
    UITextFieldDelegate
>

@property (nonatomic,strong)UITableView *editVisit;

@property (nonatomic,strong)NSArray *sectionText;
@property (nonatomic,strong)NSArray *rowSource;
@property (nonatomic,strong)NSArray *placeHolders;
@property (nonatomic,strong)NSArray *objectsKeys;

@property (nonatomic,strong)NSIndexPath *faceIndexPath;

@property (nonatomic,copy)void (^save)(RWVisit *visit);

@end

@implementation RWEditVisitController

+ (instancetype)visitWithSave:(void (^)(RWVisit *))save
{
    RWEditVisitController *edit = [[RWEditVisitController alloc] init];
    edit.save = save;
    edit.visit = [[RWVisit alloc] init];
    
    return edit;
}

- (void)initNavgiationBar
{
    self.navigationItem.title = @"编辑出诊信息";
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveVisit)];
    
    NSArray *items = @[save];
    
    if (_revise)
    {
        UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
        
        items = @[save,delete];
    }
    
    self.navigationItem.rightBarButtonItems = items;
}

- (void)saveVisit
{
    for (int i = 0; i < _placeHolders.count; i++)
    {
        for (int j = 0; j < [_placeHolders[i] count]; j++)
        {
            if (![_visit valueForKey:_objectsKeys[i][j]])
            {
                [RWSettingsManager promptToViewController:self
                                                    Title:_placeHolders[i][j]
                                                 response:nil];
                
                return;
            }
        }
    }
    
    _save(_visit);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)delete
{
    _visit.isDelete = YES;
    _save(_visit);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initResource
{
    _sectionText = @[@"",@"",@"至",@"在"];
    
    NSMutableArray *hours = [[NSMutableArray alloc] init];
    NSMutableArray *minute = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 12; i++)
    {
        [hours addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for (int i = 0; i < 60; i++)
    {
        [minute addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    
    _rowSource = @[@[@[@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",]],
                   @[@[@"上午",@"中午",@"下午"]]],@[@[hours,@[@":"],minute]],
                   @[@[hours,@[@":"],minute]]];
    
    _objectsKeys = @[@[@"week",@"time"],@[@"start"],@[@"end"],@[@"address"]];
    _placeHolders = @[@[@"请选择星期",@"请选择时段"],@[@"请选择开始时间"],@[@"请选择结束时间"],
                      @[@"请填写地点"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initResource];
    [self initNavgiationBar];
    
    _editVisit = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStyleGrouped];
    [self.view addSubview:_editVisit];
    
    _editVisit.showsVerticalScrollIndicator = NO;
    _editVisit.showsHorizontalScrollIndicator = NO;
    
    _editVisit.bounces = NO;
    
    _editVisit.delegate = self;
    _editVisit.dataSource = self;
    
    [_editVisit registerClass:[RWTextFieldCell class]
       forCellReuseIdentifier:NSStringFromClass([RWTextFieldCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?2:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWTextFieldCell class]) forIndexPath:indexPath];
    
    cell.textField.placeholder = _placeHolders[indexPath.section][indexPath.row];
    cell.textField.text =
                [_visit valueForKey:_objectsKeys[indexPath.section][indexPath.row]];
    cell.textField.delegate = self;
    
    if (_revise && indexPath.section == 0)
    {
        cell.textField.textColor = [UIColor grayColor];
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 1)
    {
        UILabel *text = [[UILabel alloc] init];
        
        text.text = [NSString stringWithFormat:@"        %@",_sectionText[section]];
        text.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        
        return text;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3)
    {
        UILabel *text = [[UILabel alloc] init];
        
        text.text = @"        坐诊";
        text.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        
        return text;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section != 1?section == 0?1:30:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 3?30:1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_revise && indexPath.section == 0)
    {
        return;
    }
    
    _faceIndexPath = indexPath;
    
    if (_faceIndexPath.section != 3)
    {
        [RWAlertPicker alertPickerWithDataSource:self delegate:self];
    }
    else
    {
        RWTextFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textField.enabled = YES;
        [cell.textField becomeFirstResponder];
    }
    
}

- (NSDictionary *)pickerRecordAtAlertPicke:(RWAlertPicker *)alertPicker
{
    NSArray *source = _rowSource[_faceIndexPath.section][_faceIndexPath.row];
    
    NSMutableDictionary *defaultRecord = [[NSMutableDictionary alloc] init];
    
    if (_faceIndexPath.section != 1 && _faceIndexPath.section != 2)
    {
        for (int i = 0; i < source.count; i++)
        {
            if (source.count)
            {
                NSString *key = [NSString stringWithFormat:@"%d",i];
                [defaultRecord setObject:[source[i] firstObject] forKey:key];
            }
        }
    }
    else
    {
        defaultRecord = _faceIndexPath.section == 1?
                        [@{@"0":@"8",@"1":@":",@"2":@"00"} mutableCopy]:
                        [@{@"0":@"10",@"1":@":",@"2":@"00"} mutableCopy];
    }
    
    return defaultRecord;
}

- (RWPickerType)pickerTypeAtAlertPicke:(RWAlertPicker *)alertPicker
{
    return RWPickerTypeOfCustom;
}

- (NSString *)headerTitleAtAlertPicke:(RWAlertPicker *)alertPicker
{
    return _placeHolders[_faceIndexPath.section][_faceIndexPath.row];
}

- (NSArray<NSArray *> *)pickerSourceAtAlertPicke:(RWAlertPicker *)alertPicker
{
    return _rowSource[_faceIndexPath.section][_faceIndexPath.row];
}

- (void)alertPicker:(RWAlertPicker *)alertPicker selectRow:(NSInteger)row inComponent:(NSInteger)component record:(NSDictionary *)record
{
    NSMutableString *rec = [[NSMutableString alloc] init];
    
    for (int i = 0; i < record.count; i++)
    {
        [rec appendString:record[[NSString stringWithFormat:@"%d",i]]];
    }
    
    [_visit setValue:rec
              forKey:_objectsKeys[_faceIndexPath.section][_faceIndexPath.row]];
}

- (void)alertPicker:(RWAlertPicker *)alertPicker responseType:(RWPickerResponse)responseType
{
    if (!responseType)
    {
        [_editVisit reloadData];
    }
    else
    {
        [_visit setValue:nil
                  forKey:_objectsKeys[_faceIndexPath.section][_faceIndexPath.row]];
        [_editVisit reloadData];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_faceIndexPath.section == 3)
    {
        _visit.address = !range.length?
                        [NSString stringWithFormat:@"%@%@",textField.text,string]:
                [textField.text substringToIndex:textField.text.length - range.length];
    }
    
    return YES;
}

@end

@implementation RWTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextField alloc] init];
        [self addSubview:_textField];
        _textField.enabled = NO;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

@end

@implementation RWVisit

- (NSString *)mergeInformation
{
    return [NSString stringWithFormat:@"%@ 至 %@ 在 %@ 坐诊",_start,_end,_address];
}

@end
