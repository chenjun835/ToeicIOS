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

@interface TCCategoryVC () <TCCategoryCellDelegate, TCLoginVCDelegate>

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
        [self setLoginBtn];
    } else {
        [self setUserBtn];
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

#pragma mark - TCLoginVCDelegate

- (void)loginSuccessed {
    [self setUserBtn];
}

- (void)loginFailed {
    [self setLoginBtn];
}

#pragma mark - Private methods 

- (void)login {
    TCLoginVC *loginVC = [[TCLoginVC alloc] init];
    loginVC.delegate = self;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)logout {
    [PFUser logOut];
    [self setLoginBtn];
}

- (void)setLoginBtn {
    UIBarButtonItem *loginBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"login", nil)
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(login)];
    self.navigationItem.rightBarButtonItem = loginBtn;
}

- (void)setUserBtn {
    UIBarButtonItem *userBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"logout", nil)
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = userBtn;
}
     
@end
