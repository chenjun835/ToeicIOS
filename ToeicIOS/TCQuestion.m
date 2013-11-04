//
//  TCQuestion.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCQuestion.h"

@implementation TCQuestion

- (id)initWithPFObject:(PFObject *)object {
    TCQuestion *question = [[TCQuestion alloc] init];
    question.questionId = object.objectId;
    question.questionBody = object[@"body"];
    question.optionA = object[@"A"];
    question.optionB = object[@"B"];
    question.optionC = object[@"C"];
    question.optionD = object[@"D"];
    //question.category = [[TCCategory alloc] initWithPFObject:object[@"category"]];
    
    return question;
}

@end
