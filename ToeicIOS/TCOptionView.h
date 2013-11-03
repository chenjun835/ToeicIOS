//
//  TCOptionView.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCOptionViewDelegate <NSObject>

- (void)mark:(NSString *)mark changeToState:(BOOL)isSelected;

@end

@interface TCOptionView : UIView

@property (weak, nonatomic) id<TCOptionViewDelegate> delegate;

- (id)initWithMark:(NSString *)mark optionBody:(NSString *)optionBody;
- (void)unSelect;

@end
