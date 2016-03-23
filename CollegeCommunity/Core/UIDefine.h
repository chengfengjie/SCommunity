//
//  UIDefine.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/14.
//  Copyright © 2016年 chengfj. All rights reserved.
//

//UIColor Define
#define COLOR_RGBA(_R,_G,_B,_A) [UIColor colorWithRed:_R/255.0f green:_G/255.0f blue:_B/255.0f alpha:_A]
#define COLOR_HEX(_HEX)         [UIColor colorWithHex:_HEX]
#define COLOR_HEXA(_HEX,_A)     [UIColor colorWithHex:_HEX alpha:_A]
#define TEXT_COLOR3             [UIColor colorWithHex:0x333333]
#define TEXT_COLOR6             [UIColor colorWithHex:0x666666]
#define TEXT_COLOR9             [UIColor colorWithHex:0x999999]

//UIFont
#define FONT(_SIZE)             [UIFont systemFontOfSize:_SIZE]

//Device Size
#define SCREN_width             [[UIScreen mainScreen] bounds].size.width
