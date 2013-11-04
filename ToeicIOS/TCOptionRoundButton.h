//
//  TCOptionRoundButton.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCOptionRoundButton : UIButton

@property (assign, nonatomic) BOOL isSelected;

- (id)initWithMark:(NSString *)mark;
- (void)changeState;

@end
