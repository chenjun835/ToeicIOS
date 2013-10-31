//
//  TCMasterViewController.h
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCDetailViewController;

@interface TCMasterViewController : UITableViewController

@property (strong, nonatomic) TCDetailViewController *detailViewController;

@end
