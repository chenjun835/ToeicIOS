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
#import "TCQuestionView.h"
#import <UIView-Autolayout/UIView+AutoLayout.h>

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
    TCQuestionView *questionView = [[TCQuestionView alloc] initWithQuestion:_model.list[0]];
    [self.view addSubview:questionView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[questionView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(questionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[questionView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(questionView)]];
//    [questionView pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];
    
    
//    [questionView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    
}
@end
