//
//  TCAnswerView.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/04.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCQuestion.h"

@interface TCAnswerView : UIView

- (id)initWithQuestion:(TCQuestion *)question num:(int)num;
- (void)transformWithQuestion:(TCQuestion *)question;

@end
