//
//  LoginUserInfo.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "LoginUserInfo.h"

@implementation LoginUserInfo
+ (instancetype)currentUser {
    static LoginUserInfo * userinfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userinfo = [[LoginUserInfo alloc] init];
    });
    return userinfo;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
