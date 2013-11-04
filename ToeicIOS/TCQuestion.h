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

@interface TCQuestion : NSObject

// Data from server
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *questionBody;
@property (nonatomic, strong) NSString *optionA;
@property (nonatomic, strong) NSString *optionB;
@property (nonatomic, strong) NSString *optionC;
@property (nonatomic, strong) NSString *optionD;
@property (nonatomic, strong) TCCategory *category;

// Data in Client
@property (nonatomic, strong) NSString *userAnswer;

- (id)initWithPFObject:(PFObject *)object;

@end
