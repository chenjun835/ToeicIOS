//
//  TCQuestionView.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCQuestion.h"

@interface TCQuestionView : UIScrollView

- (id)initWithQuestion:(TCQuestion *)question num:(int)num total:(int)total;

@end
