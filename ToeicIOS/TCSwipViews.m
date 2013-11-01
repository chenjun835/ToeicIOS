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
@property (strong, nonatomic) NSArray *viewList;
@property (strong, nonatomic) NSArray *currentConstraints;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) TCQuestionBannerView *bannerView;

@end

@implementation TCSwipViews

- (id)initWithQuestionList:(TCListModel *)listModel
{
    self = [super init];
    if (self) {
        _list = listModel.list;
        
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        _pageControl = ({
            UIPageControl *control = [[UIPageControl alloc] init];
            control.translatesAutoresizingMaskIntoConstraints = NO;
            control.numberOfPages = _list.count;
            control.currentPage = 0;
            control;
        });
        
        _bannerView = [[TCQuestionBannerView alloc] initWithDesc:@"語彙練習"
                                                     currentPage:1
                                                       totalPage:_list.count];
        [_bannerView constrainToHeight:44.f];
        
        [self addSubview:_bannerView];
        [self addSubview:_pageControl];
        
        [_bannerView pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinTopEdge|JRTViewPinRightEdge inset:0.f];
        [_pageControl pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinBottomEdge|JRTViewPinRightEdge inset:0.f];
        [_pageControl pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofItem:_bannerView];
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:_pageControl.numberOfPages];
        for (int page=_pageControl.currentPage; page<_pageControl.numberOfPages; page++) {
            array[page] = [self questionViewWithPage:page];
            
            [self addSubview:array[page]];
            [array[page] constrainToSize:_pageControl.frame.size];
            
            if (page > _pageControl.currentPage) {
                [array[page] pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeRight ofItem:array[page-1]];
                [array[page] pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeTop ofItem:array[page-1]];
            }
        }
        
        _viewList = array;
        
        _currentConstraints = [_viewList[_pageControl.currentPage] pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinTopEdge inset:0];
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
    _currentConstraints = [_viewList[toPage] pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinTopEdge inset:0];

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.f
                     animations:^{
                         [weakSelf layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         weakSelf.pageControl.currentPage = toPage;
                         [_bannerView changeCurrentPage:toPage+1];
                     }];
}

- (void)showNextPage {
    [self swipToPage:(_pageControl.currentPage + 1)];
}

- (void)showPrevPage {
    [self swipToPage:(_pageControl.currentPage - 1)];
}

@end
