//
//  TCAnswerSheetVC.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCAnswerSheetVC.h"
#import "TCDefines.h"
#import "TCAnswerView.h"
#import "UIView+AutoLayout.h"
#import "TCDefines.h"
#import "TCQuestionBannerView.h"
#import "UIButton+Extension.h"

@interface TCAnswerSheetVC ()

@property (strong, nonatomic) TCQuestionListModel *model;
@property (strong, nonatomic) NSMutableArray *answerViews;

@end

@implementation TCAnswerSheetVC

- (id)initWithQuestionListModel:(TCQuestionListModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//        self.navigationItem.title = NSLocalizedString(@"Answer Sheet", nil);
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubviews];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(questionAnswered:)
                                                 name:kNotificationQuestionAnswered
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubviews {
    TCQuestionBannerView *bannerView = [[TCQuestionBannerView alloc] initWithDesc:NSLocalizedString(@"Answer Sheet", nil) currentPage:0 totalPage:0];
    [self.view addSubview:bannerView];
    [bannerView pinToSuperviewEdges:JRTViewPinTopEdge|JRTViewPinLeftEdge|JRTViewPinRightEdge inset:0];
    
    _answerViews = [[NSMutableArray alloc] initWithCapacity:_model.list.count];
    for (int i=0; i<_model.list.count; i++) {
        _answerViews[i] = [[TCAnswerView alloc] initWithQuestion:_model.list[i] num:i+1];
        [self.view addSubview:_answerViews[i]];
    }
    for (int i=0; i<_answerViews.count; i++) {
        TCAnswerView *answerView = (TCAnswerView *)(_answerViews[i]);
        if (i%2) {
            [answerView setBackgroundColor:kAnswerBackgroundColor1];
        }
        else {
            [answerView setBackgroundColor:kAnswerBackgroundColor2];
        }
        [answerView pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge inset:0];
        if (i==0) {
            [answerView pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofItem:bannerView inset:kPadding];
        }
        else {
            [answerView pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofItem:_answerViews[i-1]];
        }
    }
    
    UIButton *submitButton = [UIButton defaultButton];
    [submitButton setTitle:NSLocalizedString(@"submit & check result", nil) forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    [submitButton centerInContainerOnAxis:NSLayoutAttributeCenterX];
    [submitButton pinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofItem:_answerViews.lastObject inset:kPadding];
    [submitButton constrainToHeight:44];
}

- (void)transformAnswerSheet {
    for (int i=0; i<_answerViews.count; i++) {
        TCAnswerView *answerView = (TCAnswerView *)_answerViews[i];
        [answerView transformWithQuestion:_model.list[i]];
    }
}

- (void)questionAnswered:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    int num = [(NSNumber *)userInfo[@"num"] intValue];
    NSString *answer = (NSString *)userInfo[@"answer"];
    TCAnswerView *answerView = (TCAnswerView *)_answerViews[num-1];
    answerView.userAnswer = answer;
    
    ((TCQuestion *)_model.list[num-1]).userAnswer = answer;
}

@end
