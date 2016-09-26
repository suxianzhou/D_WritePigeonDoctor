//
//  RWAddressForm+CoreDataProperties.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/2.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RWAddressForm.h"

NS_ASSUME_NONNULL_BEGIN

@interface RWAddressForm (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *defaultAddress;
@property (nullable, nonatomic, retain) NSString *province;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *telephone;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSDate *builddate;

@end

NS_ASSUME_NONNULL_END
