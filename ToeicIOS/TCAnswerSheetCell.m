//
//  TCAnswerSheetCell.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCAnswerSheetCell.h"
#import "TCOptionRoundButton.h"
#import "UILabel+Extension.h"
#import "TCDefines.h"
#import "UIView+AutoLayout.h"

@interface TCAnswerSheetCell ()

@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnA;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnB;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnC;
@property (strong, nonatomic) TCOptionRoundButton *optionBtnD;

@end

@implementation TCAnswerSheetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _numLabel = [UILabel defaultLabel];
        
        _optionBtnA = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkA];
        _optionBtnB = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkB];
        _optionBtnC = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkC];
        _optionBtnD = [[TCOptionRoundButton alloc] initWithMark:kOptionMarkD];
        
        [self.contentView addSubview:_numLabel];
        [self.contentView addSubview:_optionBtnA];
        [self.contentView addSubview:_optionBtnB];
        [self.contentView addSubview:_optionBtnC];
        [self.contentView addSubview:_optionBtnD];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_numLabel, _optionBtnA, _optionBtnB, _optionBtnC, _optionBtnD);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"|-padding-[_numLabel]-padding-[_optionBtnA]-padding-[_optionBtnB]-padding-[_optionBtnC]-padding-[_optionBtnD]";
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                                 metrics:metrics
                                                                                   views:views]];
        [_numLabel pinToSuperviewEdges:JRTViewPinTopEdge inset:kPadding];
    }
    return self;
}

- (void)transformWithQuestion:(TCQuestion *)question num:(int)num {
    _numLabel.text = [NSString stringWithFormat:@"%d", num];
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
