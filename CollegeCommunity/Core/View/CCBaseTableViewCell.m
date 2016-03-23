//
//  CCBaseTableViewCell.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "CCBaseTableViewCell.h"

@interface CCBaseTableViewCell () {
    UIView * bottomLine;
    UIView * topLine;
    NSMutableArray * bottomContraints;
    NSMutableArray * topContraints;
}

@end

@implementation CCBaseTableViewCell

- (void)bringLine {
    [self bringSubviewToFront:bottomLine];
    [self bringSubviewToFront:topLine];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        bottomContraints = [NSMutableArray array];
        topContraints = [NSMutableArray array];
        [self.layer setMasksToBounds:YES];
    }
    return self;
}

- (void)setBottomLineColor:(UIColor *)color height:(CGFloat)heiht {
    if (bottomLine == nil) {
        bottomLine = [[UIView alloc] init];
        [bottomLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:bottomLine];
    }
    [bottomLine setBackgroundColor:color];
    [self removeConstraints:bottomContraints];
    [bottomContraints removeAllObjects];
    [bottomContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLine]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomLine)]];
    [bottomContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[bottomLine(==%f)]-0-|",heiht] options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomLine)]];
    [self addConstraints:bottomContraints];
}

- (void)setTopLineColor:(UIColor *)color height:(CGFloat)height {
    if (topLine == nil) {
        topLine = [[UIView alloc] init];
        [topLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:topLine];
    }
    [topLine setBackgroundColor:color];
    [self removeConstraints:topContraints];
    [topContraints removeAllObjects];
    [topContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topLine]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLine)]];
    [topContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[topLine(==%f)]",height] options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLine)]];
    [self addConstraints:topContraints];
    
}

- (void)setBottomLineColor:(UIColor *)color height:(CGFloat)heiht leftSpace:(CGFloat)leftSpace {
    if (bottomLine == nil) {
        bottomLine = [[UIView alloc] init];
        [bottomLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:bottomLine];
    }
    [bottomLine setBackgroundColor:color];
    [self removeConstraints:bottomContraints];
    [bottomContraints removeAllObjects];
    [bottomContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[bottomLine]-0-|",leftSpace] options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomLine)]];
    [bottomContraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[bottomLine(==%f)]-0-|",heiht] options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomLine)]];
    [self addConstraints:bottomContraints];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
