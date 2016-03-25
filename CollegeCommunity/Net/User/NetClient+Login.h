//
//  NetClient+Login.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (Login)

/*!
 *  @author chengfj, 16-03-25 18:03:43
 *
 *  @brief 手机号码登录
 *  @param phone    手机号码
 *  @param password 密码
 *  @param success  成功回调
 *  @param failure  失败回调
 *  @since 1.0
 */
+ (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
               success:(Success)success
               failure:(Failure)failure;

@end
