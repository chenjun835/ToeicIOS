//
//  TCCategory.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCCategory.h"
#import <Parse/PFObject+Subclass.h>

@implementation TCCategory

@dynamic name;

+ (NSString *)parseClassName {
    return @"Category";
}

@end
