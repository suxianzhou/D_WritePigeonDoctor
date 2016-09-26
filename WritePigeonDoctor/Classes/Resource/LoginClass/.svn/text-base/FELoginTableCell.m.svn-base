//
//  FELoginTableCells.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/7/28.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "FELoginTableCell.h"
#import "Masonry.h"

#define __WPD_MAIN_COLOR__ [UIColor colorWithRed:43.f/255.f green:141.f/255.f blue:241.f/255.f alpha:1.0]
@interface FETextFiledCell ()<UITextFieldDelegate>
@end

@implementation FETextFiledCell
@synthesize bankgroundView;
@synthesize textField;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
}
-(void)initUI{
    
    bankgroundView=[[UIView alloc]init];
    
    [self addSubview:bankgroundView];
    
    textField=[[UITextField alloc]init];
    

    textField.backgroundColor=[UIColor clearColor];
    
    textField.textColor = [UIColor blackColor];
    
    textField.textAlignment=NSTextAlignmentCenter;

    textField.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    textField.delegate = self;
    bankgroundView.backgroundColor=[UIColor whiteColor];
    
    bankgroundView.layer.cornerRadius=10;
    
    [bankgroundView addSubview:textField];
    
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    __weak typeof(self) weakSelf = self;
    [bankgroundView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(weakSelf).offset(5);
        make.bottom.equalTo(weakSelf).offset(-5);
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(bankgroundView).offset(3);
        make.bottom.equalTo(bankgroundView).offset(-3);
        make.left.equalTo(bankgroundView).offset(10);
        make.right.equalTo(bankgroundView).offset(-10);
    }];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.delegate textFiledCell:self DidBeginEditing:_placeholder];
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    textField.placeholder = _placeholder;
}
@end





/****************************************************************/





@implementation FEButtonCell

@synthesize button;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        button = [[UIButton alloc]init];
        
        button.backgroundColor = __WPD_MAIN_COLOR__;
        
        button.layer.cornerRadius = 10;
        
        button.clipsToBounds = YES;
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:button];
        
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)btnClick
{
    [self.delegate button:button ClickWithTitle:_title];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [button setTitle:_title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    
}

@end




/****************************************************************/





@interface FEChecButtonCell ()<UITextFieldDelegate>

@end

@implementation FEChecButtonCell

@synthesize bankgroundView;

@synthesize textField;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
}
-(void)initUI{
    
    bankgroundView=[[UIView alloc]init];
    
    [self addSubview:bankgroundView];
    
    textField=[[UITextField alloc]init];
    
    textField.backgroundColor=[UIColor clearColor];
    
    textField.textColor = [UIColor blackColor];
    
    textField.textAlignment=NSTextAlignmentCenter;
    
    textField.font = [UIFont systemFontOfSize:12];
    
    textField.delegate = self;
    bankgroundView.backgroundColor=[UIColor whiteColor];
    bankgroundView.layer.cornerRadius=6;
    [bankgroundView addSubview:textField];
    
    _button=[[UIButton alloc]init];
    
    _button.backgroundColor=__WPD_MAIN_COLOR__;
    _button.layer.cornerRadius = 8;
    
    _button.clipsToBounds = YES;
    
    _button.titleLabel.font = [UIFont systemFontOfSize:10];
    
    
    [_button addTarget:self action:@selector(FEbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:_button];
    
   }

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.delegate FEChectextFiledCell:self DidBeginEditing:_placeholder];
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    textField.placeholder = _placeholder;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [_button setTitle:_title forState:UIControlStateNormal];
}

- (void)FEbtnClick
{
     [self.delegate button:_button FEChecClickWithTitle:_title];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    __weak typeof(self) weakSelf = self;
    [bankgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(8);
        make.bottom.equalTo(weakSelf).offset(-8);
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-self.frame.size.width/3-20);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankgroundView).offset(2);
        make.bottom.equalTo(bankgroundView).offset(-2);
        make.left.equalTo(bankgroundView).offset(10);
        make.right.equalTo(bankgroundView);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankgroundView);
        make.bottom.equalTo(bankgroundView);
        make.left.equalTo(textField.mas_right).offset(10);
        make.right.equalTo(weakSelf).offset(-25);
        
    }];
}
@end



/****************************************************************/




@interface FEAgreementCell ()
{
    NSString * firstString;
    
    NSString * secondString;
    UIButton * button;
}
@end

@implementation FEAgreementCell
@synthesize bankgroundView;
@synthesize agreementButton;
@synthesize bordLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
}
-(void)initUI
{
    bankgroundView=[[UIView alloc]init];
    
    [self addSubview:bankgroundView];
    
    agreementButton=[[UIButton alloc]init];
    [agreementButton setImage:[UIImage imageNamed:@"duihao"] forState:(UIControlStateNormal)];
    [agreementButton addTarget:self action:@selector(FEbuttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bankgroundView addSubview:agreementButton];
    
   
    bordLabel=[[YYLabel alloc]init];
    [bankgroundView addSubview:bordLabel];
    button=[[UIButton alloc]initWithFrame:bordLabel.frame];
    [button addTarget:self action:@selector(buttonwithAgreement) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bankgroundView addSubview:button];
}

-(void)setAgreementString:(NSString *)string{
    
    _agreementString=string;
}

- (void)setBankgroundImage:(UIImage *)image
{
    _bankgroundImage = image;
    
    [agreementButton setImage:_bankgroundImage forState:UIControlStateNormal];
}

-(void)FEbuttonClick{
    [self.delegate button:agreementButton ClickWithImage:_bankgroundImage];
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    __weak typeof(self) weakSelf = self;
    [bankgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(5);
        make.bottom.equalTo(weakSelf).offset(-2);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf);
    }];
    
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(bankgroundView).offset(10);
        make.centerY.equalTo(bankgroundView);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [bordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankgroundView);
        make.bottom.equalTo(bankgroundView);
        make.left.equalTo(agreementButton.mas_right).offset(10);
        make.right.equalTo(bankgroundView);
        
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bordLabel);
        make.size.equalTo(bordLabel);
    }];
    
}
-(void)buttonwithAgreement{
    [self.delegate Agreement];
}
@end

//*************************************

@interface FETextViewCell ()<UITextViewDelegate>

@end

@implementation FETextViewCell

@synthesize bankgroundView;
@synthesize writeText;
@synthesize placeholderLabel;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
}

-(void)initUI
{
    bankgroundView=[[UIView alloc]init];
    
    bankgroundView.backgroundColor=[UIColor whiteColor];
    
     bankgroundView.layer.cornerRadius=10;
    
    [self addSubview:bankgroundView];

    writeText=[[UITextView alloc]init];
    
    writeText.textAlignment=NSTextAlignmentLeft;
    
    writeText.textColor=[UIColor blackColor];
    
    writeText.delegate=self;
    
    writeText.backgroundColor=[UIColor clearColor];
    
    writeText.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    
    [bankgroundView addSubview:writeText];
    
    placeholderLabel=[[UILabel alloc]init];
    
    placeholderLabel.enabled=NO;
    
    placeholderLabel.font = [UIFont systemFontOfSize:15];
    
    placeholderLabel.textColor=[UIColor lightGrayColor];
    
    [writeText addSubview:placeholderLabel];
    
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    __weak typeof(self) weakSelf = self;
    [bankgroundView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(weakSelf).offset(5);
         make.bottom.equalTo(weakSelf).offset(-5);
         make.left.equalTo(weakSelf).offset(20);
         make.right.equalTo(weakSelf).offset(-20);
     }];
    
    [writeText mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(bankgroundView).offset(3);
         make.bottom.equalTo(bankgroundView).offset(-3);
         make.left.equalTo(bankgroundView).offset(10);
         make.right.equalTo(bankgroundView).offset(-10);
     }];
    
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(writeText);
        make.centerX.equalTo(writeText);
        make.top.equalTo(writeText);
        make.height.equalTo(@(20));
    }];
    
}

- (void) textViewDidChange:(UITextView *)textView
{
    [self.delegate placeholderLabel:placeholderLabel andTextView:textView];
}
@end

/**************************************************************/

@implementation FEImageCell

@synthesize backgroundView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
}

-(void)initUI
{
     backgroundView=[[UIView alloc]init];
    
     backgroundView.backgroundColor=[UIColor clearColor];
    
    [self addSubview:backgroundView];
    
    _tileLabel=[[UILabel alloc]init];
    
    _tileLabel.textColor=[UIColor blackColor];
    
    _tileLabel.font = [UIFont systemFontOfSize:13];
    
    [backgroundView addSubview:_tileLabel];
    
    _subheadLabel=[[UILabel alloc]init];

    _subheadLabel.textColor=[UIColor lightGrayColor];
    
    _subheadLabel.font=[UIFont systemFontOfSize:11];

    [backgroundView addSubview:_subheadLabel];
    
    _proveImageView=[[UIImageView alloc]init];
    
    _proveImageView.userInteractionEnabled=YES;
    
    _proveImageView.image=[UIImage imageNamed:@"zxj"];
    
    _proveImageView.backgroundColor=[UIColor clearColor];
    
    [backgroundView addSubview:_proveImageView];
    
    _exampleImageView=[[UIImageView alloc]init];
    
    _exampleImageView.userInteractionEnabled=YES;
    
    _exampleImageView.backgroundColor=[UIColor clearColor];
    
    [backgroundView addSubview:_exampleImageView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alterHeadPortrait:)];
    singleTap.numberOfTapsRequired = 1;
    
    [_proveImageView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *exampleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exampleWithImage:)];
    exampleTap.numberOfTapsRequired = 1;
    
    [_exampleImageView addGestureRecognizer:exampleTap];
    
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.mas_top).offset(5);
         make.bottom.equalTo(self.mas_bottom).offset(-5);
         make.left.equalTo(self.mas_left).offset(3);
         make.right.equalTo(self.mas_right).offset(-3);
     }];
    [_tileLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(backgroundView.mas_top);
        make.left.equalTo(backgroundView.mas_left);
        make.right.equalTo(backgroundView.mas_right);
        make.height.equalTo(@(20));
        
    }];
    [_subheadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tileLabel.mas_bottom);
        make.left.equalTo(_tileLabel.mas_left);
        make.right.equalTo(_tileLabel.mas_right);
        make.height.equalTo(@(15));
    }];
    [_proveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subheadLabel.mas_bottom).offset(1);
        make.left.equalTo(_subheadLabel.mas_left);
        make.width.equalTo(@(self.frame.size.height*3.5/5));
        make.height.equalTo(@(self.frame.size.height*3.5/5));
    }];
    [_exampleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subheadLabel.mas_bottom).offset(1);
        make.right.equalTo(_subheadLabel.mas_right);
        make.width.equalTo(@(self.frame.size.height*3.5/5));
        make.height.equalTo(@(self.frame.size.height*3.5/5));
    }];
    
}
-(void)alterHeadPortrait:(UIImageView *)imageView
{
    [self.delegate alterHeadPortrait:_proveImageView];
}

-(void)exampleWithImage:(UIImageView *)imageView
{
    [self.delegate exampleWithImage:_exampleImageView];
}
@end

@implementation FEUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
        
    }
    
    return self;
}

-(void)initUI
{
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,5, self.frame.size.width/4, 30)];
    
    self.titleLabel.backgroundColor=[UIColor clearColor];
    
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    
    [self addSubview:self.titleLabel];
    
    self.userScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.frame.size.width/4+20,8, self.frame.size.width, 120)];
    self.userScrollView.contentSize = CGSizeMake(0, 0);
    [self addSubview:self.userScrollView];
    self.userScrollView.backgroundColor = [UIColor clearColor];
    [self.userScrollView setShowsVerticalScrollIndicator:NO];//关闭ScrollView的上下滚动条
    
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,5, self.frame.size.width*3/4-20, 105)];
    self.userLabel.numberOfLines = 0;//行数设为0，就会自动改变行数。
    self.userLabel.lineBreakMode = NSLineBreakByWordWrapping;//截断
    self.userLabel.font = [UIFont systemFontOfSize:16];
    self.userLabel.backgroundColor = [UIColor clearColor];
    [self.userScrollView addSubview:self.userLabel];
    

}
@end
