//
//  TCCategoryListModel.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCCategoryListModel.h"
#import <Parse/Parse.h>
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
    PFQuery *query = [PFQuery queryWithClassName:@"Category"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *obj in objects) {
                [self.list addObject:[[TCCategory alloc] initWithPFObject:obj]];
            }
        }
        else {
            NSLog(@"Error : %@ %@", error, [error userInfo]);
        }
        didLoadBlock(error);
    }];
}

@end
