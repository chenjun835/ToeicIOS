//
//  TCCategoryCell.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/03.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCCategory.h"

@protocol TCCategoryCellDelegate <NSObject>

- (void)fetchQuestionsWithCategory:(TCCategory *)category;

@end

@interface TCCategoryCell : UITableViewCell

@property (weak, nonatomic) id<TCCategoryCellDelegate> delegate;

- (void)transformWithCategory:(TCCategory *)category;

@end
