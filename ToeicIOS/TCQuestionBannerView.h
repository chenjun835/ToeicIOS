//
//  TCQuestionBannerView.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/01.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCQuestionBannerView : UIView

- (id)initWithDesc:(NSString *)desc currentPage:(int)currentPage totalPage:(int)totalPage;
- (void)changeCurrentPage:(int)currentPage;

@end
