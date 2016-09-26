//
//  AppDelegate.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/7/11.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "AppDelegate.h"
#import "RWMainTabBarController.h"
#import "UMComSession.h"
#import "UMCommunity.h"
#import "EMSDK.h"
#import "UMSocial.h"
#import "UMSocialSnsService.h"
#import "WXApi.h"
#import "FEShareView.h"
#import "AppDelegate+JPush.h"
#import <UMMobClick/MobClick.h>
#define UmengAppkey @"57cd2533e0f55a90aa000cf0"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self setKeysSettings];
    [self setSystemSettingsWithApplication:application];
    [self setWindowSettings];
    [self initJPushWithLaunchOptions:launchOptions];
    [self examinePushInformation];
    [self setUMSocial];
    return YES;
}

//分享
-(void)setUMSocial
{
    [UMSocialData setAppKey:UmengAppkey];
    
    [UMSocialData openLog:YES];
    
    [UMSocialWechatHandler setWXAppId:@"wx3b4c0f3be08becc9" appSecret:@"578b015fe0f55a6b7100453b" url:@"http://www.baidu.com/"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1372522274"
                                              secret:@"49211451ec61f4f0757180aed887cfbb"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105532245" appKey:@"xgyo9yI8aV5DBaJg" url:@"http://www.baidu.com"];
    
    [UMSocialQQHandler setSupportWebView:YES];
}

- (void)setKeysSettings
{
    [UMSocialData setAppKey:UmengAppkey];
    [UMSocialData openLog:YES];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    EMOptions *options = [EMOptions optionsWithAppkey:__EMSDK_KEY__];
    options.apnsCertName = @"Dev_WPD";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    if (![WXApi registerApp:@"wx3b4c0f3be08becc9" withDescription:nil])
    {
        MESSAGE(@"微信支付初始化失败");
    }
}

- (void)setSystemSettingsWithApplication:(UIApplication *)application
{
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        [application registerForRemoteNotifications];
        
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else
    {
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    
    //MobClick
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    UMConfigInstance.appKey = UmengAppkey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    //UMCommunity
    [UMComSession openLog:YES];
    [UMCommunity setAppKey:UMengCommunityAppkey withAppSecret:UMengCommunityAppSecret];
    
    if (![RWChatManager defaultManager])
    {
        MESSAGE(@"聊天观察者初始化失败");
    }
    
    if (!__SYS_SETTINGS__)
    {
        MESSAGE(@"配置列表加载失败");
    }
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)setWindowSettings
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window makeKeyAndVisible];
    
    RWMainTabBarController *mainTabBar = [[RWMainTabBarController alloc] init];
    _window.rootViewController = mainTabBar;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    
    if (result == FALSE)
    {
        //调用其他SDK，例如支付宝SDK等
    }
    
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self examinePushInformation];
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
