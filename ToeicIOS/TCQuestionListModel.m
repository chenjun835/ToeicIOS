//
//  TCQuestionListModel.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestionListModel.h"
#import "TCQuestion.h"

@interface TCQuestionListModel ()

@property (nonatomic, strong) TCCategory *category;

@end

@implementation TCQuestionListModel

- (id)initWithCategory:(TCCategory *)category {
    self = [self init];
    if (self) {
        _category = category;
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
    [query whereKey:@"category" equalTo:[PFObject objectWithoutDataWithClassName:@"Category"
                                                                        objectId:_category.categoryId]];
    //[query includeKey:@"category"];
    [query orderByAscending:@"createdAt"];
    query.limit = self.limit;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *obj in objects) {
                TCQuestion *question = [[TCQuestion alloc] initWithPFObject:obj];
                question.category = _category;
                [self.list addObject:question];
            }
        }
        else {
            NSLog(@"Error : %@ %@", error, [error userInfo]);
        }
        didLoadBlock(error);
    }];
}

@end
