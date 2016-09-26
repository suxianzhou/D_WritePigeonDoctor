//
//  UITabBarController+toLoginViewController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/9.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "UITabBarController+toLoginViewController.h"
#import "FELoginViewController.h"
#import "InfoViewController.h"
#import "RWDataBaseManager.h"
#import "RWMainTabBarController.h"

@implementation UITabBarController (toLoginViewController)

- (void)toLoginViewController
{
    [self toLoginAndVerifty:NO];
}

- (void)toLoginViewControllerAndVerifyStatus
{
    [self toLoginAndVerifty:YES];
}

- (void)toLoginAndVerifty:(BOOL)verifty
{
    RWMainTabBarController *tabBar = (RWMainTabBarController *)self;
    
    if ([RWChatManager defaultManager].statusForLink == RWLinkStateOfAutoLogin)
    {
        [MBProgressHUD Message:@"自动登录中请稍后..." For:self.view];
        return;
    }
    else if ([RWChatManager defaultManager].statusForLink == RWLinkStateOfLoginFinish)
    {
        if (verifty)
        {
            [tabBar verifyStatus];
        }
        return;
    }
    
    FELoginViewController *loginView = [[FELoginViewController alloc] init];
    
    [self presentViewController:loginView animated:YES completion:nil];
    [tabBar toRootViewController];
}

- (void)toPerfectPersonalInformation
{
    InfoViewController * ifVC=[[InfoViewController alloc]init];

    [self presentViewController:ifVC animated:YES completion:nil];
}

- (void)addWaterAnimation
{
    CATransition *transition = [CATransition animation];
    
    transition.type = @"rippleEffect";
    
    transition.subtype = @"fromLeft";
    
    transition.duration = 1;
    
    [self.view.layer addAnimation:transition forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
