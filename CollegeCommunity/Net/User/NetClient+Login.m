//
//  NetClient+Login.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "NetClient+Login.h"

@implementation NetClient (Login)
+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self postMethod:@"User/login" paramars:@{@"phone":phone,@"password":password} success:success failure:failure];
}
@end
