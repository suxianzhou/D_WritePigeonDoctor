//
//  RWDataModels.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/7/27.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWDataModels.h"
#import "XZUMComPullRequest.h"
#import "UMComUser.h"
#import "UMComMacroConfig.h"
#import "UMComImageUrl.h"

@implementation RWOfficeItem @end

@implementation RWUserItem

- (void)setEMID:(NSString *)EMID
{
    _EMID = EMID;
    
    if (_EMID && _UMID && !_header)
    {
        [self requestInformation];
    }
}

- (void)setUMID:(NSString *)UMID
{
    _UMID = UMID;
    
    if (_EMID && _UMID && !_header)
    {
        [self requestInformation];
    }
}

- (void)requestInformation
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        [XZUMComPullRequest fecthUserMessageWithUid:_UMID source:nil source_uid:_EMID completion:^(NSDictionary *responseObject, NSError *error)
         {
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 
                 UMComUser *umuser = responseObject[UMComModelDataKey];
                 
                 _nickName = umuser.name;
                 
                 if (umuser.icon_url)
                 {
                     UMComImageUrl * imageUrl = umuser.icon_url;
                     NSString * small = imageUrl.small_url_string;
                     
                     _header = small;
                     
                     _relation = umuser.has_followed.integerValue;
                 }
                 
                 send_notification(RWHeaderMessageToObserve,nil);
             }];
         }];
    }];
    
    operation.name = HeaderOperation;
    
    [[RWChatManager defaultManager].downLoadQueue addOperation:operation];
}


@end

@implementation RWWeekHomeVisit

+ (instancetype)visitWithDescription:(NSString *)description
{
    return [[[self class] alloc] initWithDescription:description];
}

- (instancetype)initWithDescription:(NSString *)description
{
    self = [super init];
    
    if (self)
    {
        if (description && description.length)
        {
            NSArray *cleanDes = [description componentsSeparatedByString:@"\\"];
            NSString *cleanStr = [cleanDes componentsJoinedByString:@""];
            NSRange contentRange = NSMakeRange(1, cleanStr.length - 2);
            NSString *content = [cleanStr substringWithRange:contentRange];
            
            NSArray *allObjs = [content componentsSeparatedByString:@"},"];
            
            for (NSString *keyValue in allObjs)
            {
                NSArray *objArr = [keyValue componentsSeparatedByString:@":"];
                
                if (objArr.count == 2)
                {
                    NSRange keyRange = NSMakeRange(1, [objArr[0] length] - 2);
                    NSString *key = [objArr[0] substringWithRange:keyRange];
                    
                    unichar firstc = [objArr[1] characterAtIndex:0];
                    unichar lastc =[objArr[1] characterAtIndex:[objArr[1] length] - 1];
                    
                    NSRange valueRange = NSMakeRange(1, [objArr[1] length] - 2);
                    NSString *value =   (firstc == '"' && lastc == '"')?
                    [objArr[1] substringWithRange:valueRange]:
                    objArr[1];
                    
                    
                    [self setValue:[RWHomeVisitItem itemWithDescription:value]
                            forKey:key];
                }
                else if (objArr.count > 2)
                {
                    NSMutableArray *copyObjArr = [objArr mutableCopy];
                    [copyObjArr removeFirstObject];
                    
                    NSString *objStr = [copyObjArr componentsJoinedByString:@":"];
                    
                    NSRange keyRange = NSMakeRange(1, [objArr[0] length] - 2);
                    NSString *key = [objArr[0] substringWithRange:keyRange];
                    
                    unichar firstc = [objStr characterAtIndex:0];
                    unichar lastc = [objStr characterAtIndex:objStr.length - 1];
                    
                    NSRange valueRange = NSMakeRange(1, objStr.length - 2);
                    NSString *value =   (firstc == '"' && lastc == '"')?
                    [objStr substringWithRange:valueRange]:
                    objStr;
                    
                    [self setValue:[RWHomeVisitItem itemWithDescription:value]
                            forKey:key];
                }
            }
        }
    }
    
    return self;
}

+ (instancetype)visitWithDictionary:(NSDictionary *)aDictionary
{
    return [[[self class] alloc] initWithDictionary:aDictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    
    if (self)
    {
        for (NSString *key in aDictionary.allKeys)
        {
            id obj = [aDictionary objectForKey:key];
            
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                RWHomeVisitItem *item = [RWHomeVisitItem itemWithDictionary:obj];
                
                [self setValue:item forKey:key];
            }
        }
    }
    
    return self;
}

- (NSString *)description
{
    NSArray *objects = [RWSettingsManager obtainAllObjectsAtClass:[self class]];
    
    NSMutableArray *objectDescriptions = [[NSMutableArray alloc] init];
    
    for (NSString *objName in objects)
    {
        id obj = [self valueForKey:objName];
        
        if (obj)
        {
            NSString *objDes = [NSString stringWithFormat:@"\"%@\":%@",objName,obj];
            [objectDescriptions addObject:objDes];
        }
    }
    
    if (objectDescriptions.count)
    {
        NSString *content = [objectDescriptions componentsJoinedByString:@"\\,"];
        
        return [NSString stringWithFormat:@"{%@}",content];
    }
    
    return @"";
}


@end

@implementation RWHomeVisitItem

+ (instancetype)itemWithDescription:(NSString *)description
{
    return [[[self class] alloc] initWithDescription:description];
}

- (instancetype)initWithDescription:(NSString *)description
{
    self = [super init];
    
    if (self)
    {
        if (description && description.length)
        {
            unichar lastc = [description characterAtIndex:description.length - 1];
            NSInteger endLen = lastc == '}'?2:1;
            NSRange contentRange = NSMakeRange(1, description.length - endLen);
            NSString *content = [description substringWithRange:contentRange];
            
            for (NSString *keyValue in [content componentsSeparatedByString:@","])
            {
                NSArray *objArr = [keyValue componentsSeparatedByString:@":"];
                
                if (objArr.count == 2)
                {
                    NSRange keyRange = NSMakeRange(1, [objArr[0] length] - 2);
                    NSString *key = [objArr[0] substringWithRange:keyRange];
                    
                    unichar firstc = [objArr[1] characterAtIndex:0];
                    unichar lastc =[objArr[1] characterAtIndex:[objArr[1] length] - 1];
                    
                    NSRange valueRange = NSMakeRange(1, [objArr[1] length] - 2);
                    NSString *value =   (firstc == '"' && lastc == '"')?
                    [objArr[1] substringWithRange:valueRange]:
                    objArr[1];
                    
                    [self setValue:value forKey:key];
                }
                
                else if (objArr.count > 2)
                {
                    NSMutableArray *copyObjArr = [objArr mutableCopy];
                    [copyObjArr removeFirstObject];
                    
                    NSString *objStr = [copyObjArr componentsJoinedByString:@":"];
                    
                    NSRange keyRange = NSMakeRange(1, [objArr[0] length] - 2);
                    NSString *key = [objArr[0] substringWithRange:keyRange];
                    
                    unichar firstc = [objStr characterAtIndex:0];
                    unichar lastc = [objStr characterAtIndex:objStr.length - 1];
                    
                    NSRange valueRange = NSMakeRange(1, objStr.length - 2);
                    NSString *value = (firstc == '"' && lastc == '"')?
                    [objStr substringWithRange:valueRange]:
                    objStr;
                    
                    [self setValue:value forKey:key];
                }
            }
        }
    }
    
    return self;
}

+ (instancetype)itemWithDictionary:(NSDictionary *)aDictionary
{
    return [[[self class] alloc] initWithDictionary:aDictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    
    if (self)
    {
        for (NSString *key in aDictionary.allKeys)
        {
            id obj = [aDictionary objectForKey:key];
            
            if ([obj isKindOfClass:[NSString class]])
            {
                [self setValue:obj forKey:key];
            }
        }
    }
    
    return self;
}

- (NSString *)description
{
    NSArray *objects = [RWSettingsManager obtainAllObjectsAtClass:[self class]];
    
    NSMutableArray *objectDescriptions = [[NSMutableArray alloc] init];
    
    for (NSString *objName in objects)
    {
        id obj = [self valueForKey:objName];
        
        if (obj)
        {
            NSString *objDes =[NSString stringWithFormat:@"\"%@\":\"%@\"",objName,obj];
            [objectDescriptions addObject:objDes];
        }
    }
    
    if (objectDescriptions.count)
    {
        NSString *content = [objectDescriptions componentsJoinedByString:@"\\,"];
        
        return [NSString stringWithFormat:@"{%@}",content];
    }
    
    return nil;
}

@end
