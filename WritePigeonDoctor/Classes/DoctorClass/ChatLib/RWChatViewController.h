//
//  RWChatViewController.h
//  RWWeChatController
//
//  Created by zhongyu on 16/7/22.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWWPDBaseController.h"
#import "XZMicroVideoView.h"
#import "RWMakeImageController.h"
#import <AVFoundation/AVFoundation.h>

@interface RWChatViewController : RWWPDBaseController

<
    RWWeChatBarDelegate,
    RWWeChatViewEvent,
    AVAudioPlayerDelegate,
    MicroVideoDelegate
>

@property (nonatomic,assign)CGPoint viewCenter;

@property (nonatomic,strong,readonly)AVAudioPlayer *audioPlayer;

@property (nonatomic,strong,readonly)RWWeChatBar *bar;
@property (nonatomic,strong,readonly)RWWeChatView *weChat;

@property (nonatomic,weak,readonly)RWWeChatCell *playing;
@property (nonatomic,strong,readonly)UIView *coverLayer;

@property (nonatomic,strong)RWDataBaseManager *baseManager;

@property (nonatomic,strong)RWUserItem *item;

@end
