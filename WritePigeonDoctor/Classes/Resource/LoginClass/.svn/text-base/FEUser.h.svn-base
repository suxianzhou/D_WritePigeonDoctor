//
//  FEUser.h
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/17.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    OfficeTypeWithDoctor=1,
    
    OfficeTypeWithNurse
    
}OfficeType;

@interface FEUser : NSObject
/**
 *  电话号
 */
@property(nonatomic,copy)NSString * phoneNumber;
/**
 *  验证码
 */
@property(nonatomic,copy)NSString * verification;
/**
 * 密码
 */

@property(nonatomic,copy)NSString * password;
/**
 *  姓名
 */
@property(nonatomic,copy)NSString * name;
/**
 *  医院
 */
@property(nonatomic,copy)NSString * hospital;
/**
 *  科室
 */
@property(nonatomic,copy)NSString * office;
/**
 *  职称
 */
@property(nonatomic,copy)NSString * appellation;

/**
 *  科室电话
 */

@property(nonatomic,copy)NSString * office_phoneNumber;
/**
 *  擅长及介绍
 */

@property(nonatomic,copy)NSString * introduce;
/**
 *  身份证照片
 */
@property(nonatomic,strong)UIImage * identityIDImage;
/**
 *  执业证书
 */
@property(nonatomic,strong)UIImage * professionImage;
/**
 *  头像
 */
@property(nonatomic,strong)UIImage * headerImage;
/**
 *  年龄
 */
@property(nonatomic,copy)NSString * age;
/**
 *  性别
 */
@property(nonatomic,copy)NSString * sex;
/**
 *  工作类型
 */
@property(nonatomic,assign)OfficeType officeType;

+(FEUser*)shareDataModle;


@end
