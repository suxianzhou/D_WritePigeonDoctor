//
//  RWRequsetManager.h
//  ZhongYuSubjectHubKY
//
//  Created by zhongyu on 16/4/26.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "RWRequestIndex.h"
#import "RWDataModels.h"
#import "RWOrderView.h"

@protocol RWRequsetDelegate <NSObject>
@optional
/**
 *  返回医生用户信息
 *
 *  @param user          用户信息
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)requsetUser:(RWUserItem *)user
    responseMessage:(NSString *)responseMessage;

/****************    医生相关    ****************/

- (void)requsetVisitHome:(RWWeekHomeVisit *)visitHome
         responseMessage:(NSString *)responseMessage;

/****************    预约相关    ****************/
/**
 *  返回服务列表
 *
 *  @param servicesList    服务列表
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)requsetServicesList:(NSArray *)servicesList
            responseMessage:(NSString *)responseMessage;
/**
 *  返回订单信息
 *
 *  @param order           订单信息
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)orderReceipt:(RWOrder *)order
     responseMessage:(NSString *)responseMessage;
/**
 *  订单搜索回调
 *
 *  @param orders          搜索到的订单
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)searchResultOrders:(NSArray *)orders
           responseMessage:(NSString *)responseMessage;
/**
 *  更新订单状态回调
 *
 *  @param order           更新后的订单
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)updateOrderStatusAtOrder:(RWOrder *)order
                 responseMessage:(NSString *)responseMessage;

/****************    用户登录注册忘记密码    ****************/
/**
 *  用户登录回调
 *
 *  @param success         是否成功
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)userLoginSuccess:(BOOL)success
         responseMessage:(NSString *)responseMessage;
/**
 *  用户注册回调
 *
 *  @param success         是否成功
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)userRegisterSuccess:(BOOL)success
            responseMessage:(NSString *)responseMessage;
/**
 *  用户重置密码回调
 *
 *  @param success         是否成功
 *  @param responseMessage 成功为 nil 失败返回错误信息
 */
- (void)userReplacePasswordResponds:(BOOL)success
                    responseMessage:(NSString *)responseMessage;

@end

@interface RWRequsetManager : NSObject

@property (nonatomic,assign)id <RWRequsetDelegate> delegate;

@property (nonatomic,strong)AFHTTPSessionManager *requestManager;
@property (nonatomic,strong)NSDictionary *errorDescription;
/**
 *  获取服务列表
 */
- (void)obtainServicesList;
/**
 *  获取用户信息
 *
 *  @param doctorID 用户id
 */
- (void)obtainUserWithUserID:(NSString *)userID;
/**
 *  搜索正在进行中的订单
 *
 *  @param username 
 */
- (void)searchProceedingOrderWithUsername:(NSString *)username;
/**
 *  搜索医生订单
 *
 *  @param doctorUserName 医生id
 *  @param orderStatus    订单状态  搜索全部为 0
 */
- (void)searchOrderWithDoctorUserName:(NSString *)doctorUserName
                          orderStatus:(RWOrderStatus)orderStatus;
/**
 *  搜索某种状态的全部订单
 *
 *  @param status 状态
 */
- (void)searchOrderWithOrderStatus:(RWOrderStatus)status;
/**
 *  搜索符合某种条件的全部订单
 *
 *  @param status 订单状态
 *  @param fid    服务地点
 *  @param pid    服务类型
 */
- (void)searchOrderWithOrderStatus:(RWOrderStatus)status
                               fid:(RWServiceSite)fid
                               pid:(RWServiceType)pid;
/**
 *  更新订单状态
 *
 *  @param order  订单
 *  @param status 最新状态
 */
- (void)updateOrderWithOrder:(RWOrder *)order
                 orderStatus:(RWOrderStatus)status;
/**
 *  获取出诊信息
 */
- (void)obtainMyHomeVisit;
/**
 *  上传出诊信息
 *
 *  @param homeVisit 出诊信息
 */
- (void)updateHomeVisitWithHomeVisit:(RWWeekHomeVisit *)homeVisit;

- (void)requestSuccessedWithResponseObject:(id)responseObject
                                  callBack:(NSString *)callBack
                                    handle:(NSString *)handle;

- (void)requestErrorCallBack:(NSError *)error methot:(NSString *)methot;

- (void)receivePushMessageOfHTML:(void(^)(NSString *html,NSError *error))complete;

+ (void)warningToViewController:(__kindof UIViewController *)viewController Title:(NSString *)title Click:(void(^)(void))click;


@end

@interface RWImageFormData : NSObject

+ (instancetype)formDataWithImage:(UIImage *)image name:(NSString *)name;

@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)NSString *fileName;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *mimeType;

@end
