//
//  TCDefines.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "UIColor+Extension.h"

// shortcut
#define UIColorFromRGB(rgbValue) [UIColor colorFromRGB:rgbValue alpha:1.0]
#define UIFontOfSize(size)       [UIFont systemFontOfSize:size]
#define UIBoldFontOfSize(size)   [UIFont boldSystemFontOfSize:size]
#define UIImageWithName(name)    [UIImage imageNamed:name]

// Parse
#define kParseApplicationId @"teKBUtsKIayWc3H9OYv77SIHSujiPZZQNRluCF6w"
#define kParseClientKey     @"TQYBAAEEqnuuuTJhOd46oXeFuErQGKhkrhpWbkAl" 

// Model
#define kDefaultListLimit 10

// Color
#define kBackgroundColor       UIColorFromRGB(0xF3F3F3)
#define kBannerBackgroundColor UIColorFromRGB(0xEEEEEE)

// View
#define kDefaultNavigationBarHeight 64.f //set by Apple

#define kMargin  15.f
#define kPadding 15.f
#define kOptionButtonRoundRadius 9.f

#define kOptionMarkA @"A"
#define kOptionMarkB @"B"
#define kOptionMarkC @"C"
#define kOptionMarkD @"D"
