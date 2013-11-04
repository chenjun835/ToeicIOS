//
//  TCSwipViewVC.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCSwipViewVC.h"
#import "TCQuestionView.h"
#import "UIView+AutoLayout.h"
#import "TCAnswerSheetVC.h"

@interface TCSwipViewVC ()

@property (strong, nonatomic) TCQuestionListModel *model;
@property (strong, nonatomic) NSMutableArray *viewList;
@property (strong, nonatomic) NSArray *currentConstraints;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation TCSwipViewVC

- (id)initWithQuestionListModel:(TCQuestionListModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        _pageControl = ({
            UIPageControl *control = [[UIPageControl alloc] init];
            control.translatesAutoresizingMaskIntoConstraints = NO;
            control.numberOfPages = _model.list.count+1; // +1 Add answer sheet view
            control.currentPage = 0;
            control;
        });
        
        [self.view addSubview:_pageControl];
        
        [_pageControl pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge|JRTViewPinBottomEdge inset:0];
        
        _viewList = [NSMutableArray arrayWithCapacity:_pageControl.numberOfPages];
        for (int page=_pageControl.currentPage; page<_pageControl.numberOfPages; page++) {
            if (page<_pageControl.numberOfPages-1) {
                _viewList[page] = [self questionViewWithPage:page];
            }
            else {
                // Answer sheet view
                TCAnswerSheetVC *answerSheetVC = [[TCAnswerSheetVC alloc] initWithQuestionListModel:_model];
                [self addChildViewController:answerSheetVC];
                _viewList[page] = answerSheetVC.view;
            }
            
            [self.view addSubview:_viewList[page]];
            [_viewList[page] pinAttribute:NSLayoutAttributeWidth toSameAttributeOfView:self.view];
            [_viewList[page] pinAttribute:NSLayoutAttributeHeight toSameAttributeOfView:self.view];
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
    TCQuestionView *questionView = [[TCQuestionView alloc] initWithQuestion:_model.list[page] num:page+1 total:_model.list.count];
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
    [self.view removeConstraints:_currentConstraints];
    _currentConstraints = [_viewList[toPage] pinToSuperviewEdges:JRTViewPinLeftEdge inset:0];

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.f
                     animations:^{
                         [weakSelf.view layoutIfNeeded];
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
