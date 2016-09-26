
//
//  RWRequsetManager+UserLogin.m
//  ZhongYuSubjectHubKY
//
//  Created by zhongyu on 16/5/10.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWRequsetManager+UserLogin.h"
#import "XZUMComPullRequest.h"
#import "UMComUser.h"
#import "UMComSession.h"
#import "UMComImageUrl.h"
#import "UMComMacroConfig.h"
#import "RWDataBaseManager.h"
#import "RWChatManager.h"
#import "NSString+UMName.h"

RWGender getGenderIdentifier(NSString *gender)
{
    return [gender isEqualToString:@"男"]?RWGenderIsMan:RWGenderIsWoman;
}

NSString *getGender(RWGender gender)
{
    return gender?@"男":@"女";
}

@implementation RWRequsetManager (UserLogin)

- (void)registerWithUsername:(NSString *)username AndPassword:(NSString *)password verificationCode:(NSString *)verificationCode
{
    [XZUMComPullRequest userCustomAccountLoginWithName:[username defaultUMName]
                                              sourceId:username
                                              icon_url:nil
                                                gender:0
                                                   age:20
                                                custom:nil
                                                 score:0
                                            levelTitle:nil
                                                 level:0
                                     contextDictionary:nil
                                          userNameType:userNameDefault
                                        userNameLength:userNameLengthDefault
                                            completion:^(NSDictionary *responseObject, NSError *error)
     {
         if(!error)
         {
             UMComUser *umuser = responseObject[UMComModelDataKey];
            
             NSDictionary *body = @{@"username":username,
                                    @"password":password,
                                    @"udid":__TOKEN_KEY__,
                                    @"yzm":verificationCode,
                                    @"umid":umuser.uid};
             
             [self.requestManager POST:__USER_REGISTER__
                            parameters:body
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
              {
                  NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                  
                  if ([[Json objectForKey:@"resultCode"] integerValue] == 200)
                  {
                      RWUser *user = [[RWUser alloc] init];
                      
                      user.username = username;
                      user.password = password;
                      user.umid = umuser.uid;
                      
                      RWDataBaseManager *baseManager =
                      [RWDataBaseManager defaultManager];
                      
                      [baseManager addNewUesr:user];
                      
                      [self.delegate userRegisterSuccess:YES
                                         responseMessage:nil];
                  }
                  else
                  {
                      if ([Json objectForKey:@"result"])
                      {
                          NSDictionary *result = Json[@"result"];
                          
                          NSString *error =
                          [NSString stringWithFormat:@"error:%@\nerror_description:%@",result[@"error"],result[@"error_description"]];
                          
                          [self.delegate userRegisterSuccess:NO
                                             responseMessage:error];
                      }
                      else
                      {
                          [self.delegate userRegisterSuccess:NO
                                             responseMessage:@"注册失败"];
                      }
                  }
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
              {
                  [self.delegate userRegisterSuccess:NO
                                     responseMessage:error.description];
              }];
         }
         else
         {
             [self.delegate userRegisterSuccess:NO
                                responseMessage:error.description];
         }
     }];
}

- (void)setUserHeader:(UIImage *)header
                 name:(NSString *)name
                  age:(NSString *)age
                  sex:(NSString *)sex
           completion:(void(^)(BOOL success,NSString *errorReason))completion
{
    RWDataBaseManager *baseManager = [RWDataBaseManager defaultManager];
    
    RWUser *user = [baseManager getDefualtUser];
    
    user.header =   UIImagePNGRepresentation(header)?
                    UIImagePNGRepresentation(header):
                    UIImageJPEGRepresentation(header,1.0);
    user.name = name;
    user.age = age;
    user.gender = sex;
    
    [XZUMComPullRequest updateProfileWithName:[user.name umNameWithID:user.username]
                                          age:@(age.integerValue)
                                       gender:@(getGenderIdentifier(user.gender))
                                       custom:nil
                                 userNameType:userNameDefault
                               userNameLength:userNameLengthDefault
                                   completion:^(NSDictionary *responseObject, NSError *error)
     {
         if (!error)
         {
             [XZUMComPullRequest userUpdateAvatarWithImage:header completion:^(NSDictionary *responseObject, NSError *error) {
                 
                 if (!error)
                 {
                     [self.requestManager POST:__USER_INFORMATION__
                                    parameters:@{@"username":user.username,@"age":age}
                                      progress:nil
                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                      {
                          
                          NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                          
                          if ([Json[@"resultCode"] integerValue] == 200)
                          {
                              if ([baseManager updateUesr:user])
                              {
                                  if (completion)
                                  {
                                      completion(YES,nil);
                                  }
                              }
                              else
                              {
                                  if (completion)
                                  {
                                      completion(NO,@"本地保存失败");
                                  }
                              }
                          }
                          else
                          {
                              if (completion)
                              {
                                  completion(NO,Json[@"result"]);
                              }
                          }

                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         if (completion)
                            completion(NO,[NSString stringWithFormat:@"上传失败!\n原因：%@",
                                        error.description]);
                     }];
                 }
                 else
                 {
                     if (completion)
                     {
                         completion(NO,[NSString stringWithFormat:@"上传失败!\n原因：%@",
                                        error.description]);
                     }
                 }
             }];
         }
         else
         {
             if (completion)
             {
                 completion(NO,[NSString stringWithFormat:@"上传失败!\n原因：%@",
                                error.description]);
             }
         }
     }];
}

- (void)setDoctorInformationHospital:(NSString *)hospital
                     profrssionTitle:(NSString *)profrssionTitle
                   doctorDescription:(NSString *)doctorDescription
                             groupid:(NSString *)groupid
                         officephone:(NSString *)officephone
                     identityidImage:(UIImage *)identityidImage
                     prafessionimage:(UIImage *)prafessionimage
                          completion:(void(^)(BOOL success,NSString *errorReason))complete
{    
    RWDataBaseManager *baseManager = [RWDataBaseManager defaultManager];
    
    RWUser *user = [baseManager getDefualtUser];
     
    user.hospital = hospital;
    user.professionTitle = profrssionTitle;
    user.doctorDescription = doctorDescription;
    user.groupID = groupid.integerValue;
    user.officePhone = officephone;
    
    NSDictionary *body = @{@"username":user.username,
                           @"hos":hospital,
                           @"title":profrssionTitle,
                           @"docdp":doctorDescription,
                           @"groupid":groupid,
                           @"officephone":officephone,
                           @"udid":__TOKEN_KEY__};
    
    [self.requestManager POST:__VERIFY_DOCTOR__ parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *idenName = [NSString stringWithFormat:@"%@idCard",user.username];
        RWImageFormData *iden = [RWImageFormData formDataWithImage:identityidImage
                                                              name:idenName];
        
        [formData appendPartWithFileData:iden.imageData
                                    name:iden.name
                                fileName:iden.fileName
                                mimeType:iden.mimeType];
        
        NSString *proName = [NSString stringWithFormat:@"%@proCard",user.username];
        RWImageFormData *pro = [RWImageFormData formDataWithImage:prafessionimage
                                                             name:proName];
        
        [formData appendPartWithFileData:pro.imageData
                                    name:pro.name
                                fileName:pro.fileName
                                mimeType:pro.mimeType];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if ([Json[@"resultCode"] integerValue] == 200)
        {
            user.doctorStatus = [Json[@"result"][@"doctorStatus"] integerValue];
            
            if ([baseManager updateUesr:user])
            {
                if (complete)
                {
                    complete(YES,nil);
                }
            }
            else
            {
                if (complete)
                {
                    complete(NO,@"本地保存失败");
                }
            }
        }
        else
        {
            if (complete)
            {
                complete(NO,Json[@"result"]);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *reason = [NSString stringWithFormat:@"上传失败!\n原因：%@",error.description];
        if (complete) complete(NO,reason);
    }];
}

- (void)userinfoWithUsername:(NSString *)username AndPassword:(NSString *)password
{
    [XZUMComPullRequest userCustomAccountLoginWithName:[username defaultUMName]
                                              sourceId:username
                                              icon_url:nil
                                                gender:0
                                                   age:0
                                                custom:nil
                                                 score:0
                                            levelTitle:nil
                                                 level:0
                                     contextDictionary:nil
                                          userNameType:userNameDefault
                                        userNameLength:userNameLengthDefault
                                            completion:^(NSDictionary *responseObject, NSError *error)
     {
         NSDictionary *UMResponse = responseObject;
         
         if(!error)
         {
             NSDictionary *body = @{@"username":username,
                                    @"password":password,
                                    @"udid":__TOKEN_KEY__};
             
             [self.requestManager POST:__USER_LOGIN__
                            parameters:body
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
              {
                  NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                  
                  if ([[Json objectForKey:@"resultCode"] integerValue] == 200)
                  {
                      if ([Json[@"result"][@"groupid"] integerValue] == 8)
                      {
                          [self saveUserInformationWithUMResponse:UMResponse
                                                             Json:Json
                                                         username:username
                                                         password:password];
                      }
                      else
                      {
                          [self userInfoEMWithUMResponse:UMResponse
                                                    Json:Json
                                                username:username
                                                password:password];
                      }
                      
                  }
                  else
                  {
                      if ([Json objectForKey:@"result"])
                      {
                          [self userinfoFailWithMessage:[Json objectForKey:@"result"]];
                      }
                      else
                      {
                          [self userinfoFailWithMessage:@"登录失败"];
                      }
                  }
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
              {
                  [self userinfoFailWithMessage:error.description];
              }];
         }
         else
         {
             [self userinfoFailWithMessage:error.description];
         }
     }];
}

- (void)userInfoEMWithUMResponse:(NSDictionary *)UMResponse
                            Json:(NSDictionary *)Json
                        username:(NSString *)username
                        password:(NSString *)password
{
    NSOperationQueue *operationQueue = [RWChatManager defaultManager].downLoadQueue;
    
    [operationQueue addOperationWithBlock:^{
        
        EMError *error = [[EMClient sharedClient]loginWithUsername:username
                                                          password:password];
        
        if (!error)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self saveUserInformationWithUMResponse:UMResponse
                                                   Json:Json
                                               username:username
                                               password:password];
            }];
        }
        else
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self userinfoFailWithMessage:@"登录失败"];
            }];
        }
    }];
}

- (void)saveUserInformationWithUMResponse:(NSDictionary *)UMResponse
                                     Json:(NSDictionary *)Json
                                 username:(NSString *)username
                                 password:(NSString *)password
{
    UMComUser *user = UMResponse[UMComModelDataKey];
    
    if (user)
    {
        [UMComSession sharedInstance].loginUser = user;
        [UMComSession sharedInstance].token = UMResponse[UMComTokenKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSucceedNotification object:nil];
    }
    
    UMComImageUrl * imageUrl = (UMComImageUrl *)user.icon_url;
    
    NSString * small = imageUrl.small_url_string;
    NSURL *imageURL = [NSURL URLWithString:small];
    
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    
    RWDataBaseManager *baseManager = [RWDataBaseManager defaultManager];
    
    if (![baseManager existUser:username])
    {
        RWUser *us = [[RWUser alloc] init];
        
        us.username = username;
        us.password = password;
        us.groupID = [Json[@"result"][@"groupid"] integerValue];
        us.umid = Json[@"result"][@"umid"];
        NSString *age = Json[@"result"][@"age"];
        us.age = [age isEqualToString:@""]?nil:age;
        us.name = [user.name umName];
        us.gender = getGender(user.gender.integerValue);
        us.header = imageData;
        us.doctorStatus = [Json[@"result"][@"doctorStatus"] integerValue];
        us.online = [Json[@"result"][@"online"] boolValue];
        
        if (us.groupID == 8)
        {
            us.doctorStatus = RWDoctorStatusUnUpload;
        }
        else
        {
            us.balance = [Json[@"result"][@"balance"] floatValue];
            us.dealProbability = Json[@"result"][@"dealProbability"];
            us.doctorDescription = Json[@"result"][@"docdp"];
            us.money = [Json[@"result"][@"expenses"] floatValue];
            us.hospital = Json[@"result"][@"hos"];
            us.name = Json[@"result"][@"nickname"];
            //公告
            us.officePhone = Json[@"result"][@"officephone"];
            us.professionTitle = Json[@"result"][@"title"];
            us.star = [Json[@"result"][@"star"] floatValue];
            us.doctorStatus = [Json[@"result"][@"doctorStatus"] integerValue];
            us.online = [Json[@"result"][@"online"] boolValue];
        }
        
        if (![baseManager addNewUesr:us])
        {
            MESSAGE(@"用户信息储存失败");
        }
    }
    else
    {
        RWUser *us = [baseManager getUser:username];
        
        if (!us.defaultUser)
        {
            us.defaultUser = YES;
        }
        
        us.username = username;
        us.password = password;
        us.umid = Json[@"result"][@"umid"];
        NSString *age = Json[@"result"][@"age"];
        us.age = [age isEqualToString:@""]?nil:age;
        us.groupID = [Json[@"result"][@"groupid"] integerValue];
        us.name = [user.name umName];
        us.gender = getGender(user.gender.integerValue);
        us.header = imageData;
        
        if (us.groupID == 8)
        {
            us.doctorStatus = RWDoctorStatusUnUpload;
        }
        else
        {
            
            us.doctorStatus = RWDoctorStatusPass;
            us.balance = [Json[@"result"][@"balance"] floatValue];
            us.dealProbability = Json[@"result"][@"dealProbability"];
            us.doctorDescription = Json[@"result"][@"docdp"];
            us.money = [Json[@"result"][@"expenses"] floatValue];
            us.hospital = Json[@"result"][@"hos"];
            us.name = Json[@"result"][@"nickname"];
            //公告
            us.officePhone = Json[@"result"][@"officephone"];
            us.professionTitle = Json[@"result"][@"title"];
            us.star = [Json[@"result"][@"star"] floatValue];
            us.doctorStatus = [Json[@"result"][@"doctorStatus"] integerValue];
            us.online = [Json[@"result"][@"online"] boolValue];
        }
        
        if (![baseManager updateUesr:us])
        {
            MESSAGE(@"用户信息储存失败");
        }
    }
    
    [self.delegate userLoginSuccess:YES
                    responseMessage:nil];
    
    send_notification(RWLoginFinishNotification,@(YES));
}

- (void)userinfoFailWithMessage:(NSString *)message
{
    [RWRequsetManager userLogout:nil];
    
    send_notification(RWLoginFinishNotification,@(NO));
    
    [self.delegate userLoginSuccess:NO
                    responseMessage:message];
}

- (void)replacePasswordWithUsername:(NSString *)username AndPassword:(NSString *)password verificationCode:(NSString *)verificationCode
{
    NSDictionary *body = @{@"username":username,
                           @"password":password,
                           @"yzm":verificationCode};
    
    [self.requestManager POST:__REPLACE_PASSWORD__
                   parameters:body
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
          NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         
          if ([[Json objectForKey:@"resultCode"] integerValue] == 200)
          {
              [self.delegate userReplacePasswordResponds:YES
                                         responseMessage:@"密码重置成功"];
          }
          else
          {
              [self.delegate userReplacePasswordResponds:NO
                                         responseMessage:[Json objectForKey:@"result"]];
          }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         [self.delegate userReplacePasswordResponds:NO
                                    responseMessage:error.description];
    }];
}

- (void)obtainVerificationWithPhoneNunber:(NSString *)phoneNumber result:(void(^)(BOOL succeed,NSString *reason))result
{
    [self.requestManager POST: __VERIFICATION_CODE__
                   parameters:@{@"username":phoneNumber,@"did":__TOKEN_KEY__}
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
          NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         
          if ([[Json objectForKey:@"code"] integerValue] == 200)
          {
              result(YES,nil);
          }
          else
          {
              NSString *errorCode =
                        [NSString stringWithFormat:@"%@",[Json objectForKey:@"code"]];
              
              NSString *description = [self.errorDescription objectForKey:errorCode];
              
              if (description)
              {
                  result(NO,description);
              }
              else
              {
                  result(NO,@"验证码获取失败");
              }
          }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          
                          result(NO,error.description);
     }];
}

- (BOOL)verificationPhoneNumber:(NSString *)phoneNumber
{
    NSString *mobile = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *regexTestMobile =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    
    return [regexTestMobile evaluateWithObject:phoneNumber];
}

- (BOOL)verificationPassword:(NSString *)password
{
    return password.length >= 6 && password.length <= 18 ? YES : NO;
}

- (BOOL)verificationEmail:(NSString *)Email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:Email];
}

- (BOOL)verificationAge:(NSString *)age
{
    for (int i = 0; i < age.length; i++)
    {
        unichar c = [age characterAtIndex:i];
        
        if (c > 57 || c < 48)
        {
            return NO;
        }
    }
    
    return YES;
}

+ (void)userLogout:(void(^)(BOOL success))complete
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        EMError *error = [[EMClient sharedClient] logout:YES];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
            if (!error)
            {
                [RWChatManager defaultManager].connectionState = EMConnectionDisconnected;
                
                [[UMComSession sharedInstance] userLogout];
                
                if (complete)
                {
                    send_notification(RWLogoutNotification,nil);
                    complete(YES);
                    return;
                }
            }
            
            if (complete)
            {
                complete(NO);
            }
        }];
    }];
    
    [[RWChatManager defaultManager].downLoadQueue addOperation:operation];
}

+ (NSArray *)getOffice
{
    return @[@"耳鼻喉科",
             @"风湿免疫",
             @"呼吸内科",
             @"内分泌科",
             @"皮肤病科",
             @"神经内科",
             @"消化内科",
             @"心血管科",
             @"血液病科",
             @"疑难杂症",
             @"针灸推拿",
             @"肿瘤内科",
             @"治未病科",
             @"中医儿科",
             @"中医妇科",
             @"中医骨科",
             @"中医美容",
             @"中医内科",
             @"中医男科",
             @"中医肾科",
             @"中医外科",
             @"中医眼科",
             @"执业护理"];
}

+ (NSNumber *)groupIDWithOffice:(NSString *)office
{
    NSArray *offices = [RWRequsetManager getOffice];
    
    for (int i = 0; i < offices.count; i++)
    {
        if ([offices[i] isEqualToString:office])
        {
            return @(i + 11);
        }
    }
    
    return nil;
}

+ (NSString *)officeWithGroupID:(NSNumber *)groupID
{
    if (groupID.integerValue < 11 || groupID.integerValue > 33)
    {
        return @"无";
    }
    
    return [[RWRequsetManager getOffice] objectAtIndex:groupID.integerValue - 11];
}


@end
