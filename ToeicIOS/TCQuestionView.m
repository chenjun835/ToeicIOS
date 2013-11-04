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

@interface TCQuestionView () <TCOptionViewDelegate>

@property (strong, nonatomic) TCQuestion *question;
@property (strong, nonatomic) UIView *questionContentView;
@property (strong, nonatomic) UILabel *questionBodyLabel;
@property (strong, nonatomic) NSString *selectedMark;
@property (strong, nonatomic) TCOptionView *optionA;
@property (strong, nonatomic) TCOptionView *optionB;
@property (strong, nonatomic) TCOptionView *optionC;
@property (strong, nonatomic) TCOptionView *optionD;

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
        [bannerView pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
        [bannerView constrainToWidth:kScreenWidth];
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
    
    _optionA = [[TCOptionView alloc] initWithMark:kOptionMarkA optionBody:_question.optionA];
    _optionB = [[TCOptionView alloc] initWithMark:kOptionMarkB optionBody:_question.optionB];
    _optionC = [[TCOptionView alloc] initWithMark:kOptionMarkC optionBody:_question.optionC];
    _optionD = [[TCOptionView alloc] initWithMark:kOptionMarkD optionBody:_question.optionD];
    
    _optionA.delegate = self;
    _optionB.delegate = self;
    _optionC.delegate = self;
    _optionD.delegate = self;
    
    [self addSubview:_questionContentView];
    [_questionContentView addSubview:_questionBodyLabel];
    [_questionContentView addSubview:line];
    [_questionContentView addSubview:_optionA];
    [_questionContentView addSubview:_optionB];
    [_questionContentView addSubview:_optionC];
    [_questionContentView addSubview:_optionD];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_questionBodyLabel, line, _optionA, _optionB, _optionC, _optionD);
    NSDictionary *metrics = @{@"padding": @kPadding};
    NSString *visualFormat = @"V:|-padding-[_questionBodyLabel]-padding-[line]-padding-[_optionA]-padding-[_optionB]-padding-[_optionC]-padding-[_optionD]-(>=padding)-|";
    
    [_questionContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                                 options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                                                                 metrics:metrics
                                                                                   views:views]];
    
    [_questionBodyLabel pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge inset:kPadding];
}

#pragma mark - TCOptionViewDelegate 

- (void)mark:(NSString *)mark changeToState:(BOOL)isSelected {
    if (!isSelected) {
        _selectedMark = nil;
        _question.userAnswer = nil;
    }
    else {
        if ([_selectedMark isEqualToString:kOptionMarkA]) {
            [_optionA unSelect];
        }
        else if ([_selectedMark isEqualToString:kOptionMarkB]) {
            [_optionB unSelect];
        }
        else if ([_selectedMark isEqualToString:kOptionMarkC]) {
            [_optionC unSelect];
        }
        else if ([_selectedMark isEqualToString:kOptionMarkD]) {
            [_optionD unSelect];
        }
        _selectedMark = mark;
        _question.userAnswer = mark;
    }
}

@end
