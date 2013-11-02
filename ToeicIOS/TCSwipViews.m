//
//  TCSwipViews.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCSwipViews.h"
#import "TCQuestionView.h"
#import "TCQuestionBannerView.h"
#import "UIView+AutoLayout.h"

@interface TCSwipViews ()

@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) NSMutableArray *viewList;
@property (strong, nonatomic) NSArray *currentConstraints;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation TCSwipViews

- (id)initWithQuestionList:(NSArray *)list
{
    self = [super init];
    if (self) {
        _list = list;
        
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        _pageControl = ({
            UIPageControl *control = [[UIPageControl alloc] init];
            control.translatesAutoresizingMaskIntoConstraints = NO;
            control.numberOfPages = _list.count;
            control.currentPage = 0;
            control;
        });
        
        [self addSubview:_pageControl];
        
        [_pageControl pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];
        
        _viewList = [NSMutableArray arrayWithCapacity:_pageControl.numberOfPages];
        for (int page=_pageControl.currentPage; page<_pageControl.numberOfPages; page++) {
            _viewList[page] = [self questionViewWithPage:page];
            
            [self addSubview:_viewList[page]];
            [_viewList[page] constrainToSize:_pageControl.frame.size];
            [_viewList[page] pinToSuperviewEdges:JRTViewPinTopEdge inset:0.f];
            
            if (page > _pageControl.currentPage) {
                [_viewList[page] pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeRight ofItem:_viewList[page-1]];
            }
        }
        
        _currentConstraints = [_viewList[_pageControl.currentPage] pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];
    }
    return self;
}

#pragma mark - Private methods

- (TCQuestionView *)questionViewWithPage:(int)page {
    TCQuestionView *questionView = [[TCQuestionView alloc] initWithQuestion:_list[page]];
    if (page < (_pageControl.numberOfPages-1)) {
        UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(showNextPage)];
        gr.direction = UISwipeGestureRecognizerDirectionLeft;
        [questionView addGestureRecognizer:gr];
    }
    if (page > 0) {
        UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(showPrevPage)];
        gr.direction = UISwipeGestureRecognizerDirectionRight;
        [questionView addGestureRecognizer:gr];
    }
    return questionView;
}

- (void)swipToPage:(int)toPage {
    [self removeConstraints:_currentConstraints];
    _currentConstraints = [_viewList[toPage] pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.f
                     animations:^{
                         [weakSelf layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         weakSelf.pageControl.currentPage = toPage;
                     }];
}

- (void)showNextPage {
    [self swipToPage:(_pageControl.currentPage + 1)];
}

- (void)showPrevPage {
    [self swipToPage:(_pageControl.currentPage - 1)];
}

@end
