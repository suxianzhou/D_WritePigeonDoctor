//
//  UIBarButtonItem+Block.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/20.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(UIBarButtonItem *barButtonItem);

@interface UIBarButtonItem (Block)

@property (nonatomic,copy,readonly)ActionBlock actionBlock;

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(ActionBlock)action;

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem action:(ActionBlock)action;

@end
