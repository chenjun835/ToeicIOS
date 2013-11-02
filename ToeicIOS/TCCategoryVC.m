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

@interface TCCategoryVC ()

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

    _model = [TCCategoryListModel sharedModel];
    [_model loadWithLimit:kDefaultListLimit didLoadBlock:^(NSError *error) {
        [self.tableView reloadData];
    }];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    TCCategory *category = _model.list[indexPath.row];
    cell.textLabel.text = category.categoryName;
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TCQuestionVC *questionVC = [[TCQuestionVC alloc] initWithCategory:_model.list[indexPath.row]];
    [self.navigationController pushViewController:questionVC animated:YES];
}

@end
