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
#import "TCQuestionBannerView.h"
#import "TCOptionView.h"
#import "UIView+AutoLayout.h"

@interface TCQuestionView ()

@property (strong, nonatomic) TCQuestion *question;
@property (strong, nonatomic) UIView *questionContentView;
@property (strong, nonatomic) UILabel *questionBodyLabel;

@end

@implementation TCQuestionView

- (id)initWithQuestion:(TCQuestion *)question num:(int)num total:(int)total {
    self = [super init];
    if (self) {
        _question = question;
        
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        TCQuestionBannerView *bannerView = [[TCQuestionBannerView alloc] initWithDesc:question.category.categoryName
                                                                          currentPage:num
                                                                            totalPage:total];
        [self addSubview:bannerView];
        
        [self initQuestionContentView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(bannerView, _questionContentView);
        NSString *visualFormat = @"V:|[bannerView][_questionContentView]|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                                                     metrics:nil
                                                                       views:views]];
        [bannerView pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge inset:0];
    }
    return self;
}

- (void)initQuestionContentView {
    _questionContentView = [UIView autoLayoutView];
    
    _questionBodyLabel = [UILabel questionBodyLabel];
    _questionBodyLabel.text = _question.questionBody;
    
    UIImageView *line = [[UIImageView alloc] init];
    [line setTranslatesAutoresizingMaskIntoConstraints:NO];
    line.backgroundColor = [UIColor lightGrayColor];
    [line constrainToHeight:0.5f];
    
    TCOptionView *optionA = [[TCOptionView alloc] initWithMark:kOptionMarkA optionBody:_question.optionA];
    TCOptionView *optionB = [[TCOptionView alloc] initWithMark:kOptionMarkB optionBody:_question.optionB];
    TCOptionView *optionC = [[TCOptionView alloc] initWithMark:kOptionMarkC optionBody:_question.optionC];
    TCOptionView *optionD = [[TCOptionView alloc] initWithMark:kOptionMarkD optionBody:_question.optionD];
    
    [self addSubview:_questionContentView];
    [_questionContentView addSubview:_questionBodyLabel];
    [_questionContentView addSubview:line];
    [_questionContentView addSubview:optionA];
    [_questionContentView addSubview:optionB];
    [_questionContentView addSubview:optionC];
    [_questionContentView addSubview:optionD];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_questionBodyLabel, line, optionA, optionB, optionC, optionD);
    NSDictionary *metrics = @{@"padding": @kPadding};
    NSString *visualFormat = @"V:|-padding-[_questionBodyLabel]-padding-[line]-padding-[optionA]-padding-[optionB]-padding-[optionC]-padding-[optionD]-(>=padding)-|";
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                 options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                                                 metrics:metrics
                                                                   views:views]];
    [_questionBodyLabel pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge inset:kPadding];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _questionBodyLabel.preferredMaxLayoutWidth = _questionBodyLabel.frame.size.width;
    [super layoutSubviews];
}
@end
