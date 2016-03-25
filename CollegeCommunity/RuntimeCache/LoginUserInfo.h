//
//  LoginUserInfo.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUserInfo : NSObject
@property (nonatomic,assign,getter=isLogin) BOOL login;
+ (instancetype)currentUser;
@end
