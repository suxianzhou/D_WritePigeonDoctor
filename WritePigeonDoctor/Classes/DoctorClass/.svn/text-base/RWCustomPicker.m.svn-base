//
//  RWCustomPicker.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWCustomPicker.h"

@interface RWAlertPicker ()

<
    RWCustomPickerDelegate
>

@property (nonatomic,strong)UILabel *headerTitle;
@property (nonatomic,strong)UIButton *certain;
@property (nonatomic,strong)UIButton *cancel;

@property (nonatomic,strong)UIView *borderLayer;
@property (nonatomic,strong)UIView *coverLayer;

@end

NSString *const pickerViewButtonOfCertain = @"确定";

NSString *const pickerViewButtonOfCancel = @"取消";

@implementation RWAlertPicker

+ (instancetype)alertPickerWithDataSource:(id<RWAlertPickerDataSource>)dataSource
                                 delegate:(id<RWAlertPickerDelegate>)delegate
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    RWAlertPicker *alert = [[self alloc] initWithFrame:CGRectMake(0, 0, 300, 230)];
    alert.center = CGPointMake(window.bounds.size.width /2, window.bounds.size.height/2);
    
    alert.delegate = delegate;
    alert.dataSource = dataSource;
    
    [window addSubview:alert.coverLayer];
    [window addSubview:alert];
    
    return alert;
}

- (void)initViews
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 0.7;
    self.layer.masksToBounds = NO;
    
    _borderLayer = [[UIView alloc] init];
    _borderLayer.backgroundColor = [UIColor clearColor];
    _borderLayer.layer.cornerRadius = 10;
    _borderLayer.layer.borderWidth = 0.4;
    _borderLayer.layer.borderColor = [[UIColor grayColor] CGColor];
    _borderLayer.clipsToBounds = YES;
    [self addSubview:_borderLayer];
    
    _headerTitle = [[UILabel alloc] init];
    _headerTitle.textAlignment = NSTextAlignmentCenter;
    _headerTitle.text = @"请选择";
    _headerTitle.textColor = __WPD_MAIN_COLOR__;
    _headerTitle.font = [UIFont boldSystemFontOfSize:20];
    [_borderLayer addSubview:_headerTitle];
    
    _certain = [[UIButton alloc] init];
    [_borderLayer addSubview:_certain];
    _certain.layer.borderWidth = 0.4;
    _certain.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [_certain setTitle:pickerViewButtonOfCertain
             forState:UIControlStateNormal];
    
    [_certain setTitleColor:__WPD_MAIN_COLOR__
                  forState:UIControlStateNormal];
    
    [_certain addTarget:self
                action:@selector(certainButtonClick)
      forControlEvents:UIControlEventTouchUpInside];
    
    _cancel = [[UIButton alloc] init];
    
    [_borderLayer addSubview:_cancel];
    
    _cancel.layer.borderWidth = 0.4;
    _cancel.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [_cancel setTitle:pickerViewButtonOfCancel
            forState:UIControlStateNormal];
    
    [_cancel setTitleColor:[UIColor redColor]
                 forState:UIControlStateNormal];
    
    [_cancel addTarget:self
               action:@selector(cancelButtonClick)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    _coverLayer = [[UIView alloc] initWithFrame:window.bounds];
    _coverLayer.backgroundColor = [UIColor blackColor];
    _coverLayer.alpha = 0.5f;
}

- (void)certainButtonClick
{
    if (found_response(_delegate,@"alertPicker:responseType:"))
    {
        [_delegate alertPicker:self responseType:RWPickerResponseCertain];
    }
    
    [self removeFromSuperview];
}

- (void)cancelButtonClick
{
    if (found_response(_delegate,@"alertPicker:responseType:"))
    {
        [_delegate alertPicker:self responseType:RWPickerResponseCancel];
    }
    
    [self removeFromSuperview];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if (_coverLayer.superview)
    {
        [_coverLayer removeFromSuperview];
    }
}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        if (!_cancel)
        {
            [self initViews];
        }
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        if (!_cancel)
        {
            [self initViews];
        }
        
        [self autoLayoutViews];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self autoLayoutViews];
}

- (void)autoLayoutViews
{
    _borderLayer.frame = self.bounds;
    
    [_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_borderLayer.mas_left).offset(0);
        make.top.equalTo(_borderLayer.mas_top).offset(20);
        make.width.equalTo(@(_borderLayer.bounds.size.width));
        make.height.equalTo(@(20));
    }];
    
    [_certain mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_borderLayer.mas_right).offset(0);
        make.bottom.equalTo(_borderLayer.mas_bottom).offset(0);
        make.width.equalTo(@(_borderLayer.bounds.size.width/2));
        make.height.equalTo(@(40));
    }];
    
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_borderLayer.mas_left).offset(0);
        make.right.equalTo(_certain.mas_left).offset(0);
        make.bottom.equalTo(_borderLayer.mas_bottom).offset(0);
        make.top.equalTo(_certain.mas_top).offset(0);
    }];
}

- (void)setDataSource:(id<RWAlertPickerDataSource>)dataSource
{
    _dataSource = dataSource;
    
    if (found_response(_dataSource,@"headerTitleAtAlertPicke:") &&
        [_dataSource headerTitleAtAlertPicke:self])
    {
        _headerTitle.text = [_dataSource headerTitleAtAlertPicke:self];
    }
    
    CGFloat h = _borderLayer.bounds.size.height - 41 - 41;
    CGRect frame = CGRectMake(10, 41, _borderLayer.bounds.size.width - 20, h);
    
    _pickerView =
        [RWCustomPicker pickerViewWithFrame:frame
                                       type:[_dataSource pickerTypeAtAlertPicke:self]
                              defaultRecord:[_dataSource pickerRecordAtAlertPicke:self]
                                   delegate:self];
    
    [_borderLayer addSubview:_pickerView];
}

- (NSArray<NSArray *> *)customPickerSource
{
    if (found_response(_dataSource,@"pickerSourceAtAlertPicke:"))
    {
        return [_dataSource pickerSourceAtAlertPicke:self];
    }
    
    return nil;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component record:(NSDictionary *)record
{
    if (found_response(_delegate,@"alertPicker:selectRow:inComponent:record:"))
    {
        [self.delegate alertPicker:self
                         selectRow:row
                       inComponent:component
                            record:record];
    }
}

#pragma mark - others

+ (NSDictionary *)dateContextWithString:(NSString *)string
{
    NSArray *arr = [string componentsSeparatedByString:@"-"];
    
    if (arr.count != 3)
    {
        return nil;
    }
    
    return @{@"0":arr[0],@"1":arr[1],@"2":arr[2]};
}

+ (NSString *)dateStringWithContext:(NSDictionary *)context
{
    return [NSString stringWithFormat:@"%d-%.2d-%.2d",[context[@"0"] intValue],
            [context[@"1"] intValue],
            [context[@"2"] intValue]];
}

+ (NSDate *)pickerDateWithString:(NSString *)pickerString
{
    NSArray *arr = [pickerString componentsSeparatedByString:@"-"];
    
    if (arr.count == 3)
    {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setYear:[arr[0] integerValue]];
        [comps setMonth:[arr[1] integerValue]];
        [comps setDay:[arr[2] integerValue]];
        
        return [[NSCalendar currentCalendar] dateFromComponents:comps];
    }
    
    return [NSDate date];
}

@end

typedef NS_ENUM(NSInteger ,RWClockDaysCount) {
    
    RWClockDaysCountOf31    = 2,
    RWClockDaysCountOf30    = 3,
    RWClockDaysCountOf28    = 4,
    RWClockDaysCountOf29    = 5
};

@interface RWCustomPicker ()

<
    UIPickerViewDataSource,
    UIPickerViewDelegate
>

@end

@implementation RWCustomPicker

+ (instancetype)pickerViewWithFrame:(CGRect)frame
                               type:(RWPickerType)type
                      defaultRecord:(NSDictionary *)defaultRecord
                           delegate:(id)anyObject
{
    RWCustomPicker *picker = [[RWCustomPicker alloc] initWithFrame:frame];
    
    picker.exturnDelegate = anyObject;
    
    picker.type = type;
    
    picker.record = [defaultRecord mutableCopy];
    
    return picker;
}

- (void)setRecord:(NSMutableDictionary *)record
{
    if (_record.count <= _pickerSource.count && record.count)
    {
        _record = record;
        
        for (int i = 0; i < _record.count; i++)
        {
            NSString *key = [NSString stringWithFormat:@"%d",i];
            
            NSString *setting = _record[key];
            
            if (setting)
            {
                for (int j = 0; j < [_pickerSource[i] count]; j++)
                {
                    if ([_pickerSource[i][j] isEqualToString:setting])
                    {
                        [self selectRow:j inComponent:i animated:NO];
                        [_exturnDelegate selectRow:i inComponent:j record:_record];
                        
                        break;
                    }
                }
            }
        }
    }
}

- (void)setType:(RWPickerType)type
{
    _type = type;
    
    _pickerSource = _type?[self dateSource]:[_exturnDelegate customPickerSource];
    
    if (!_record.count)
    {
        for (int i = 0; i < _pickerSource.count; i++)
        {
            NSArray *rows = _pickerSource[i];
            
            if (rows.count)
            {
                NSString *key = [NSString stringWithFormat:@"%@",@(i)];
                
                [_record setObject:[rows firstObject] forKey:key];
            }
        }
    }
    
    [self reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_type == RWPickerTypeOfDate)
    {
        return 3;
    }
    
    return _pickerSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerSource[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerSource[component][row];
}

- (NSArray *)dateSource
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    int faceYear = [dateFormatter stringFromDate:[NSDate date]].intValue;
    
    NSMutableArray *years = [[NSMutableArray alloc] init];
    
    for (int i = 1980; i < faceYear+20; i++)
    {
        [years addObject:[NSString stringWithFormat:@"%d年",i]];
    }
    
    NSMutableArray *months = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 12; i++)
    {
        [months addObject:[NSString stringWithFormat:@"%.2d月",i]];
    }
    
    NSMutableArray *days31 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 31; i++)
    {
        [days31 addObject:[NSString stringWithFormat:@"%.2d日",i]];
    }
    
    NSMutableArray *days30 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 30; i++)
    {
        [days30 addObject:[NSString stringWithFormat:@"%.2d日",i]];
    }
    
    NSMutableArray *days28 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 28; i++)
    {
        [days28 addObject:[NSString stringWithFormat:@"%.2d日",i]];
    }
    
    NSMutableArray *days29 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 29; i++)
    {
        [days29 addObject:[NSString stringWithFormat:@"%.2d日",i]];
    }
    
    return @[years,months,days31,days30,days28,days29];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_pickerSource.count == 1)
    {
        return 260;
    }
    
    return 90;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_type == RWPickerTypeOfDate)
    {
        if (component == 1)
        {
            [self reloadDataWithMonth:_pickerSource[component][row]];
        }
        else if (component == 0)
        {
            [self reloadDataWithYear:_pickerSource[component][row]];
        }
    }
    
    NSString *componentString = [NSString stringWithFormat:@"%d",(int)component];
    
    [_record setObject:_pickerSource[component][row] forKey:componentString];
    
    [_exturnDelegate selectRow:row inComponent:component record:_record];
}

- (void)reloadDataWithMonth:(NSString *)monthString
{
    NSInteger month = monthString.integerValue;
    
    NSMutableArray *copyDataSource = [_pickerSource mutableCopy];
    
    if (month == 2)
    {
        NSInteger year = [[_pickerSource[0] objectAtIndex: [self selectedRowInComponent:0]] integerValue];
        
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        {
            if ([_pickerSource[2] count] == 28)
            {
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf28];
                
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf29];
            }
            else if ([_pickerSource[2] count] == 30)
            {
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf30];
                
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf29];
            }
            else if ([_pickerSource[2] count] == 31)
            {
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf29];
            }
        }
        else
        {
            if ([_pickerSource[2] count] == 29)
            {
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf29];
                
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf28];
            }
            else if ([_pickerSource[2] count] == 30)
            {
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf30];
                
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf28];
            }
            else if ([_pickerSource[2] count] == 31)
            {
                [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                    withObjectAtIndex:RWClockDaysCountOf28];
            }
        }
    }
    else if (month == 4 || month == 6 || month == 9 || month == 11)
    {
        if ([_pickerSource[2] count] == 29)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf29];
            
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf30];
        }
        else if ([_pickerSource[2] count] == 28)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf28];
            
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf30];
        }
        else if ([_pickerSource[2] count] == 31)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf30];
        }
    }
    else
    {
        if ([_pickerSource[2] count] == 29)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf29];
        }
        else if ([_pickerSource[2] count] == 28)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf28];
        }
        else if ([_pickerSource[2] count] == 30)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf30];
        }
    }
    
    _pickerSource = copyDataSource;
    
    [self reloadComponent:RWClockDaysCountOf31];
}

- (void)reloadDataWithYear:(NSString *)yearString
{
    NSInteger month = [[_pickerSource[1] objectAtIndex:
                        [self selectedRowInComponent:1]] integerValue];
    
    if (month != 2)
    {
        return;
    }
    
    NSInteger year = yearString.integerValue;
    
    NSMutableArray *copyDataSource = [_pickerSource mutableCopy];
    
    if ((year % 4 == 0 && year % 100 != 0)||year % 400 == 0)
    {
        if ([_pickerSource[2] count] == 28)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf28];
            
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf29];
        }
        else if ([_pickerSource[2] count] == 30)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf30];
            
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf29];
        }
        else if ([_pickerSource[2] count] == 31)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf29];
        }
    }
    else
    {
        if ([_pickerSource[2] count] == 29)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf29];
            
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf28];
        }
        else if ([_pickerSource[2] count] == 30)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf30];
            
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf28];
        }
        else if ([_pickerSource[2] count] == 31)
        {
            [copyDataSource exchangeObjectAtIndex:RWClockDaysCountOf31
                                withObjectAtIndex:RWClockDaysCountOf28];
        }
    }
    
    _pickerSource = copyDataSource;
    
    [self reloadComponent:RWClockDaysCountOf31];
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _record = [[NSMutableDictionary alloc]init];
        
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

@end

