//
//  RWCustomPicker.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,RWPickerType);
@class RWAlertPicker,RWCustomPicker;

typedef NS_ENUM(NSInteger,RWPickerResponse)
{
    RWPickerResponseCertain,
    RWPickerResponseCancel
};

@protocol RWAlertPickerDataSource <NSObject>
@required

- (RWPickerType)pickerTypeAtAlertPicke:(RWAlertPicker *)alertPicker;
- (NSDictionary *)pickerRecordAtAlertPicke:(RWAlertPicker *)alertPicker;

@optional
- (NSArray<NSArray *>*)pickerSourceAtAlertPicke:(RWAlertPicker *)alertPicker;
- (NSString *)headerTitleAtAlertPicke:(RWAlertPicker *)alertPicker;


@end

@protocol RWAlertPickerDelegate <NSObject>

@optional

- (void)alertPicker:(RWAlertPicker *)alertPicker
          selectRow:(NSInteger)row
        inComponent:(NSInteger)component
             record:(NSDictionary *)record;

- (void)alertPicker:(RWAlertPicker *)alertPicker
       responseType:(RWPickerResponse)responseType;

@end

@interface RWAlertPicker : UIView

+ (instancetype)alertPickerWithDataSource:(id<RWAlertPickerDataSource>)dataSource
                                 delegate:(id<RWAlertPickerDelegate>)delegate;

@property (nonatomic,assign)id<RWAlertPickerDataSource> dataSource;
@property (nonatomic,assign)id<RWAlertPickerDelegate> delegate;

@property (nonatomic,strong,readonly)RWCustomPicker *pickerView;

+ (NSDictionary *)dateContextWithString:(NSString *)string;
+ (NSString *)dateStringWithContext:(NSDictionary *)context;
+ (NSDate *)pickerDateWithString:(NSString *)pickerString;

@end

typedef NS_ENUM(NSInteger ,RWPickerType)
{
    RWPickerTypeOfCustom,
    RWPickerTypeOfDate
};

@protocol RWCustomPickerDelegate <NSObject>
@required

- (void)selectRow:(NSInteger)row
      inComponent:(NSInteger)component
           record:(NSDictionary *)record;

@optional
- (NSArray<NSArray *>*)customPickerSource;

@end

@interface RWCustomPicker : UIPickerView

+ (instancetype)pickerViewWithFrame:(CGRect)frame
                               type:(RWPickerType)type
                      defaultRecord:(NSDictionary *)defaultRecord
                           delegate:(id)anyObject;

@property (nonatomic,assign)id<RWCustomPickerDelegate> exturnDelegate;

@property (nonatomic,assign)RWPickerType type;

@property (nonatomic,strong)NSArray *pickerSource;

@property (nonatomic,strong)NSMutableDictionary *record;

@end
