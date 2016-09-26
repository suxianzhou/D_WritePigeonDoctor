//
//  UMComSimpleTopicFeedTableViewController.m
//  UMCommunity
//
//  Created by 张军华 on 16/5/23.
//  Copyright © 2016年 Umeng. All rights reserved.
//

#import "UMComSimpleTopicFeedTableViewController.h"
#import "UMComFeedListDataController.h"
#import "UMComTopic.h"
#import "UMComBriefEditViewController.h"
#import "UMComLoginManager.h"
#import "UMComFeed.h"
#import "UMComSimpleFeedDetailViewController.h"

@interface UMComSimpleTopicFeedTableViewController ()

-(void) createNavigationItems;
- (void)handlePostFeedCompleteSucceed:(NSNotification *)notification;
@end

@implementation UMComSimpleTopicFeedTableViewController

- (void)viewDidLoad {
    
    UMComTopicFeedDataController* dataController = [UMComTopicFeedDataController fecthFeedsTopicRelatedWithTopicId:self.topic.topicID sortType:UMComTopicFeedSortType_default isReverse:NO count:UMCom_Limit_Page_Count];

    UMComTopTopicFeedListDataController* topTopicFeedDataController =  [[UMComTopTopicFeedListDataController alloc] init];
    topTopicFeedDataController.topicID = self.topic.topicID;
    dataController.topFeedListDataController = topTopicFeedDataController;

    self.dataController = dataController;
    
    self.topFeedType = UMComTopFeedType_TopicTopFeed;
    
    self.isHideTopicName = YES;
    
    self.isShowEditButton = YES;//话题下feed界面默认为显示

    [super viewDidLoad];
    
    [self createNavigationItems];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePostFeedCompleteSucceed:) name:kNotificationPostFeedResultNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __DEFAULT_NAVIGATION_BAR__;
    __NAVIGATION_DEUAULT_SETTINGS__
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationPostFeedResultNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private method
-(void) handleBackBtn:(id)target
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) createNavigationItems
{
    //设置NavigationItem的Leftitem
    /*
    //取消导航栏的返回按钮，基类已经实现默认返回按钮
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backBtn.frame = CGRectMake(0, 0, 44,24);
    [backBtn setImage:UMComSimpleImageWithImageName(@"um_com_backward") forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    [backBtn addTarget:self action:@selector(handleBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backBtnItem =  [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBtnItem;
     */
    
    //设置NavigationItem的rightitem
    UIButton* postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.backgroundColor = [UIColor clearColor];
    postBtn.frame = CGRectMake(0, 0, 44,24);
    UIBarButtonItem* postBtnItem =  [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItem = postBtnItem;
    
    //设置中间文本
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    titleLabel.text = self.topic.name;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = UMComFontNotoSansLightWithSafeSize(16);
    titleLabel.textColor =  UMComColorWithColorValueString(@"FFFFFF");
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.navigationItem setTitleView:titleLabel];
    
}

#pragma mark - override method

-(void)onClickEdit:(id)sender
{
    __weak typeof(self) weakSelf = self;
    [UMComLoginManager performLogin:self completion:^(id responseObject, NSError *error) {
        if (!error) {
             UMComBriefEditViewController* editViewController =  [[UMComBriefEditViewController alloc] initNOModifiedTopic:weakSelf.topic withPopToViewController:weakSelf];
            [weakSelf.navigationController pushViewController:editViewController animated:YES];
        }
    }];
}

#pragma mark - handle post Create Feed 
- (void)handlePostFeedCompleteSucceed:(NSNotification *)notification
{
    __weak typeof(self) weakself = self;
    UMComFeed* feed =  notification.object;
    if (![feed isKindOfClass:[UMComFeed class]]) {
        return;
    }
    //判断当前话题是否属于当前话题
    UMComTopic* tempTopic =   feed.topics.firstObject;
    if (tempTopic && [tempTopic isKindOfClass:[UMComTopic class]] && [self.topic.topicID isEqualToString:tempTopic.topicID]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (feed && [feed isKindOfClass:[UMComFeed class]]) {
                //插入到置顶数据之下
                [weakself insertRowWithIndex:self.dataController.topItemsCount withNewFeed:feed];
            }
        });
    }
}

#pragma mark - UMComFeedClickActionDelegate
- (void)customObj:(id)obj clickOnTopic:(UMComTopic *)topic
{
    if ([self.topic.topicID isEqualToString:topic.topicID]) {
        return;
    }
    UMComSimpleTopicFeedTableViewController* topicFeedViewController =  [[UMComSimpleTopicFeedTableViewController alloc] init];
    topicFeedViewController.topic = topic;
    topicFeedViewController.isShowEditButton = YES;
    [self.navigationController pushViewController:topicFeedViewController animated:YES];
}

- (void)customObj:(id)obj clickOnFeedText:(UMComFeed *)feed
{
    UMComSimpleFeedDetailViewController *detailVc = [[UMComSimpleFeedDetailViewController alloc] init];
    detailVc.feed = feed;
    detailVc.isHideTopicName = YES;
    detailVc.feedOperationDelegate = self;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
