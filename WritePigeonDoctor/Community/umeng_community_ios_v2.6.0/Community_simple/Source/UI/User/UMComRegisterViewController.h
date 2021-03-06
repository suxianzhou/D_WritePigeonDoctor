//
//  UMComRegisterViewController.h
//  UMCommunity
//
//  Created by wyq.Cloudayc on 5/11/16.
//  Copyright © 2016 Umeng. All rights reserved.
//

#import "UMComViewController.h"
#import "UMComImageView.h"

typedef void (^LoginCompletion)(id responseObject, NSError *error);

@interface UMComRegisterViewController : UMComViewController

@property (weak, nonatomic) IBOutlet UMComImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *passwordHiddenButton;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *bars;

@property (nonatomic, strong) LoginCompletion completion;

- (IBAction)changePassworkHidden:(id)sender;

- (IBAction)registerAccount:(id)sender;

@end
