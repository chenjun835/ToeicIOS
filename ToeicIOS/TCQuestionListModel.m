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
    PFQuery *query = [TCQuestion query];
    [query whereKey:@"category" equalTo:[PFObject objectWithoutDataWithClassName:[TCCategory parseClassName]
                                                                        objectId:_category.objectId]];
    //[query includeKey:@"category"];
    [query orderByAscending:@"createdAt"];
    query.limit = self.limit;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (TCQuestion *question in objects) {
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

- (BOOL)isAllAnswered {
    for (int i=0; i<self.list.count; i++) {
        TCQuestion *question = (TCQuestion *)self.list[i];
        if (question.userAnswer == nil) {
            return NO;
        }
    }
    return YES;
}

@end
