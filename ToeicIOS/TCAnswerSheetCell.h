//
//  TCAnswerSheetCell.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCQuestion.h"

@interface TCAnswerSheetCell : UITableViewCell

- (void)transformWithQuestion:(TCQuestion *)question num:(int)num;

@end
