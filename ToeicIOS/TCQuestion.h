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
@property (retain) NSString *A;
@property (retain) NSString *B;
@property (retain) NSString *C;
@property (retain) NSString *D;
@property (retain) TCCategory *category;

// Data in Client
@property (retain) NSString *userAnswer;

+ (NSString *)parseClassName;

@end
