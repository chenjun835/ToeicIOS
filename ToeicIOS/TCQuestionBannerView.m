//
//  TCQuestionBannerView.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestionBannerView.h"
#import "UILabel+Extension.h"
#import "TCDefines.h"
#import "UIView+AutoLayout.h"

@interface TCQuestionBannerView ()

@property (strong, nonatomic) UILabel *currentPageLabel;

@end

@implementation TCQuestionBannerView

- (id)initWithDesc:(NSString *)desc currentPage:(int)currentPage totalPage:(int)totalPage {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor = kBannerBackgroundColor;
        [self constrainToHeight:44.f];
        
        UILabel *descLabel = [UILabel bannerDescLabel];
        descLabel.text = desc;
        
        _currentPageLabel = [UILabel highlightLabel];
        _currentPageLabel.text = [NSString stringWithFormat:@"%d", currentPage];
        if (currentPage == 0) {
            _currentPageLabel.hidden = YES;
        }
        
        UILabel *totalPageLabel = [UILabel bannerDescLabel];
        totalPageLabel.text = [NSString stringWithFormat:@"|%d", totalPage];
        if (totalPage == 0) {
            totalPageLabel.hidden = YES;
        }
        
        [self addSubview:descLabel];
        [self addSubview:_currentPageLabel];
        [self addSubview:totalPageLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(descLabel, _currentPageLabel, totalPageLabel);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"|-padding-[descLabel]-(>=0)-[_currentPageLabel][totalPageLabel]-padding-|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:metrics views:views]];
        [descLabel centerInContainerOnAxis:NSLayoutAttributeCenterY];
    }
    return self;
}

- (void)changeCurrentPage:(int)currentPage {
    _currentPageLabel.text = [NSString stringWithFormat:@"%d", currentPage];
}
@end
