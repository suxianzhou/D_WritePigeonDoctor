//
//  RWDropDownMenu.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/2.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWMenuItem,RWDropDownMenu;

@protocol RWDropDownMenuDelegate <NSObject>
@optional

- (void)dropDownMenu:(RWDropDownMenu *)dropDownMenu
       didSelectItem:(RWMenuItem *)item
         atIndexPath:(NSIndexPath *)indexPath;

@end

@interface RWDropDownMenu : UIView

+ (instancetype)dropDownMenuWithFrame:(CGRect)frame
                            functions:(NSArray *)functions;

+ (instancetype)dropDownMenuWithAutoLayout:(void(^)(MASConstraintMaker *make))autoLayout
                                 functions:(NSArray *)functions;

@property (nonatomic,assign)id<RWDropDownMenuDelegate> delegate;

@property (nonatomic,strong)NSArray *functions;

@property (nonatomic,copy)void(^autoLayout)(MASConstraintMaker *make);

@property (nonatomic,assign)CGFloat arrowheadOffset;

@end

typedef NS_ENUM(NSInteger,RWFunction)
{
    RWFunctionOfBuildOrder = 1,
    RWFunctionOfCancelOrder,
    RWFunctionOfFaceOrder,
    RWFunctionOfCustom
};

@interface RWMenuItem : NSObject

+ (NSArray *)hasOrderItems;
+ (NSArray *)notHasOrderItems;

+ (instancetype)itemWithImage:(UIImage *)image
                        title:(NSString *)title
                     function:(RWFunction)function;

@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)RWFunction function;

@property (nonatomic,copy)NSString *customIdentifier;

@end
