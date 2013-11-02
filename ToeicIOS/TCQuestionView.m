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
#import "TCOptionView.h"
#import "UIView+AutoLayout.h"

@implementation TCQuestionView

- (id)initWithQuestion:(TCQuestion *)question {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UILabel *questionBodyLabel = [UILabel questionBodyLabel];
        questionBodyLabel.text = question.questionBody;
        questionBodyLabel.preferredMaxLayoutWidth = 290;
        
        UIImageView *line = [[UIImageView alloc] init];
        [line setTranslatesAutoresizingMaskIntoConstraints:NO];
        line.backgroundColor = [UIColor lightGrayColor];
        [line constrainToHeight:0.5f];
        
        TCOptionView *optionA = [[TCOptionView alloc] initWithMark:kOptionMarkA optionBody:question.optionA];
        TCOptionView *optionB = [[TCOptionView alloc] initWithMark:kOptionMarkB optionBody:question.optionB];
        TCOptionView *optionC = [[TCOptionView alloc] initWithMark:kOptionMarkC optionBody:question.optionC];
        TCOptionView *optionD = [[TCOptionView alloc] initWithMark:kOptionMarkD optionBody:question.optionD];
        
        [self addSubview:questionBodyLabel];
        [self addSubview:line];
        [self addSubview:optionA];
        [self addSubview:optionB];
        [self addSubview:optionC];
        [self addSubview:optionD];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(questionBodyLabel, line, optionA, optionB, optionC, optionD);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"V:|-padding-[questionBodyLabel]-padding-[line]-padding-[optionA]-padding-[optionB]-padding-[optionC]-padding-[optionD]-(>=padding)-|";
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                                                     metrics:metrics
                                                                       views:views]];
        
        visualFormat = @"|-padding-[questionBodyLabel]-padding-|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    }
    return self;
}

@end
