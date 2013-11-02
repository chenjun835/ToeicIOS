//
//  TCQuestionListModel.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestionListModel.h"
#import "TCQuestion.h"

@implementation TCQuestionListModel

- (id)initWithCategoryId:(NSString *)categoryId {
    self = [self init];
    if (self) {
        _categoryId = categoryId;
    }
    return self;
}

- (void)loadWithLimit:(NSInteger)limit didLoadBlock:(didLoadBlock_t)didLoadBlock {
    self.offset = 0;
    self.limit = limit;

    [self loadMoreWithDidLoadBlock:didLoadBlock];
}

- (void)loadMoreWithDidLoadBlock:(didLoadBlock_t)didLoadBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    [query includeKey:@"category"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *obj in objects) {
                [self.list addObject:[[TCQuestion alloc] initWithPFObject:obj]];
            }
        }
        else {
            NSLog(@"Error : %@ %@", error, [error userInfo]);
        }
        didLoadBlock(error);
    }];
}

@end
