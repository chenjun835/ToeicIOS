//
//  TCCategory.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCCategory.h"

@implementation TCCategory

- (id)initWithPFObject:(PFObject *)object {
    TCCategory *category = [[TCCategory alloc] init];
    category.categoryId = [object objectForKey:@"id"];
    category.categoryName = [object objectForKey:@"name"];
    return category;
}

@end
