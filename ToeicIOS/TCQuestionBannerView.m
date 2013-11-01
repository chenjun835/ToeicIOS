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

@implementation TCQuestionBannerView

- (id)initWithDesc:(NSString *)desc currentPage:(int)currentPage totalPage:(int)totalPage {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *descLabel = [UILabel bannerDescLabel];
        descLabel.text = desc;
        
        UILabel *currentPageLabel = [UILabel highlightLabel];
        currentPageLabel.text = [NSString stringWithFormat:@"%d", currentPage];
        
        UILabel *totalPageLabel = [UILabel bannerDescLabel];
        totalPageLabel.text = [NSString stringWithFormat:@"|%d", totalPage];
        
        [self addSubview:descLabel];
        [self addSubview:currentPageLabel];
        [self addSubview:totalPageLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(descLabel, currentPageLabel, totalPageLabel);
        NSDictionary *metrics = @{@"padding": @kPadding};
        NSString *visualFormat = @"|-padding-[descLabel]-(>=0)-[currentPageLabel][totalPageLabel]-padding-|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:metrics views:views]];
        [descLabel pinToSuperviewEdges:JRTViewPinTopEdge|JRTViewPinBottomEdge inset:kPadding];
    }
    return self;
}

@end
