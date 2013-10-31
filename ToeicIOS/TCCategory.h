//
//  TCCategory.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TCCategory : NSObject

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *categoryName;

- (id)initWithPFObject:(PFObject *)object;

@end
