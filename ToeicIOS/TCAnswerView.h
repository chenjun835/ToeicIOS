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

@property (strong, nonatomic) NSString *userAnswer;

- (id)initWithNum:(int)num;

@end
