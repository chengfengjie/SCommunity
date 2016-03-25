//
//  NetClient+RegisterAccount.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "NetClient.h"

@interface NetClient (RegisterAccount)

/*!
 *  @author chengfj, 16-03-25 17:03:20
 *
 *  @brief 手机号码注册账号
 *  @param phone   手机号码
 *  @param passwor 密码
 *  @param success 成功回调代码块
 *  @param failure 失败回调代码块
 *  @since 1.0
 */
+ (void)registerAccountWithPhone:(NSString *)phone
                        password:(NSString *)passwor
                         success:(Success)success
                         failure:(Failure)failure;

/*!
 *  @author chengfj, 16-03-25 17:03:54
 *
 *  @brief 检测手机是否注册
 *  @param phone   手机号码
 *  @param success 成功代码块
 *  @param failure 失败代码块
 *  @since 1.0
 */
+ (void)phoneExist:(NSString *)phone
           success:(Success)success
           failure:(Failure)failure;
@end

