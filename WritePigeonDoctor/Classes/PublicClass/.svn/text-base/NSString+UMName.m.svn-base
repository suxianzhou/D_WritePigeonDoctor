//
//  NSString+UMName.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/9/21.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "NSString+UMName.h"

#define HEX (long long)62

long long ascii_value_62(unichar c)
{
    if (c >= '0' && c <= '9')
    {
        return (long long)c - 48;
    }
    else if (c >= 'a' && c <= 'z')
    {
        return (long long)c - 87;
    }
    else if (c >= 'A' && c <= 'Z')
    {
        return (long long)c - 29;
    }
    
    return 63;
}

NSString *transform_10To62(long long number)
{
    long long tempNumber = number;
    
    long long buff[100];
    int digit = 0;
    long long tempItem = 0;
    long long tempResult;
    char hex[62] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};

    while(tempNumber > 0)
    {
        tempResult = tempNumber % HEX;
        buff[digit++] = tempResult;
        tempNumber /= HEX;
    }
    
    NSMutableString *number_62 = [[NSMutableString alloc] init];
    
    for(int i = digit - 1 ; i >= 0 ; i--)
    { 
        tempItem = buff[i];
        [number_62 appendFormat:@"%c",hex[tempItem]];
    }
    
    return [number_62 copy];
}

NSString *transform_62To10(NSString *number)
{
    NSString *tempNumber = [number copy];
    long long result = 0;
    int position = 1;
    
    int lenght = (int)tempNumber.length - 1;
    
    for (int i = lenght; i >= 0; i--)
    {
        unichar c = [tempNumber characterAtIndex:i];
        long long value = ascii_value_62(c);
        if (value == 63) return nil;
        result += value * position;
        position *= HEX;
    }
    
    return [NSString stringWithFormat:@"%lld",result];
}

@implementation NSString (UMName)

- (instancetype)umNameWithID:(NSString *)ID
{
    NSString *ID_62 = transform_10To62((long long)ID.longLongValue);
    
    return [NSString stringWithFormat:@"%@%@",self,ID_62];
}

- (instancetype)umName
{
    return self.length > 6?[self substringToIndex:self.length - 6]:nil;
}

- (instancetype)defaultUMName
{
    NSString *begin = [self substringToIndex:3];
    NSString *end = [self substringFromIndex:7];
    NSString *ID_62 = transform_10To62((long long)self.longLongValue);
    
    return [NSString stringWithFormat:@"%@xx%@%@",begin,end,ID_62];
}

@end
