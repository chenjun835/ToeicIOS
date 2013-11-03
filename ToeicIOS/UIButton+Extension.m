//
//  UIButton+Extension.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "UIButton+Extension.h"
#import <QuartzCore/QuartzCore.h>
#import "TCDefines.h"

@implementation UIButton (Extension)

+ (UIButton *)defaultButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor lightGrayColor];
    button.layer.cornerRadius = 4;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:13.f]];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    return button;
}

@end
