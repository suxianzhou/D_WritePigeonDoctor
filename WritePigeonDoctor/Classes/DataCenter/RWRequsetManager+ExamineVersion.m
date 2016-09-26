//
//  RWRequsetManager+ExamineVersion.m
//  ZhongYuSubjectHubKY
//
//  Created by zhongyu on 16/8/2.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWRequsetManager+ExamineVersion.h"
#import <AFNetworking.h>

#ifndef APP_ID
#define APP_ID @"1154007267"
#endif

#ifndef APP_STORE_URL
#define APP_STORE_URL @"http://itunes.apple.com/cn/lookup?id="APP_ID
#endif

#ifndef TO_APP_STORE
#define TO_APP_STORE @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="APP_ID
#endif

@implementation RWRequsetManager (ExamineVersion)

+ (void)examineVersionWithController:(__kindof UIViewController *)viewController
{
    if (!__NET_STATUS__)
    {
        return;
    }
    
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requestManager POST:APP_STORE_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([Json[@"resultCount"] integerValue] > 0)
        {
            float AppStoreVersion = [Json[@"results"][0][@"version"] floatValue];
            
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
            float localVersion = [version floatValue];
            
            if (localVersion < AppStoreVersion)
            {
                [viewController presentViewController:[RWRequsetManager updateVersion]
                                             animated:YES
                                           completion:nil];
            }
        }
    } failure:nil];
}

+ (UIAlertController *)updateVersion
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新提醒" message:@"检测到有新的版本更新" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *update = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TO_APP_STORE]];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后更新"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alert addAction:update];
    [alert addAction:cancel];
    
    return alert;
}

@end
