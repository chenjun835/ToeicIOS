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
#import "TCSwipViews.h"
#import "TCDefines.h"

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
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _model = [[TCQuestionListModel alloc] initWithCategoryId:_category.categoryId];
    [_model loadWithLimit:kDefaultListLimit didLoadBlock:^(NSError *error) {
        if (!error && _model.list.count>0) {
            [self changeQuestionView];
        }
    }];
}

#pragma mark - Private methods

- (void)changeQuestionView {
    TCSwipViews *swipeViews = [[TCSwipViews alloc] initWithQuestionList:_model.list];
    [self.view addSubview:swipeViews];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[swipeViews]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(swipeViews)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[swipeViews]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(swipeViews)]];
}
@end
