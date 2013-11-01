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

+ (UIButton *)optionRoundButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:13.f]];
    button.frame = CGRectMake(0, 0, 2*kOptionButtonRoundRadius, 2*kOptionButtonRoundRadius);
    button.layer.cornerRadius = kOptionButtonRoundRadius;
    return button;
}

- (void)changeOptionRoundButtonState {
    if (self.backgroundColor == [UIColor lightGrayColor]) {
        self.backgroundColor = [UIColor greenColor];
    }
    else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

@end
