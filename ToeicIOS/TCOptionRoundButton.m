//
//  TCOptionRoundButton.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCOptionRoundButton.h"
#import "TCDefines.h"
#import "UIView+AutoLayout.h"

@implementation TCOptionRoundButton

- (id)initWithMark:(NSString *)mark
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self constrainToSize:CGSizeMake(2*kOptionButtonRoundRadius, 2*kOptionButtonRoundRadius)];
        self.isSelected = NO;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.f]];
        self.layer.cornerRadius = kOptionButtonRoundRadius;
        [self setTitle:mark forState:UIControlStateNormal];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.backgroundColor = [UIColor greenColor];
    }
    else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)changeState {
    self.isSelected = !self.isSelected;
}

@end
