//
//  RWConsultHistory+CoreDataProperties.h
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RWConsultHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface RWConsultHistory (CoreDataProperties)

@property (nullable, nonatomic, retain)NSData *header;
@property (nullable, nonatomic, retain)NSString *nickName;
@property (nullable, nonatomic, retain)NSString *emid;
@property (nullable, nonatomic, retain)NSString *umid;

@end

NS_ASSUME_NONNULL_END
