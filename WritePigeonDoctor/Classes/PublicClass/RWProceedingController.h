//
//  RWProceedingController.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/3.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWProceedingController : UINavigationController

+ (instancetype)proceedingWithOrder:(RWOrder *)order;

@property (nonatomic,strong)RWOrder *order;

- (void)returnMainView;

@end
