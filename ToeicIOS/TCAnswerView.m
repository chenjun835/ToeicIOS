//
//  TCAnswerView.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/04.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCAnswerView.h"
#import "UILabel+Extension.h"
#import "TCOptionRoundButton.h"
#import "TCDefines.h"
#import "UIView+AutoLayout.h"

@interface TCAnswerView ()

@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnA;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnB;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnC;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnD;

@end

@implementation TCAnswerView

- (id)initWithQuestion:(TCQuestion *)question num:(int)num {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _numLabel = [UILabel defaultLabel];
        _numLabel.text = [NSString stringWithFormat:@"%d", num];
        
        _optionBtnA = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkA];
        _optionBtnB = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkB];
        _optionBtnC = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkC];
        _optionBtnD = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkD];
        
        [self addSubview:_numLabel];
        [self addSubview:_optionBtnA];
        [self addSubview:_optionBtnB];
        [self addSubview:_optionBtnC];
        [self addSubview:_optionBtnD];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_numLabel, _optionBtnA, _optionBtnB, _optionBtnC, _optionBtnD);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"[_numLabel]-30-[_optionBtnA]-padding-[_optionBtnB]-padding-[_optionBtnC]-padding-[_optionBtnD]-130-|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:metrics
                                                                       views:views]];
        [_numLabel pinToSuperviewEdges:JRTViewPinTopEdge|JRTViewPinBottomEdge inset:3];
        
        [self transformWithQuestion:question];
    }
    return self;
}

- (void)transformWithQuestion:(TCQuestion *)question {
    [self unselectAll];
    if ([question.userAnswer isEqualToString:kOptionMarkA]) {
        _optionBtnA.isSelected = YES;
    }
    else if ([question.userAnswer isEqualToString:kOptionMarkB]) {
        _optionBtnB.isSelected = YES;
    }
    else if ([question.userAnswer isEqualToString:kOptionMarkC]) {
        _optionBtnC.isSelected = YES;
    }
    else if ([question.userAnswer isEqualToString:kOptionMarkD]) {
        _optionBtnD.isSelected = YES;
    }
}

#pragma mark - Private methods

- (void)unselectAll {
    _optionBtnA.isSelected = NO;
    _optionBtnB.isSelected = NO;
    _optionBtnC.isSelected = NO;
    _optionBtnD.isSelected = NO;
}

@end
