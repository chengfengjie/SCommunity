//
//  AppNotification.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/25.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @author chengfj, 16-03-25 18:03:29
 *
 *  @brief 登录成功的通知，当用户登录成功，发出此通知,Appdelegate接收通知，将根控制器切换至主界面 MainViewController
 *  @since 1.0
 */
extern NSString * kCCLoginSuccessNotification;

/*!
 *  @author chengfj, 16-03-25 18:03:02
 *
 *  @brief 退出登录通知,当用户退出登录，发出通知，切换至登录控制器
 *  @since 1.0
 */
extern NSString * kCCLogoutSuccessNotification;

@interface AppNotification : NSObject

@end
