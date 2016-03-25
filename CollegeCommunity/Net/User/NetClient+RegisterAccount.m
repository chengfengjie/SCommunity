//
//  NetClient+RegisterAccount.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "NetClient+RegisterAccount.h"

@implementation NetClient (RegisterAccount)
+ (void)registerAccountWithPhone:(NSString *)phone password:(NSString *)passwor success:(Success)success failure:(Failure)failure {
    [self postMethod:@"User/registerUser" paramars:@{@"phone":phone,@"password":passwor} success:success failure:failure];
}

+ (void)phoneExist:(NSString *)phone success:(Success)success failure:(Failure)failure {
    [self postMethod:@"User/phoneExist" paramars:@{@"phone":phone} success:success failure:failure];
}

@end
