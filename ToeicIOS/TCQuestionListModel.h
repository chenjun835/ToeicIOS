//
//  TCQuestionListModel.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCListModel.h"
#import "TCCategory.h"

@interface TCQuestionListModel : TCListModel

- (id)initWithCategory:(TCCategory *)category;
- (BOOL)isAllAnswered;

@end
