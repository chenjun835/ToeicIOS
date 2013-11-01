//
//  TCSwipViews.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCSwipViews.h"
#import "TCQuestionView.h"
#import "UIView+AutoLayout.h"

@interface TCSwipViews ()

@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) NSArray *viewList;
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
            control.numberOfPages = list.count;
            control.currentPage = 0;
            control;
        });
        
        [self addSubview:_pageControl];
        
        [_pageControl pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:_pageControl.numberOfPages];
        for (int page=_pageControl.currentPage; page<_pageControl.numberOfPages; page++) {
            array[page] = [self questionViewWithPage:page];
            
            [self addSubview:array[page]];
            [array[page] constrainToSize:self.bounds.size];
            
            if (page > _pageControl.currentPage) {
                [array[page] pinEdge:NSLayoutAttributeLeft toEdge:NSLayoutAttributeRight ofItem:array[page-1]];
            }
        }
        
        _viewList = array;
        
        _currentConstraints = [_viewList[_pageControl.currentPage] pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];
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
    _currentConstraints = [_viewList[toPage] pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];

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