//
//  RWChatViewController.m
//  RWWeChatController
//
//  Created by zhongyu on 16/7/22.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWChatViewController.h"
#import "RWDataBaseManager+NameCardCollectMessage.h"
//#import "RWNameCardController.h"
#import "FEShareView.h"
@implementation RWChatViewController

#pragma mark - chatView - delegate

- (void)wechatCell:(RWWeChatCell *)wechat event:(RWMessageEvent)event
{
    switch (event)
    {
        case RWMessageEventTapImage:
        {
            [_bar.makeTextMessage.textView resignFirstResponder];
            
            if (_bar.faceResponceAccessory == RWChatBarButtonOfExpressionKeyboard)
            {
                self.view.center = _viewCenter;
                
                [UIView animateWithDuration:1.f animations:^{
                    
                    _bar.inputView.frame = __KEYBOARD_FRAME__;
                    
                    [_bar.inputView removeFromSuperview];
                }];
            }
            else if (_bar.faceResponceAccessory == RWChatBarButtonOfOtherFunction)
            {
                self.view.center = _viewCenter;
                
                [UIView animateWithDuration:1.f animations:^{
                    
                    _bar.purposeMenu.frame = __KEYBOARD_FRAME__;
                    
                    [_bar.purposeMenu removeFromSuperview];
                }];
            }
            
            EMImageMessageBody *body = (EMImageMessageBody *)wechat.message.message.body;
            
            [RWPhotoAlbum photoAlbumWithImage:[UIImage imageWithContentsOfFile:body.localPath]];
            
            break;
        }
        case RWMessageEventTapVoice:
        {
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)wechat.message.message.body;
            
            NSData *voiceData = wechat.message.originalResource?
            wechat.message.originalResource:
            [NSData dataWithContentsOfFile:body.localPath];
            
            if (_audioPlayer)
            {
                [_audioPlayer stop];
                
                if (_audioPlayer.data == voiceData)
                {
                    _audioPlayer = nil;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [wechat.voiceButton.playAnimation stopAnimating];
                    });
                    
                    return;
                }
                
                if (_playing)
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (_playing.voiceButton.playAnimation.isAnimating)
                        {
                            [_playing.voiceButton.playAnimation stopAnimating];
                        }
                        
                        _playing = nil;
                        
                        CFRunLoopRef runLoopRef = CFRunLoopGetCurrent();
                        CFRunLoopStop(runLoopRef);
                    });
                    
                    CFRunLoopRun();
                }
                
                _audioPlayer = nil;
            }
            
            _audioPlayer = [[AVAudioPlayer alloc] initWithData:voiceData error:nil];
            _audioPlayer.delegate = self;
            
            _playing = wechat;
            [_audioPlayer play];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    _audioPlayer = nil;
}

- (void)touchSpaceAtwechatView:(RWWeChatView *)wechatView
{
    [_bar.makeTextMessage.textView resignFirstResponder];
    
    if (_bar.faceResponceAccessory == RWChatBarButtonOfExpressionKeyboard)
    {
        self.view.center = _viewCenter;
        
        [UIView animateWithDuration:1.f animations:^{
            
            _bar.inputView.frame = __KEYBOARD_FRAME__;
            
            [_bar.inputView removeFromSuperview];
        }];
    }
    else if (_bar.faceResponceAccessory == RWChatBarButtonOfOtherFunction)
    {
        self.view.center = _viewCenter;
        
        [UIView animateWithDuration:1.f animations:^{
            
            _bar.purposeMenu.frame = __KEYBOARD_FRAME__;
            
            [_bar.purposeMenu removeFromSuperview];
        }];
    }
}

#pragma mark - bar - delegate - FitSize

- (void)keyboardWillChangeSize:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGFloat distance = beginFrame.origin.y - endFrame.origin.y;
    CGPoint pt = self.view.center;
    pt.y -= distance;
    
    void(^animations)() = ^{ self.view.center = pt; };
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:(curve << 16|UIViewAnimationOptionBeginFromCurrentState)
                     animations:animations completion:nil];
}

- (void)openAccessoryInputViewAtChatBar:(RWWeChatBar *)chatBar
{
    if (chatBar.purposeMenu.superview)
    {
        self.view.center = _viewCenter;
        chatBar.purposeMenu.frame = __KEYBOARD_FRAME__;
        
        [chatBar.purposeMenu removeFromSuperview];
    }
    
    [self.view.window addSubview:chatBar.inputView];
    
    if (self.view.center.y != _viewCenter.y)
    {
        self.view.center = _viewCenter;
        chatBar.inputView.frame = __KEYBOARD_FRAME__;
        
        [chatBar.inputView removeFromSuperview];
        
        return;
    }
    
    CGPoint pt = self.view.center , inputViewPt = chatBar.inputView.center;
    
    pt.y -= chatBar.inputView.frame.size.height;
    inputViewPt.y -= chatBar.inputView.frame.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        chatBar.inputView.center = inputViewPt;
        self.view.center = pt;
    }];
}

- (void)openMultiPurposeMenuAtChatBar:(RWWeChatBar *)chatBar
{
    if (chatBar.inputView.superview)
    {
        self.view.center = _viewCenter;
        chatBar.inputView.frame = __KEYBOARD_FRAME__;
        
        [chatBar.inputView removeFromSuperview];
    }
    
    [self.view.window addSubview:chatBar.purposeMenu];
    
    if (self.view.center.y != _viewCenter.y)
    {
        self.view.center = _viewCenter;
        chatBar.purposeMenu.frame = __KEYBOARD_FRAME__;
        
        [chatBar.purposeMenu removeFromSuperview];
        
        return;
    }
    
    CGPoint pt = self.view.center , purposeMenuPt = chatBar.purposeMenu.center;
    
    pt.y -= chatBar.purposeMenu.frame.size.height;
    purposeMenuPt.y -= chatBar.purposeMenu.frame.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        chatBar.purposeMenu.center = purposeMenuPt;
        self.view.center = pt;
    }];
}

#pragma mark - bar - textView

- (void)beginEditingTextAtChatBar:(RWWeChatBar *)chatBar
{
    if (chatBar.faceResponceAccessory == RWChatBarButtonOfExpressionKeyboard)
    {
        self.view.center = _viewCenter;
        chatBar.inputView.frame = __KEYBOARD_FRAME__;
        
        [chatBar.inputView removeFromSuperview];
    }
    else if (chatBar.faceResponceAccessory == RWChatBarButtonOfOtherFunction)
    {
        self.view.center = _viewCenter;
        chatBar.purposeMenu.frame = __KEYBOARD_FRAME__;
        
        [chatBar.purposeMenu removeFromSuperview];
    }
}

#pragma mark - bar - PurposeMenu

- (void)chatBar:(RWWeChatBar *)chatBar selectedFunction:(RWPurposeMenu)function
{
    switch (function)
    {
        case RWPurposeMenuOfPhoto:
        {
            RWMakeImageController *makeImage = [RWMakeImageController makeImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary didSelectedImage:^(NSData *imageData, NSString *imageName)
                                                {
                                                    
                                                    [self sendMessage:
                                                     
                                                     [RWChatMessageMaker messageWithType:EMMessageBodyTypeImage
                                                                                    body:@{messageImageBody:imageData,
                                                                                           messageImageName:imageName}
                                                                               extension:nil]
                                                     
                                                                 type:RWMessageTypeImage
                                                        LocalResource:imageData];
                                                }];
            
            if (makeImage)
            {
                [self presentViewController:makeImage animated:YES completion:nil];
            }
            else
            {
                [RWSettingsManager promptToViewController:self
                                                    Title:@"相册打开失败"
                                                 response:nil];
            }
            
            break;
        }
        case RWPurposeMenuOfCamera:
        {
            RWMakeImageController *makeImage = [RWMakeImageController makeImageWithSourceType:UIImagePickerControllerSourceTypeCamera didSelectedImage:^(NSData *imageData, NSString *imageName)
                                                {
                                                    
                                                    
                                                    [self sendMessage:
                                                     
                                                     [RWChatMessageMaker messageWithType:EMMessageBodyTypeImage
                                                                                    body:@{messageImageBody:imageData,
                                                                                           messageImageName:imageName}
                                                                               extension:nil]
                                                     
                                                                 type:RWMessageTypeImage
                                                        LocalResource:imageData];
                                                    
                                                    [makeImage dismissViewControllerAnimated:YES completion:nil];
                                                }];
            
            if (makeImage)
            {
                [self presentViewController:makeImage animated:YES completion:nil];
            }
            else
            {
                [RWSettingsManager promptToViewController:self
                                                    Title:@"相机打开失败"
                                                 response:nil];
            }
            
            break;
        }
        case RWPurposeMenuOfSmallVideo: [self makeSmallVideo]; break;
        case RWPurposeMenuOfMyCard: [self openMyNameCard]; break;
        case RWPurposeMenuOfCollect: [self collectDoctorCard]; break;
        case RWPurposeMenuOfUploadMessageCache: [self uploadMessageCache]; break;
        default: break;
    }
    
    self.view.center = _viewCenter;
    chatBar.purposeMenu.frame = __KEYBOARD_FRAME__;
    
    [chatBar.purposeMenu removeFromSuperview];
}

- (void)uploadMessageCache
{
    [MBProgressHUD Message:@"暂不支持聊天缓存" For:self.view];
}

- (void)collectDoctorCard
{
    RWChatViewController *weakSelf = self;
    
    [_baseManager addNameCardWithItem:_item completion:^(BOOL success)
     {
         if (success)
         {
             [MBProgressHUD Message:@"收藏成功" For:weakSelf.view];
         }
         else
         {
             [MBProgressHUD Message:@"收藏失败" For:weakSelf.view];
         }
     }];
}

- (void)openMyNameCard
{
//    RWNameCardController *card = [[RWNameCardController alloc] init];
//    
//    [self.navigationController pushViewController:card animated:YES];
}

#pragma mark voice

- (void)sendVoice:(NSData *)voice time:(NSInteger)second MP3Path:(NSString *)path
{
    [self sendMessage:
     
     [RWChatMessageMaker messageWithType:EMMessageBodyTypeVoice
                                    body:@{messageVoiceBody:voice,
                                           messageVoiceName:[RWChatManager videoName],
                                           messageVoiceDuration:@(second)}
                               extension:nil]
     
                 type:RWMessageTypeVoice
        LocalResource:voice];
}

#pragma mark - video

- (void)makeSmallVideo
{
    [self.view addSubview:_coverLayer];
    
    CGFloat selfWidth  = self.view.bounds.size.width;
    CGFloat selfHeight = self.view.bounds.size.height;
    XZMicroVideoView *microVideoView = [[XZMicroVideoView alloc] initWithFrame:CGRectMake(0, selfHeight/3, selfWidth, selfHeight * 2/3)];
    microVideoView.delegate = self;
    
    [self.view addSubview:microVideoView];
}

#pragma mark - video - MicroVideoDelegate

- (void)touchUpDone:(NSString *)savePath
{
    EMMessage *message = [RWChatMessageMaker messageWithType:EMMessageBodyTypeVideo
                                                        body:
                          @{messageVideoBody:savePath,
                            messageVideoName:[RWChatManager videoName]}
                                                   extension:nil];
    
    [self sendMessage:message type:RWMessageTypeVideo
        LocalResource:savePath];
}

- (void)videoViewWillRemoveFromSuperView
{
    [_coverLayer removeFromSuperview];
}

- (void)chatView:(RWWeChatView *)chatView selectMessage:(RWWeChatMessage *)message textMeunType:(RWTextMenuType)type
{
    FEShareView * FESV=[[FEShareView alloc]init];
    
    switch (type)
    {
        case RWTextMenuTypeOfRelay:
        {
            if (message.messageType == RWMessageTypeText)
            {
                EMTextMessageBody *body = (EMTextMessageBody *)message.message.body;
                
                //                [FEvc shareAppParamsByContentText:body.text
                //                                            title:@"来自白鸽医生的分享"
                //                                           images:nil
                //                                         ShareUrl:nil
                //                                      urlResource:(UMSocialUrlResourceTypeDefault)];
                
                [FESV shareAppParamsByContentText:body.text title:@"来自白鸽医生的分享" images:nil ShareUrl:nil urlResource:(UMSocialUrlResourceTypeDefault) presentedController:self];
                
            }
            else if (message.messageType == RWMessageTypeImage)
            {
                EMImageMessageBody *body = (EMImageMessageBody *)message.message.body;
                
                NSData *imageData = message.originalResource?message.originalResource:[NSData dataWithContentsOfFile:body.localPath];
                //
                //                [FEvc shareAppParamsByContentText:body.displayName
                //                                            title:@"来自白鸽医生的分享"
                //                                           images:imageData
                //                                         ShareUrl:body.localPath
                //                                      urlResource:(UMSocialUrlResourceTypeImage)];
                [FESV shareAppParamsByContentText:body.displayName title:@"来自白鸽医生的分享" images:imageData ShareUrl:body.localPath urlResource:(UMSocialUrlResourceTypeImage) presentedController:self];
                
            }
            else if (message.messageType == RWMessageTypeVoice)
            {
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)message.message.body;
                
                NSData *voiceData = message.originalResource?message.originalResource:[NSData dataWithContentsOfFile:body.localPath];
                
                //                [FEvc shareAppParamsByContentText:body.displayName
                //                                            title:@"来自白鸽医生的分享"
                //                                           images:voiceData
                //                                         ShareUrl:body.localPath
                //                                      urlResource:(UMSocialUrlResourceTypeMusic)];
                [FESV shareAppParamsByContentText:body.displayName title:@"来自白鸽医生的分享" images:voiceData ShareUrl:body.localPath urlResource:(UMSocialUrlResourceTypeMusic) presentedController:self];
            }
            else if (message.messageType == RWMessageTypeVideo)
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)message.message.body;
                //                [FEvc shareAppParamsByContentText:body.displayName
                //                                            title:@"来自白鸽医生的分享"
                //                                           images:nil
                //                                         ShareUrl:body.localPath
                //                                      urlResource:(UMSocialUrlResourceTypeVideo)];
                [FESV shareAppParamsByContentText:body.displayName title:@"来自白鸽医生的分享" images:nil ShareUrl:body.localPath urlResource:(UMSocialUrlResourceTypeVideo) presentedController:self];
            }
            
            [self.view addSubview:FESV];
        }
            break;
        case RWTextMenuTypeOfCollect:
        {
            if ([self.baseManager hasNameCard:message])
            {
                if ([self.baseManager collectMessage:message])
                {
                    [MBProgressHUD Message:@"已收藏" For:self.view];
                }
                else
                {
                    [MBProgressHUD Message:@"收藏失败" For:self.view];
                }
            }
            else
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"未收藏医生名片\n\n收藏消息需要先收藏医生名片。" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *resetPasswordAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    RWChatViewController *weakSelf = self;
                    
                    [_baseManager addNameCardWithItem:_item completion:^(BOOL success)
                     {
                         if (success)
                         {
                             if ([weakSelf.baseManager collectMessage:message])
                             {
                                 [MBProgressHUD Message:@"已收藏" For:weakSelf.view];
                             }
                             else
                             {
                                 [MBProgressHUD Message:@"收藏失败" For:weakSelf.view];
                             }
                         }
                         else
                         {
                             [MBProgressHUD Message:@"收藏失败" For:weakSelf.view];
                         }
                     }];
                }];
                
                UIAlertAction *reLoginAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { [MBProgressHUD Message:@"收藏失败" For:self.view]; }];
                
                [alert addAction:resetPasswordAction];
                [alert addAction:reLoginAction];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            break;
        }
        case RWTextMenuTypeOfDelete:
        {
            if (![self.baseManager removeCacheMessage:message])
            {
                MESSAGE(@"删除失败");
            }
            
            break;
        }
        default:break;
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    __NAVIGATION_DEUAULT_SETTINGS__;
    
    _baseManager = [RWDataBaseManager defaultManager];
    
    _viewCenter = self.view.center;
    
    if (self.navigationController && !self.navigationController.navigationBar.hidden)
    {
        _viewCenter.y += (self.navigationController.navigationBar.bounds.size.height/2);
        
        CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
        
        _viewCenter.y += (statusFrame.size.height / 2);
    }
    
    if (self.tabBarController && !self.tabBarController.tabBar.hidden)
    {
        _viewCenter.y -= (self.tabBarController.tabBar.bounds.size.height / 2);
    }
    
    _coverLayer = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _coverLayer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    
    _bar = [RWWeChatBar wechatBarWithAutoLayout:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.equalTo(@(49));
    }];
    
    _bar.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    _bar.delegate = self;
    
    [self.view addSubview:_bar];
    
    _weChat = [RWWeChatView chatViewWithAutoLayout:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(_bar.mas_top).offset(0);
        
    } messages:[NSMutableArray array]];
    
    _weChat.eventSource = self;
    
    [self.view addSubview:_weChat];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_bar.purposeMenu removeFromSuperview];
    [_bar.inputView removeFromSuperview];
}

#pragma mark - send message

- (void)sendMessage:(EMMessage *)message type:(RWMessageType)type LocalResource:(id)resource
{
    RWUser *user = [_baseManager getDefualtUser];
    
    UIImage *header = [UIImage imageWithData:user.header];
    
    RWWeChatMessage *chatMessage = [RWWeChatMessage message:message
                                                     header:header
                                                       type:type
                                                  myMessage:YES
                                                messageDate:[NSDate date]
                                                   showTime:NO
                                           originalResource:resource];
    
    [_weChat addMessage:chatMessage];
    
    if (![_baseManager cacheMessage:chatMessage])
    {
        MESSAGE(@"消息缓存失败");
    }
}

@end
