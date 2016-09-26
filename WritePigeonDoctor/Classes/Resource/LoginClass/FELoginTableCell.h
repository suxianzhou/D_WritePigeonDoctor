//
//  FELoginTableCells.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/7/28.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YYKit.h"

@class FETextFiledCell;

@protocol FETextFiledCellDelegate <NSObject>

- (void)textFiledCell:(FETextFiledCell *)cell DidBeginEditing:(NSString *)placeholder;

@end


@interface FETextFiledCell : UITableViewCell

@property(nonatomic,assign) id<FETextFiledCellDelegate>delegate;

@property(nonatomic,strong)UIView * bankgroundView;

@property(nonatomic,strong)UITextField * textField;

@property(nonatomic,copy)NSString * placeholder;

@end


@protocol FEButtonCellDelegate <NSObject>

- (void)button:(UIButton *)button ClickWithTitle:(NSString *)title;

@end



@interface FEButtonCell : UITableViewCell

@property (assign ,nonatomic)id<FEButtonCellDelegate> delegate;

@property (nonatomic ,strong)NSString *title;

@property (nonatomic,strong)UIButton *button;

@end


@class FEChecButtonCell;
@protocol FEChecButtonCellDelegate <NSObject>

- (void)button:(UIButton *)button FEChecClickWithTitle:(NSString *)title;

- (void)FEChectextFiledCell:(FEChecButtonCell *)cell DidBeginEditing:(NSString *)placeholder;
@end
@interface FEChecButtonCell : UITableViewCell

@property(nonatomic,assign)id<FEChecButtonCellDelegate>delegate;

@property(nonatomic,strong)UIView * bankgroundView;

@property(nonatomic,strong)UITextField * textField;

@property(nonatomic,copy)NSString * placeholder;

@property(nonatomic,strong)UIButton *button;

@property (nonatomic ,strong)NSString *title;
@end




@protocol FEAgreementCellDelegate <NSObject>

- (void)button:(UIButton *)button ClickWithImage:(UIImage *)image;

-(void)Agreement;
@end


@interface FEAgreementCell : UITableViewCell

@property(nonatomic,assign)id<FEAgreementCellDelegate>delegate;

@property(nonatomic,strong)UIButton * agreementButton;

@property(nonatomic,strong)UIView * bankgroundView;

@property(nonatomic,strong)NSString * agreementString;

@property(nonatomic,strong)UIImage * bankgroundImage;

@property(nonatomic,strong)YYLabel *bordLabel;

@end

@protocol FETextViewCellDelegate <NSObject>

-(void)placeholderLabel:(UILabel *)label andTextView:(UITextView *)textView;

@end



@interface FETextViewCell : UITableViewCell

@property(nonatomic,assign)id<FETextViewCellDelegate>delegate;

@property(nonatomic,strong)UIView * bankgroundView;

@property(nonatomic,strong)UITextView * writeText;

@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@protocol FEImageCellDelegate <NSObject>

-(void)alterHeadPortrait:(UIImageView *)imageView;
-(void)exampleWithImage:(UIImageView *)imageView;
@end


@interface FEImageCell : UITableViewCell

@property(nonatomic,strong)id <FEImageCellDelegate>delegate;

@property(nonatomic,strong)UIView * backgroundView;

@property(nonatomic,strong)UILabel * tileLabel;

@property(nonatomic,strong)UILabel * subheadLabel;

@property(nonatomic,strong)UIImageView * proveImageView;

@property(nonatomic,strong)UIImageView * exampleImageView;

@end


@interface FEUserInfoCell : UITableViewCell

@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)UIView * backGroundView;

@property(nonatomic,strong)UIScrollView * userScrollView;

@property(nonatomic,strong)UILabel * userLabel;

@end
