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
    UILabel *label = UILabel.new;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.numberOfLines = 0;
    label.textColor = [UIColor darkTextColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
    
}

+ (UILabel *)questionOptionLabel {
    UILabel *label = UILabel.new;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.numberOfLines = 0;
    label.textColor = [UIColor darkTextColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

@end
