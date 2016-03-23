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
+ (UIColor *)lineColor {
    return COLOR_HEXA(0xe9e9e9, 0.95);
}
+ (UIColor *)buttonBackgroundColor {
    return COLOR_HEXA(0x1ac7ee, 0.95);
}
@end