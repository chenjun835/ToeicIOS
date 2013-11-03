//
//  TCOptionRoundButton.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCOptionRoundButton.h"
#import "TCDefines.h"

@interface TCOptionRoundButton ()

@property (assign, nonatomic) BOOL isSelected;

@end

@implementation TCOptionRoundButton

- (id)initWithMark:(NSString *)mark
{
    self = [super initWithFrame:CGRectMake(0, 0, 2*kOptionButtonRoundRadius, 2*kOptionButtonRoundRadius)];
    if (self) {
        _isSelected = NO;
        self.backgroundColor = [UIColor lightGrayColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.f]];
        self.layer.cornerRadius = kOptionButtonRoundRadius;
        [self setTitle:mark forState:UIControlStateNormal];
    }
    return self;
}

- (void)changeState {
    _isSelected = !_isSelected;
    if (_isSelected) {
        self.backgroundColor = [UIColor greenColor];
    }
    else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

@end
