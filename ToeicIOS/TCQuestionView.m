//
//  TCQuestionView.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestionView.h"
#import "UILabel+Extension.h"
#import "TCDefines.h"
#import <UIView-Autolayout/UIView+AutoLayout.h>

@interface TCQuestionView ()

@property (strong, nonatomic) UILabel *questionBodyLabel;
@property (strong, nonatomic) UILabel *optionLabelA;
@property (strong, nonatomic) UILabel *optionLabelB;
@property (strong, nonatomic) UILabel *optionLabelC;
@property (strong, nonatomic) UILabel *optionLabelD;

@end

@implementation TCQuestionView

- (id)initWithQuestion:(TCQuestion *)question {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        _questionBodyLabel = [UILabel questionBodyLabel];
        _optionLabelA = [UILabel questionOptionLabel];
        _optionLabelB = [UILabel questionOptionLabel];
        _optionLabelC = [UILabel questionOptionLabel];
        _optionLabelD = [UILabel questionOptionLabel];
        
        _questionBodyLabel.text = question.questionBody;
        _optionLabelA.text = question.optionA;
        _optionLabelB.text = question.optionB;
        _optionLabelC.text = question.optionC;
        _optionLabelD.text = question.optionD;
        
        [self addSubview:_questionBodyLabel];
        [self addSubview:_optionLabelA];
        [self addSubview:_optionLabelB];
        [self addSubview:_optionLabelC];
        [self addSubview:_optionLabelD];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_questionBodyLabel, _optionLabelA, _optionLabelB, _optionLabelC, _optionLabelD);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"V:|-padding-[_questionBodyLabel]-padding-[_optionLabelA]-padding-[_optionLabelB]-padding-[_optionLabelC]-padding-[_optionLabelD]-(>=padding)-|";
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                                                     metrics:metrics
                                                                       views:views]];
        
        visualFormat = @"|-padding-[_questionBodyLabel]-padding-|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
        
//        [_questionBodyLabel pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinTopEdge|JRTViewPinRightEdge inset:kPadding];
//        [_questionBodyLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.top).offset(kPadding);
//            make.left.equalTo(self.left).offset(kPadding);
//            make.right.equalTo(self.right).offset(-kPadding);
//        }];
//        
//        NSArray *optionLabels = @[_optionLabelB, _optionLabelC, _optionLabelD];
//        
//        [_optionLabelA makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_questionBodyLabel.bottom).offset(kMargin);
//            make.left.equalTo(_questionBodyLabel.left).offset(kMargin);
//            make.right.equalTo(_questionBodyLabel.right).offset(-kMargin);
//           // make.left.equalTo(optionLabels);
//           // make.right.equalTo(optionLabels);
//        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // for multiline UILabel's you need set the preferredMaxLayoutWidth
    // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point
    
    // stay tuned for new easier way todo this coming soon to Masonry
    
    _questionBodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(_questionBodyLabel.frame);
    _optionLabelA.preferredMaxLayoutWidth = CGRectGetWidth(_optionLabelA.frame);
    _optionLabelB.preferredMaxLayoutWidth = CGRectGetWidth(_optionLabelB.frame);
    _optionLabelC.preferredMaxLayoutWidth = CGRectGetWidth(_optionLabelC.frame);
    _optionLabelD.preferredMaxLayoutWidth = CGRectGetWidth(_optionLabelD.frame);
    
    // need to layoutSubviews again as frames need to recalculated with preferredLayoutWidth
    [super layoutSubviews];
}
@end
