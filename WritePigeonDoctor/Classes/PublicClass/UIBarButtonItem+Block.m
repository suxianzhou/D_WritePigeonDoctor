//
//  UIBarButtonItem+Block.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/20.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "UIBarButtonItem+Block.h"

@implementation UIBarButtonItem (Block)

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(ActionBlock)action
{
    self = [self initWithTitle:title style:style target:self action:@selector(actionMethot)];
    
    self.actionBlock = action;
    
    return self;
}

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem action:(ActionBlock)action
{
    self = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(actionMethot)];
    
    self.actionBlock = action;
    
    return self;
}

- (void)actionMethot
{
    self.actionBlock(self);
}

@end
