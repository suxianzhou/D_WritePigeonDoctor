//
//  FEAboutPassWordViewController.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/17.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEBaseViewController.h"
typedef enum
{
    TypeRegisterPassWord=0,
    
    TypeForgetPassWord
    
}TypePassWord;
@interface FEAboutPassWordViewController : FEBaseViewController
@property (nonatomic,assign)TypePassWord typePassWord;

@end
