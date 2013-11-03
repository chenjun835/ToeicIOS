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
#import "TCOptionRoundButton.h"

@interface TCOptionView ()

@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) TCOptionRoundButton *markButton;
@property (strong, nonatomic) NSString *mark;

@end

@implementation TCOptionView

- (id)initWithMark:(NSString *)mark optionBody:(NSString *)optionBody {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        _isSelected = NO;
        _mark = mark;
        
        _markButton = [[TCOptionRoundButton alloc] initWithMark:mark];
        [_markButton addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *bodyLabel = [UILabel questionOptionLabel];
        bodyLabel.text = optionBody;
        
        [self addSubview:_markButton];
        [self addSubview:bodyLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_markButton, bodyLabel);
        NSDictionary *metrics = @{@"margin": @kMargin};
        NSString *visualFormat = @"|[_markButton]-margin-[bodyLabel]|";
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

- (void)unSelect {
    if (_isSelected) {
        [self changeState];
    }
}

#pragma mark - Private methods

- (void)changeState {
    [_markButton changeState];
    _isSelected = !_isSelected;
    if ([_delegate respondsToSelector:@selector(mark:changeToState:)]) {
        [_delegate mark:_mark changeToState:_isSelected];
    }
}



@end
