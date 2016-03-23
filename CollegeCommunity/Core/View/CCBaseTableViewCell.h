//
//  CCBaseTableViewCell.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBaseTableViewCell : UITableViewCell
@property (nonatomic,strong) NSIndexPath * indexPath;
- (void)setBottomLineColor:(UIColor *)color height:(CGFloat)heiht;
- (void)setTopLineColor:(UIColor *)color height:(CGFloat)height;
- (void)setBottomLineColor:(UIColor *)color height:(CGFloat)heiht leftSpace:(CGFloat)leftSpace;
@end


