//
//  FEUser.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/17.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEUser.h"

@implementation FEUser

static FEUser * _instance;


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(FEUser*)shareDataModle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

@end
