//
//  TCQuestion.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestion.h"
#import <Parse/PFObject+Subclass.h>

@implementation TCQuestion

@dynamic body;
@dynamic A;
@dynamic B;
@dynamic C;
@dynamic D;
@dynamic category;
@dynamic userAnswer;

+ (NSString *)parseClassName {
    return @"Question";
}

@end
