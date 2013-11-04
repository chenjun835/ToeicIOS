//
//  TCCategoryListModel.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCCategoryListModel.h"
#import "TCCategory.h"

@implementation TCCategoryListModel

+ (TCCategoryListModel *)sharedModel {
    static TCCategoryListModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[TCCategoryListModel alloc] init];
    });
    
    return model;
}

- (void)loadWithLimit:(NSInteger)limit didLoadBlock:(didLoadBlock_t)didLoadBlock {
    self.offset = 0;
    self.limit = limit;

    [self loadMoreWithDidLoadBlock:didLoadBlock];
}

- (void)loadMoreWithDidLoadBlock:(didLoadBlock_t)didLoadBlock {
    PFQuery *query = [TCCategory query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.list addObjectsFromArray:objects];
        }
        else {
            NSLog(@"Error : %@ %@", error, [error userInfo]);
        }
        didLoadBlock(error);
    }];
}

@end
