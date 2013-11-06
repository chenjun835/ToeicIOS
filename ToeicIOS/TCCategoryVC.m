//
//  TCCategoryVC.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCCategoryVC.h"
#import "TCCategoryListModel.h"
#import "TCCategory.h"
#import "TCQuestionVC.h"
#import "TCDefines.h"
#import "TCCategoryCell.h"
#import "TCLoginVC.h"

@interface TCCategoryVC () <TCCategoryCellDelegate>

@property (nonatomic, strong) TCCategoryListModel *model;

@end

@implementation TCCategoryVC

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = NSLocalizedString(@"TOEIC", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[TCCategoryCell class] forCellReuseIdentifier:kCategoryCell];
    
    _model = [TCCategoryListModel sharedModel];
    [_model loadWithLimit:kDefaultListLimit didLoadBlock:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    if (![PFUser currentUser]) {
        UIBarButtonItem *loginBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"login", nil)
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(gotoLogin)];
        self.navigationItem.rightBarButtonItem = loginBtn;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCCategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:kCategoryCell];
    [categoryCell transformWithCategory:_model.list[indexPath.row]];
    categoryCell.delegate = self;
    
    return categoryCell;
}

#pragma mark - TCCategoryCellDelegate 

- (void)fetchQuestionsWithCategory:(TCCategory *)category {
    TCQuestionVC *questionVC = [[TCQuestionVC alloc] initWithCategory:category];
    [self.navigationController pushViewController:questionVC animated:YES];
}

#pragma mark - Private methods 

- (void)gotoLogin {
    TCLoginVC *loginVC = [[TCLoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
