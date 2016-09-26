//
//  RWRequsetManager.m
//  ZhongYuSubjectHubKY
//
//  Created by zhongyu on 16/4/26.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWRequsetManager.h"
#import "RWRequsetManager+UserLogin.h"
#import "SeeDoctorNavTableViewController.h"
#import "RWDataModels.h"
#import <objc/runtime.h>

typedef void (*CallBack_VIMP)(id, SEL , id , NSString *);
typedef id (*Handle_IMP)(id, SEL , id);

@implementation RWRequsetManager

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _requestManager = [AFHTTPSessionManager manager];
        _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _errorDescription = @{@"200":@"操作成功",
                              @"201":@"客户端版本不对，需升级sdk",
                              @"301":@"被封禁",
                              @"302":@"用户名或密码错误",
                              @"315":@"IP限制",
                              @"403":@"非法操作或没有权限",
                              @"404":@"对象不存在",
                              @"405":@"参数长度过长",
                              @"406":@"对象只读",
                              @"408":@"客户端请求超时",
                              @"413":@"验证失败(短信服务)",
                              @"414":@"参数错误",
                              @"415":@"客户端网络问题",
                              @"416":@"频率控制",
                              @"417":@"重复操作",
                              @"418":@"通道不可用(短信服务)",
                              @"419":@"数量超过上限",
                              @"422":@"账号被禁用",
                              @"431":@"HTTP重复请求"};
    }
    
    return self;
}

- (void)obtainServicesList
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    [_requestManager POST:__SERVICES_LIST__
               parameters:@{@"username":user.username,@"udid":__TOKEN_KEY__}
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [self requestSuccessedWithResponseObject:responseObject
                                    callBack:@"requsetServicesList:responseMessage:"
                                           handle:@"servicesWithResult:"];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         [self requestErrorCallBack:error
                             methot:@"requsetServicesList:responseMessage:"];
     }];
}

- (NSArray *)servicesWithResult:(NSArray *)result
{
    SETTINGS(__SERVICES_CACHE__, result);
    
    NSMutableArray *services = [[NSMutableArray alloc] init];
    
    for (NSDictionary *service in result)
    {
        NSString *minMoney = [service[@"minmoney"] integerValue]?
        service[@"minmoney"]:nil;
        
        [services addObject:
         
         [RWService serviceWithServiceImage:service[@"image"]
                                serviceName:service[@"servicename"]
                                   maxMoney:service[@"maxmoney"]
                                   minMoney:minMoney
                                  serviceId: [service[@"serviceid"] integerValue]
                         serviceDescription:service[@"servicedes"]]
         ];
    }
    
    return services;
}


- (void)obtainUserWithUserID:(NSString *)userID
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    NSDictionary *body = @{@"doctorid":user.username,
                           @"udid":__TOKEN_KEY__,
                           @"username":userID};
    
    [_requestManager POST:__SEARCH_USER__
               parameters:body
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
        [self requestSuccessedWithResponseObject:responseObject
                                        callBack:@"requsetUser:responseMessage:"
                                          handle:@"doctorItemWithJson:"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestErrorCallBack:error
                            methot:@"requsetUser:responseMessage:"];
    }];
}


- (void)searchProceedingOrderWithUsername:(NSString *)username
{
    [_requestManager POST:__PROCEEDING_ORDER__
               parameters:@{@"username":username,@"udid":__TOKEN_KEY__}
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [self requestSuccessedWithResponseObject:responseObject
                                    callBack:@"searchResultOrders:responseMessage:"
                                          handle:@"analysisProceedingOrderWithJson:"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestErrorCallBack:error methot:@"searchResultOrders:responseMessage:"];
    }];
}

- (void)searchOrderWithDoctorUserName:(NSString *)doctorUserName
                          orderStatus:(RWOrderStatus)orderStatus
{
    NSDictionary *body = orderStatus == 0?
                         @{@"docusername":doctorUserName,
                           @"udid":__TOKEN_KEY__}:
                         @{@"docusername":doctorUserName,
                           @"orderStatus":@(orderStatus),
                           @"udid":__TOKEN_KEY__};
    [self searchOrderWithBody:body];
}

- (void)searchOrderWithOrderid:(NSString *)orderid
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    NSDictionary *body = @{@"docusername":user.username,
                           @"orderid":orderid,
                           @"udid":__TOKEN_KEY__};
    [self searchOrderWithBody:body];
}

- (void)searchOrderWithOrderStatus:(RWOrderStatus)status
{
    NSString *stringStatus = [NSString stringWithFormat:@"%@",@(status)];
    [self searchOrderWithBody:@{@"orderstatus":stringStatus,
                                @"udid":__TOKEN_KEY__}];
}

- (void)searchOrderWithOrderStatus:(RWOrderStatus)status
                               fid:(RWServiceSite)fid
                               pid:(RWServiceType)pid
{
    NSString *stringStatus = [NSString stringWithFormat:@"%@",@(status)];
    NSString *stringFid = [NSString stringWithFormat:@"%@",@(fid)];
    NSString *stringPid = [NSString stringWithFormat:@"%@",@(pid)];
    
    NSDictionary *body = @{@"orderstatus":stringStatus,
                           @"fid":stringFid,
                           @"pid":stringPid,
                           @"udid":__TOKEN_KEY__};
    [self searchOrderWithBody:body];
}

- (void)searchOrderWithBody:(NSDictionary *)body
{
    [_requestManager POST:__SEARCH_ORDER__ parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [self requestSuccessedWithResponseObject:responseObject
                                    callBack:@"searchResultOrders:responseMessage:"
                                          handle:@"ordersWithResult:"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestErrorCallBack:error methot:@"searchResultOrders:responseMessage:"];
    }];
}

- (NSArray *)ordersWithResult:(NSArray *)result
{
    NSMutableArray *orders = [[NSMutableArray alloc] init];
    
    for (NSDictionary *JsonOrder in result)
    {
        [orders addObject:[self analysisJsonOrder:JsonOrder]];
    }
    
    return orders;
}

- (void)updateOrderWithOrder:(RWOrder *)order orderStatus:(RWOrderStatus)status
{
    NSString *stringStatus = [NSString stringWithFormat:@"%@",@(status)];
    NSDictionary *body = @{@"username":order.serviceid,
                           @"orderid":order.orderid,
                           @"orderstatus":stringStatus,
                           @"udid":__TOKEN_KEY__};
    
    [_requestManager POST:__UPDATE_ORDER__ parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSString *callBack = @"updateOrderStatusAtOrder:responseMessage:";
        
        [self requestSuccessedWithResponseObject:responseObject
                                        callBack:callBack
                                          handle:@"analysisJsonOrder:"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestErrorCallBack:error
                            methot:@"updateOrderStatusAtOrder:responseMessage:"];
    }];
}

- (void)obtainMyHomeVisit
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    NSDictionary *body = @{@"username":user.username,
                           @"udid":__TOKEN_KEY__};
    
    [_requestManager POST:__VISIT__
               parameters:body
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [self requestSuccessedWithResponseObject:responseObject
                                         callBack:@"requsetVisitHome:responseMessage:"
                                           handle:@"makeHomeVisit:"];
     }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [self requestErrorCallBack:error
                             methot:@"requsetVisitHome:responseMessage:"];
     }];

}

- (void)updateHomeVisitWithHomeVisit:(RWWeekHomeVisit *)homeVisit
{
    RWUser *user = [[RWDataBaseManager defaultManager] getDefualtUser];
    
    NSDictionary *body = @{@"username":user.username,
                           @"homevisit":homeVisit.description,
                           @"udid":__TOKEN_KEY__};
    
    [_requestManager POST:__UPDATE_VISIT__
               parameters:body
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [self requestSuccessedWithResponseObject:responseObject
                                        callBack:@"requsetVisitHome:responseMessage:"
                                          handle:@"makeHomeVisit:"];
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [self requestErrorCallBack:error
                             methot:@"requsetVisitHome:responseMessage:"];
    }];
}

- (RWWeekHomeVisit *)makeHomeVisit:(NSDictionary *)visitObj
{
    return [RWWeekHomeVisit visitWithDescription:visitObj[@"homevisitlist"]];
}

#pragma mark - analysis and handle

- (RWUserItem *)doctorItemWithJson:(NSDictionary *)Json
{
    RWUserItem *item = [[RWUserItem alloc] init];
    
    item.EMID = Json[@"username"];
    item.UMID = Json[@"umid"];
    
    return item;
}

- (RWOrder *)analysisJsonOrder:(NSDictionary *)JsonOrder
{
    RWOrder *serviceOrder = [[RWOrder alloc] init];
    
    serviceOrder.payid = JsonOrder[@"username"];
    serviceOrder.serviceid = JsonOrder[@"docusername"];
    serviceOrder.orderid = JsonOrder[@"id"];
    
    serviceOrder.buildDate = JsonOrder[@"builddate"];
    serviceOrder.payDate = JsonOrder[@"paydate"];
    serviceOrder.closeDate = JsonOrder[@"closedate"];
    serviceOrder.faceStatusDate = JsonOrder[@"statime"];
    
    serviceOrder.orderstatus = [JsonOrder[@"orderstatus"] integerValue];
    serviceOrder.fid = [JsonOrder[@"fid"] integerValue];
    serviceOrder.pid = [JsonOrder[@"pid"] integerValue];
    serviceOrder.money = [JsonOrder[@"totalmoney"] floatValue];
    serviceOrder.serviceMessage = JsonOrder[@"servicemessage"];
    serviceOrder.payMessage = JsonOrder[@"paymessage"];
    
    RWServiceDetail *detail = [RWServiceDetail serviceDetailWithDescription:JsonOrder[@"serviceiddescription"]];
    
    if (detail)
    {
        serviceOrder.servicedescription = detail;
        
        return serviceOrder;
    }
    
    return nil;
}

- (NSArray *)analysisProceedingOrderWithJson:(NSDictionary *)Json
{
    if (Json.count)
    {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        
        for (NSDictionary *orderJson in Json)
        {
            [result addObject:[self analysisJsonOrder:orderJson]];
        }
        
        return result;
    }
    
    return nil;
}

- (void)requestSuccessedWithResponseObject:(id)responseObject callBack:(NSString *)callBack handle:(NSString *)handle
{
    id Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    
    SEL callBackSelector = NSSelectorFromString(callBack);
    Method callMethot = class_getInstanceMethod([_delegate class], callBackSelector);
    CallBack_VIMP callVIMP = (CallBack_VIMP)method_getImplementation(callMethot);
    
    NSString *errorMessage = @"未返回匹配数据，请稍后再试，如果仍然不能返回数据，请联系客服。";
    
    if ([Json isKindOfClass:[NSArray class]] && callBack)
    {
        if ( [(NSArray *)Json count])
        {
            SEL handleSelector = NSSelectorFromString(handle);
            Method handleMethot = class_getInstanceMethod([self class], handleSelector);
            Handle_IMP handle = (Handle_IMP)method_getImplementation(handleMethot);
            id result = handle(self,handleSelector,Json);
            
            if (callVIMP)
            {
                callVIMP(_delegate, callBackSelector ,result,nil);
            }
        }
        else
        {
            if (callVIMP)
            {
                callVIMP(_delegate, callBackSelector ,nil,errorMessage);
            }
        }
        
        return;
    }
    
    if ([Json[@"resultcode"] integerValue] == 200 && callBack)
    {
        SEL handleSelector = NSSelectorFromString(handle);
        Method handleMethot = class_getInstanceMethod([self class], handleSelector);
        Handle_IMP handle = (Handle_IMP)method_getImplementation(handleMethot);
        id result = handle(self,handleSelector,Json[@"result"]);
        
        if (callVIMP)
        {
            callVIMP(_delegate, callBackSelector ,result,nil);
        }
    }
    else
    {
        NSString *message = Json[@"result"]?Json[@"result"]:errorMessage;
        
        if (callVIMP)
        {
            callVIMP(_delegate, callBackSelector ,nil,message);
        }
    }
}

- (void)requestErrorCallBack:(NSError *)error methot:(NSString *)methot
{
    SEL delegateSelector = NSSelectorFromString(methot);
    Method callMethot = class_getInstanceMethod([_delegate class], delegateSelector);
    CallBack_VIMP callVIMP = (CallBack_VIMP)method_getImplementation(callMethot);
    
    if (callMethot)
    {
        if (!__NET_STATUS__)
        {
            callVIMP(_delegate, delegateSelector ,nil,@"网络连接失败，请检查网络");
        }
        else
        {
            NSString *message = [NSString stringWithFormat:@"服务器连接失败\n\nreason:%@",error.description];
            
            callVIMP(_delegate, delegateSelector ,nil,message);
        }
    }
}

- (void)receivePushMessageOfHTML:(void(^)(NSString *html,NSError *error))complete
{
    
    [_requestManager GET:RECEIVE_PUSH parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        complete([Json objectForKey:@"url"],nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        complete(nil,error);
    }];
}

+ (void)warningToViewController:(__kindof UIViewController *)viewController Title:(NSString *)title Click:(void(^)(void))click
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *registerAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if (click)
        {
            click();
        }
    }];
    
    [alert addAction:registerAction];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}


@end

@implementation RWImageFormData

+ (instancetype)formDataWithImage:(UIImage *)image name:(NSString *)name
{
    RWImageFormData *formData = [[RWImageFormData alloc] init];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    if (imageData)
    {
        formData.imageData = imageData;
        formData.name = name;
        formData.fileName = [NSString stringWithFormat:@"%@.png",name];
        formData.mimeType = @"image/PNG";
    }
    else
    {
        imageData = UIImageJPEGRepresentation(image,1.0);
        formData.imageData = imageData;
        formData.name = name;
        formData.fileName = [NSString stringWithFormat:@"%@.jpeg",name];
        formData.mimeType = @"image/JPEG";
    }
    
    return formData;
}

@end
