//
//  TCListModel.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#define kDefaultListLimit 20

#import <Foundation/Foundation.h>

typedef void (^didLoadBlock_t)(NSError *error);

@interface TCListModel : NSObject

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) BOOL hasMore;

- (void)loadWithDidLoadBlock:(didLoadBlock_t)didLoadBlock;
- (void)loadWithLimit:(NSInteger)limit didLoadBlock:(didLoadBlock_t)didLoadBlock;
- (void)loadMoreWithDidLoadBlock:(didLoadBlock_t)didLoadBlock;
- (void)reloadWithDidLoadBlock:(didLoadBlock_t)didLoadBlock;
- (void)reset;

@end
