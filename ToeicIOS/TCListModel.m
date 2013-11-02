//
//  TCListModel.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCListModel.h"
#import "TCDefines.h"

@implementation TCListModel

- (id)init {
    self = [super init];
    if (self) {
        [self reset];
    }

    return  self;
}

- (void)reset {
    _list = [NSMutableArray array];
    _hasMore = YES;
}

- (void)loadWithDidLoadBlock:(didLoadBlock_t)didLoadBlock {
    [self loadWithLimit:kDefaultListLimit didLoadBlock:didLoadBlock];
}

- (void)loadWithLimit:(NSInteger)limit didLoadBlock:(didLoadBlock_t)didLoadBlock {
    // Need implementation at child class.
}

- (void)loadMoreWithDidLoadBlock:(didLoadBlock_t)didLoadBlock {
    // Need implementation at child class.
}

- (void)reloadWithDidLoadBlock:(didLoadBlock_t)didLoadBlock {
    NSInteger lengthToRemove = [_list count];
    didLoadBlock_t block = ^(NSError *error) {
        // Don't remove old data when loading failed.
        if (!error) {
            NSRange rangeToRemove = NSMakeRange(0, lengthToRemove);
            [_list removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:rangeToRemove]];
        }
        didLoadBlock(error);
    };
    [self loadWithLimit:self.limit didLoadBlock:block];
}

@end
