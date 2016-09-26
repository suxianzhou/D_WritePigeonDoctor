//
//  RWDataModels.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/7/27.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RWWeekHomeVisit,RWHomeVisitItem;

@interface RWOfficeItem : NSObject

@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *doctorList;

@end

@interface RWUserItem : NSObject

@property (nonatomic,strong,readonly)NSString *header;
@property (nonatomic,strong,readonly)NSString *nickName;
@property (nonatomic,strong)NSString *EMID;
@property (nonatomic,strong)NSString *UMID;
@property (nonatomic,assign)BOOL relation;

@end
 
#define __WEEK_KEYVALUE__     @{@"Monday":@"周一",\
                                @"Tuesday":@"周二",\
                                @"Wednesday":@"周三",\
                                @"Thursday":@"周四",\
                                @"Friday":@"周五",\
                                @"Saturday":@"周六",\
                                @"Sunday":@"周日",\
                                @"周一":@"Monday",\
                                @"周二":@"Tuesday",\
                                @"周三":@"Wednesday",\
                                @"周四":@"Thursday",\
                                @"周五":@"Friday",\
                                @"周六":@"Saturday",\
                                @"周日":@"Sunday"}

#define SWITCH_WEEK(week) [__WEEK_KEYVALUE__ objectForKey:week]

#define __WEEK__ @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]


#define __TIME_SECTION_KEYVALUE__ @{@"morning":@"上午",\
                                    @"afternoon":@"中午",\
                                    @"night":@"下午",\
                                    @"上午":@"morning",\
                                    @"中午":@"afternoon",\
                                    @"下午":@"night"}

#define SWITCH_TIME_SECTION(tisec) [__TIME_SECTION_KEYVALUE__ objectForKey:tisec]

#define __TIME_SECTION__ @[@"上午",@"中午",@"下午"]

@interface RWWeekHomeVisit : NSObject

+ (instancetype)visitWithDescription:(NSString *)description;
- (instancetype)initWithDescription:(NSString *)description;

+ (instancetype)visitWithDictionary:(NSDictionary *)aDictionary;
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@property (nonatomic,strong)RWHomeVisitItem *Monday;
@property (nonatomic,strong)RWHomeVisitItem *Tuesday;
@property (nonatomic,strong)RWHomeVisitItem *Wednesday;
@property (nonatomic,strong)RWHomeVisitItem *Thursday;
@property (nonatomic,strong)RWHomeVisitItem *Friday;
@property (nonatomic,strong)RWHomeVisitItem *Saturday;
@property (nonatomic,strong)RWHomeVisitItem *Sunday;

@end

@interface RWHomeVisitItem : NSObject

+ (instancetype)itemWithDescription:(NSString *)description;
- (instancetype)initWithDescription:(NSString *)description;

+ (instancetype)itemWithDictionary:(NSDictionary *)aDictionary;
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@property (nonatomic,strong)NSString *morning;
@property (nonatomic,strong)NSString *afternoon;
@property (nonatomic,strong)NSString *night;

@end


