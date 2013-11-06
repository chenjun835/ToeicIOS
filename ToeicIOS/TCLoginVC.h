//
//  TCLoginVC.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/06.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCLoginVCDelegate <NSObject>

- (void)loginSuccessed;
- (void)loginFailed;

@end

@interface TCLoginVC : UIViewController

@property (weak, nonatomic) id<TCLoginVCDelegate> delegate;

@end
