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
+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (UIColor *)lineColor;
+ (UIColor *)buttonBackgroundColor;
@end
