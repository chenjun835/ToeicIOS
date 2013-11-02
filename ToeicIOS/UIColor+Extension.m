//
//  UIColor+Extension.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/02.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorFromRGB:(NSUInteger)rgbValue alpha:(CGFloat)alpha {
    CGFloat red = ((rgbValue & 0xff0000) >> 16) / 255.0;
    CGFloat green = ((rgbValue & 0xff00) >> 8) / 255.0;
    CGFloat blue = (rgbValue & 0xff) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
