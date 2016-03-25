//
//  CoreMethod.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/14.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "CoreMethod.h"
#import "UIDefine.h"

@implementation CoreMethod
@end

@implementation UIColor (Structure)
+ (UIColor*)colorWithHex:(long)hexColor {
    return [UIColor colorWithHex:hexColor alpha:1.];
}
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
@end

@implementation NSString (Valid)

- (BOOL)isPhoneNumber {
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9])\\d{8}$";
    NSString * MOBILE = @"^[1][34578]\\d{9}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString * PHS=@"^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];//China Mobile
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];//China Unicom
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];//China Telecom
    NSPredicate * regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];//PHS
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)
        ||([regextestphs evaluateWithObject:self] == YES))
    {
        return YES;
    }
    return NO;
}

@end

@implementation NSError (Structure)

+ (NSError *)errorWithMsg:( NSString * _Nonnull )msg {
    return [NSError errorWithDomain:@"" code:1000 userInfo:@{@"msg":msg}];
}

@end