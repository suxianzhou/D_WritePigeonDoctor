//
//  AppDelegate+JPush.m
//  ZhongYuSubjectHubKY
//
//  Created by zhongyu on 16/5/21.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "RWRequsetManager.h"
#import "XZSettingWebViewController.h"

@implementation AppDelegate (JPush)

- (void)initJPushWithLaunchOptions:(NSDictionary *) launchOptions
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        [JPUSHService registerForRemoteNotificationTypes:UIUserNotificationTypeAlert|
                                                         UIUserNotificationTypeBadge|
                                                         UIUserNotificationTypeSound
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPUSH_KEY
                          channel:@"App Store"
                 apsForProduction:0];
}

- (void)examinePushInformation
{
    if ([UIApplication sharedApplication].applicationIconBadgeNumber == 0)
    {
        return;
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UIViewController *viewController = [self getPresentedViewController];
    
    [self toPushViewControllerFromViewController:viewController];
}

- (void)toPushViewControllerFromViewController:(__kindof UIViewController *)viewController
{
    __block XZSettingWebViewController *webView = [[XZSettingWebViewController alloc] init];
    
    viewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:webView animated:YES];
    viewController.hidesBottomBarWhenPushed = NO;
    [[[RWRequsetManager alloc] init] receivePushMessageOfHTML:^(NSString *html, NSError *error)
    {
        if (error)
        {
             DISSMISS;
            [RWRequsetManager warningToViewController:viewController
                                                Title:@"网络连接失败，请检查网络"
                                                Click:^{
                                                    
                [viewController.navigationController popViewControllerAnimated:YES];
                
            }];
            
            return;
        }
        
        webView.url = html;
    }];
}

- (__kindof UIViewController *)getPresentedViewController
{
    RWMainTabBarController * rootTabBar =
                            (RWMainTabBarController *)self.window.rootViewController;
    
    UIViewController *topViewController;
    
    
    if (rootTabBar.presentedViewController)
    {
        UINavigationController *registerView =
                        (UINavigationController *)rootTabBar.presentedViewController;
        
        topViewController = [registerView.viewControllers lastObject];
    }
    else
    {
        UINavigationController *mianView =
                                rootTabBar.viewControllers[rootTabBar.selectedIndex];
        
        topViewController = [mianView.viewControllers lastObject];
    }
    
    return topViewController;
}

- (void)openFromAlrteClickWithNotification:(NSNotification *)notification
{
//   NSString *body = notification.alertBody
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    MESSAGE(@"error -- %@",error);
    MESSAGE(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


@end
