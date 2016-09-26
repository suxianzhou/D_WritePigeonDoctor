//
//  RWRequsetManager+DoctorMethot.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/20.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWRequsetManager+DoctorMethot.h"

@implementation RWRequsetManager (DoctorMethot)

- (void)online:(void(^)(BOOL isOnline))online
{
    [self.requestManager POST:@"" parameters:@"" progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[RWChatManager defaultManager] openKeepOnline];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (online) online(NO);
    }];
}

- (void)offline:(void(^)(BOOL isOffline))offline
{
    [self.requestManager POST:@"" parameters:@"" progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[RWChatManager defaultManager] closeKeepOnline];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (offline) offline(NO);
    }];
}

- (void)getUserInformationWithUsername:(NSString *)username
{
    
}

- (void)getVisitInfomationWithDoctorID:(NSString *)doctorID
{
    
}

- (void)updateVisitInfomationWithVisit:(RWWeekHomeVisit *)visit
{
    [self.requestManager POST:@"" parameters:@"" progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)cancelOrderWithOrder:(RWOrder *)order
{
    
}

@end
