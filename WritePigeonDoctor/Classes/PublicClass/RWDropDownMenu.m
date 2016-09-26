//
//  RWDropDownMenu.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/2.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWDropDownMenu.h"
#import "RWWeiChatView.h"

@interface RWExtensionAutoLayoutCell : UITableViewCell @end

@interface RWDropDownMenu ()

<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic,strong)UITableView *menu;

@property (nonatomic,strong)UIImageView *arrowhead;

@end

@implementation RWDropDownMenu

+ (instancetype)dropDownMenuWithFrame:(CGRect)frame functions:(NSArray *)functions
{
    RWDropDownMenu *dropDownMenu = [[RWDropDownMenu alloc] initWithFrame:frame];
    
    dropDownMenu.functions = functions;
    
    return dropDownMenu;
}

+ (instancetype)dropDownMenuWithAutoLayout:(void(^)(MASConstraintMaker *make))autoLayout functions:(NSArray *)functions
{
    RWDropDownMenu *dropDownMenu = [[RWDropDownMenu alloc] init];
    
    dropDownMenu.autoLayout = autoLayout;
    dropDownMenu.functions = functions;
    
    return dropDownMenu;
}

- (void)initViews
{
    _arrowhead = [[UIImageView alloc] init];
    [self addSubview:_arrowhead];
    _arrowhead.image = [UIImage imageNamed:@"TopCa"];
    
    _menu = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                         style:UITableViewStylePlain];
    [self addSubview:_menu];
    
    _menu.backgroundColor = [UIColor whiteColor];
    
    _menu.showsVerticalScrollIndicator = NO;
    _menu.showsHorizontalScrollIndicator = NO;
    _menu.bounces = NO;
    _menu.scrollEnabled = NO;
    
    _menu.delegate = self;
    _menu.dataSource = self;
    
    [_menu registerClass:[RWExtensionAutoLayoutCell class]
  forCellReuseIdentifier:NSStringFromClass([RWExtensionAutoLayoutCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _functions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWExtensionAutoLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RWExtensionAutoLayoutCell class]) forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RWMenuItem *item = _functions[indexPath.row];
    
    cell.imageView.image = item.image;
    cell.textLabel.text = item.title;
    cell.textLabel.font = __RWGET_SYSFONT(12);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *close = [[UIButton alloc] init];
    
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    close.titleLabel.font = __RWGET_SYSFONT(12);
    
    [close addTarget:self
              action:@selector(removeFromSuperview)
    forControlEvents:UIControlEventTouchUpInside];
    
    return close;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeFromSuperview];
    
    if (found_response(_delegate,@"dropDownMenu:didSelectItem:atIndexPath:"))
    {
        [_delegate dropDownMenu:self
                  didSelectItem:_functions[indexPath.row]
                    atIndexPath:indexPath];
    }
}

- (void)autoLayoutViews
{
    [_arrowhead mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@(10));
        make.height.equalTo(@(10));
        make.left.equalTo(self.mas_left).offset(_arrowheadOffset);
        make.top.equalTo(self.mas_top).offset(0);
    }];
    
    [_menu mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(_arrowhead.mas_bottom).offset(-1);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        if (!_menu)
        {
            self.backgroundColor = [UIColor clearColor];
            self.layer.shadowColor = [[UIColor grayColor] CGColor];
            self.layer.shadowOpacity = 0.3f;
            self.layer.shadowRadius = 8.f;
            self.layer.shadowOffset = CGSizeMake(0, -2);
            
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
        if (!_menu)
        {
            self.backgroundColor = [UIColor clearColor];
            self.layer.shadowColor = [[UIColor grayColor] CGColor];
            self.layer.shadowOpacity = 0.3f;
            self.layer.shadowRadius = 8.f;
            self.layer.shadowOffset = CGSizeMake(0, -2);
            
            [self initViews];
            [self setViewsFrame:frame];
        }
    }
    
    return self;
}

- (void)setViewsFrame:(CGRect)frame
{
    _arrowhead.frame = CGRectMake(_arrowheadOffset, 0, 10, 10);
    _menu.frame = CGRectMake(0, 9, frame.size.width, frame.size.height - 9);
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    if (found_response(_delegate,@"dropDownMenu:didSelectItem:atIndexPath:"))
    {
        [_delegate dropDownMenu:self didSelectItem:nil atIndexPath:nil];
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (_functions.count)
    {
        if (_autoLayout)
        {
            [self mas_remakeConstraints:_autoLayout];
            [self mas_updateConstraints:^(MASConstraintMaker *make)
            {
                make.height.equalTo(@(30 * _functions.count + 9 + 30));
            }];
            
            [self autoLayoutViews];
        }
        else
        {
            CGRect frame = self.frame;
            
            frame.size.height = 30 * _functions.count + 9 + 30;
            
            self.frame = frame;
            [self setViewsFrame:frame];
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _menu.backgroundColor = backgroundColor;
    _arrowhead.image = [_arrowhead.image imageWithColor:backgroundColor];
}

- (void)setArrowheadOffset:(CGFloat)arrowheadOffset
{
    _arrowheadOffset = arrowheadOffset;
    
    if (_autoLayout)
    {
        [_arrowhead mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(_arrowheadOffset);
        }];
    }
    else
    {
        CGRect frame = _arrowhead.frame;
        
        frame.origin.x += _arrowheadOffset;
        
        _arrowhead.frame = frame;
    }
}

- (void)setFunctions:(NSArray *)functions
{
    _functions = functions;
    
    if (self.window)
    {
        [_menu reloadData];
    }
}

- (void)setAutoLayout:(void (^)(MASConstraintMaker *))autoLayout
{
    _autoLayout = autoLayout;
    
    if (_functions.count)
    {
        if (_autoLayout)
        {
            [self mas_makeConstraints:_autoLayout];
            [self mas_updateConstraints:^(MASConstraintMaker *make)
             {
                 make.height.equalTo(@(30 * _functions.count + 10));
             }];
            
            [self autoLayoutViews];
        }
    }
}

@end

@implementation RWMenuItem

+ (NSArray *)hasOrderItems
{
    return @[[RWMenuItem itemWithImage:[UIImage imageNamed:@"订单"]
                                 title:@"当前订单"
                              function:RWFunctionOfFaceOrder],
             [RWMenuItem itemWithImage:[UIImage imageNamed:@"取消订单"]
                                 title:@"取消订单"
                              function:RWFunctionOfCancelOrder]];
}

+ (NSArray *)notHasOrderItems
{
    return @[[RWMenuItem itemWithImage:[UIImage imageNamed:@"创建 "]
                                 title:@"付款协议"
                              function:RWFunctionOfCustom]];
}

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title function:(RWFunction)function
{
    RWMenuItem *item = [[RWMenuItem alloc] init];
    
    item.image = image;
    item.title = title;
    item.function = function;
    
    return item;
}

@end

@implementation RWExtensionAutoLayoutCell

- (UIImageView *)imageView
{
    UIImageView *imageView = [self.contentView viewWithTag:201609042355];
    
    if (!imageView)
    {
        imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        imageView.tag = 201609042355;
    }
    
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5.f);
    }];
    
    return imageView;
}

- (UILabel *)textLabel
{
    UILabel *textLabel = [self.contentView viewWithTag:201609042354];
    
    if (!textLabel)
    {
        textLabel = [[UILabel alloc] init];
        [self.contentView addSubview:textLabel];
        textLabel.tag = 201609042354;
    }
    
    [textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(5.f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.f);
        make.left.equalTo(self.contentView.mas_left).offset(35.f);
        make.right.equalTo(self.contentView.mas_right).offset(-5.f);
    }];
    
    return textLabel;
}

@end
