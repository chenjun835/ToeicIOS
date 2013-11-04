//
//  TCCategoryCell.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCCategoryCell.h"
#import "UILabel+Extension.h"
#import "UIButton+Extension.h"
#import "UIView+AutoLayout.h"
#include "TCDefines.h"

@interface TCCategoryCell ()

@property (strong, nonatomic) UILabel *categoryNameLabel;
@property (strong, nonatomic) UIButton *getQuestionButton;
@property (strong, nonatomic) TCCategory *category;

@end

@implementation TCCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _categoryNameLabel = [UILabel defaultLabel];
        _getQuestionButton = [UIButton defaultButton];
        [_getQuestionButton setTitle:NSLocalizedString(@"get 10 questions", nil) forState:UIControlStateNormal];
        [_getQuestionButton addTarget:self action:@selector(getQuestionButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_categoryNameLabel];
        [self.contentView addSubview:_getQuestionButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_categoryNameLabel, _getQuestionButton);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"|-padding-[_categoryNameLabel]-(>=0)-[_getQuestionButton]-padding-|";
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                                options:NSLayoutFormatAlignAllCenterY
                                                                                metrics:metrics
                                                                                  views:views]];
        [_categoryNameLabel pinToSuperviewEdges:JRTViewPinTopEdge inset:kPadding];
    }
    return self;
}

- (void)transformWithCategory:(TCCategory *)category {
    _category = category;
    _categoryNameLabel.text = category.name;
}

- (void)getQuestionButtonTapped {
    if ([_delegate respondsToSelector:@selector(fetchQuestionsWithCategory:)]) {
        [_delegate fetchQuestionsWithCategory:_category];
    }
}

@end
