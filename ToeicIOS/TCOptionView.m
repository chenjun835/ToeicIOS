//
//  TCOptionView.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCOptionView.h"
#import "TCDefines.h"
#import "UILabel+Extension.h"
#import "UIButton+Extension.h"

@implementation TCOptionView

- (id)initWithMark:(NSString *)optionMark optionBody:(NSString *)optionBody {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIButton *markButton = [UIButton optionRoundButton];
        [markButton setTitle:optionMark forState:UIControlStateNormal];
        [markButton addTarget:self action:@selector(markButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *bodyLabel = [UILabel questionOptionLabel];
        bodyLabel.text = optionBody;
        
        [self addSubview:markButton];
        [self addSubview:bodyLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(markButton, bodyLabel);
        NSDictionary *metrics = @{@"margin": @kMargin};
        NSString *visualFormat = @"|[markButton]-margin-[bodyLabel]|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllTop
                                                                     metrics:metrics
                                                                       views:views]];
        visualFormat = @"V:|[bodyLabel]|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
    }
    return self;
}

#pragma mark - Private methods

- (void)markButtonTapped:(id)sender {
    UIButton *optionButton = (UIButton *)sender;
    [optionButton changeOptionRoundButtonState];
}

@end