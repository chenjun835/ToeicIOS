//
//  TCQuestion.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestion.h"
#import <Parse/PFObject+Subclass.h>
#import "TCDefines.h"

@implementation TCQuestion

@dynamic body;
@dynamic optionA;
@dynamic optionB;
@dynamic optionC;
@dynamic optionD;
@dynamic category;
@dynamic userAnswer;

+ (NSString *)parseClassName {
    return kClassNameQuestion;
}

@end
