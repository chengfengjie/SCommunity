//
//  CoreMethod.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/14.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoreMethod : NSObject
@end

@interface UIColor (Structure)

/*!
 *  @author chengfj, 16-03-25 18:03:24
 *
 *  @brief 通过十六进制生成颜色
 *  @param hexColor 颜色十六进制数 例如 : 0x000000
 *  @return 返回颜色
 *  @since 1.0
 */
+ (UIColor * _Nonnull)colorWithHex:(long)hexColor;
+ (UIColor * _Nonnull)colorWithHex:(long)hexColor alpha:(float)opacity;
@end

@interface NSString (Valid)
- (BOOL)isPhoneNumber;
@end

@interface NSError (Structure)
+ (NSError * _Nonnull)errorWithMsg:( NSString * _Nonnull )msg;
@end

@interface NSData (Encrypy)

@end