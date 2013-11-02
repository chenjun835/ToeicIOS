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
    question.questionId = [object objectForKey:@"objectId"];
    question.questionBody = [object objectForKey:@"body"];
    question.optionA = [object objectForKey:@"A"];
    question.optionB = [object objectForKey:@"B"];
    question.optionC = [object objectForKey:@"C"];
    question.optionD = [object objectForKey:@"D"];
    
    // TODO - change bellow code
    
    TCCategory *category = [[TCCategory alloc] init];
    category.categoryId = @"xx";
    category.categoryName = @"語彙練習";
    question.category = category;
    
    return question;
}

@end
