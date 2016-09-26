//
//  RWObjectModels.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RWDoctorStatus)
{
    RWDoctorStatusRevoke    = -3,//
    RWDoctorStatusReject    = -2,
    RWDoctorStatusWaitCheck = -1,
    RWDoctorStatusUnUpload,
    RWDoctorStatusPass
};

@interface RWUser : NSObject

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, retain) NSData *header;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *umid;
@property (nonatomic, assign) BOOL defaultUser;

@property (nonatomic, assign) RWDoctorStatus doctorStatus;
@property (nonatomic, retain) NSString *reason;
@property (nonatomic, assign) BOOL online;
@property (nonatomic, assign) float money;
@property (nonatomic, assign) float balance;

@property (nonatomic, assign) NSInteger groupID;
@property (nonatomic, retain) NSString *professionTitle;
@property (nonatomic, retain) NSString *doctorDescription;

@property (nonatomic, assign) float star;
@property (nonatomic, retain) NSString *dealProbability;

@property (nonatomic, retain) NSString *officePhone;
@property (nonatomic, retain) NSString *hospital;

@end

@interface RWHistory : NSObject

@property (nonatomic,strong)NSData *header;
@property (nonatomic,strong)NSString *nickName;
@property (nonatomic,strong)NSString *EMID;
@property (nonatomic,strong)NSString *UMID;

@end

@interface RWCard : NSObject

@property (nonatomic, retain) NSString *doctorDescription;
@property (nonatomic, retain) NSString *doctorid;
@property (nonatomic, retain) NSData *header;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *office;
@property (nonatomic, retain) NSString *professionTitle;
@property (nonatomic, retain) NSString *umid;

@end

@interface RWAddress : NSObject

@property (nonatomic, assign) BOOL defaultAddress;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *builddate;

@end
