//
//  TCQuestion.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "TCCategory.h"

@interface TCQuestion : PFObject <PFSubclassing>

// Data from server
@property (retain) NSString *body;
@property (retain) NSString *optionA;
@property (retain) NSString *optionB;
@property (retain) NSString *optionC;
@property (retain) NSString *optionD;
@property (retain) NSString *answer;
@property (retain) TCCategory *category;

// Data in Client
@property (retain) NSString *userAnswer;

+ (NSString *)parseClassName;

@end
