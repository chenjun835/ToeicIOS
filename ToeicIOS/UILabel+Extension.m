//
//  UILabel+Extension.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)questionBodyLabel {
    UILabel *label = [UILabel autolayoutLabel];
    label.numberOfLines = 0;
    label.textColor = [UIColor darkTextColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

+ (UILabel *)questionOptionLabel {
    UILabel *label = [UILabel autolayoutLabel];
    label.numberOfLines = 0;
    label.textColor = [UIColor darkTextColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

+ (UILabel *)bannerDescLabel {
    UILabel *label = [UILabel autolayoutLabel];
    label.numberOfLines = 1;
    label.textColor = [UIColor darkTextColor];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

+ (UILabel *)highlightLabel {
    UILabel *label = [UILabel autolayoutLabel];
    label.numberOfLines = 1;
    label.textColor = [UIColor blueColor];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

#pragma mark - Private methods

+ (UILabel *)autolayoutLabel {
    UILabel *label = UILabel.new;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    return label;
}
@end
