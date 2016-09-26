//
//  RWProceedingController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/3.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWProceedingController.h"
#import "RWConsultViewController.h"
#import "RWOrderProgressController.h"

@interface RWProceedingController ()

@end

@implementation RWProceedingController

+ (instancetype)proceedingWithOrder:(RWOrder *)order
{
    if (order.pid > 0)
    {
        RWOrderProgressController *progress = [[RWOrderProgressController alloc] init];
        
        RWProceedingController *proceeding = [[RWProceedingController alloc] initWithRootViewController:progress];
        proceeding.order = order;
        progress.order = proceeding.order;
        
        return proceeding;
    }
    else
    {
        RWConsultViewController *consult = [[RWConsultViewController alloc] init];
        
        RWProceedingController *proceeding = [[RWProceedingController alloc] initWithRootViewController:consult];
        proceeding.order = order;
        consult.order = proceeding.order;
        
        return proceeding;
    }
}

- (void)returnMainView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
