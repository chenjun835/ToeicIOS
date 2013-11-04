//
//  TCQuestionVC.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestionVC.h"
#import "TCCategory.h"
#import "TCQuestionListModel.h"
#import "TCSwipViewVC.h"
#import "TCDefines.h"
#import "UIView+AutoLayout.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface TCQuestionVC ()

@property (strong, nonatomic) TCQuestionListModel *model;
@property (strong, nonatomic) TCCategory *category;

@end

@implementation TCQuestionVC

- (id)initWithCategory:(TCCategory *)category
{
    self = [super init];
    if (self) {
        _category = category;
        
        self.navigationItem.title = _category.categoryName;
        self.view.backgroundColor = kBackgroundColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"fetch questions for your situation", nil) maskType:SVProgressHUDMaskTypeNone];
    _model = [[TCQuestionListModel alloc] initWithCategory:_category];
    [_model loadWithLimit:kDefaultListLimit didLoadBlock:^(NSError *error) {
        if (!error && _model.list.count>0) {
            [self performSelector:@selector(initSubViews) withObject:nil afterDelay:1];
//            [SVProgressHUD dismiss];
//            [self initSubViews];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"fetch questions failed"];
        }
    }];
}

#pragma mark - Private methods

- (void)initSubViews{
    [SVProgressHUD dismiss];
    TCSwipViewVC *swipeViewVC = [[TCSwipViewVC alloc] initWithQuestionListModel:_model];
    [self addChildViewController:swipeViewVC];
    [self.view addSubview:swipeViewVC.view];
    
    [swipeViewVC.view pinToSuperviewEdgesWithInset:UIEdgeInsetsMake(kDefaultNavigationBarHeight, 0, 0, 0)];
}

@end
