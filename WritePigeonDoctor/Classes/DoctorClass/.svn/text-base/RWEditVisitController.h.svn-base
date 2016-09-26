//
//  RWEditVisitController.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/9.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RWVisit;

@interface RWEditVisitController : UIViewController

+ (instancetype)visitWithSave:(void(^)(RWVisit *visit))save;

@property (nonatomic,strong)RWVisit *visit;

@property (nonatomic,assign)BOOL revise;

@end

@interface RWVisit : NSObject

- (NSString *)mergeInformation;

@property (nonatomic,assign)BOOL isDelete;

@property (nonatomic,copy)NSString *week;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *start;
@property (nonatomic,copy)NSString *end;
@property (nonatomic,copy)NSString *address;

@end