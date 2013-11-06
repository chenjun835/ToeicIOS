//
//  TCLoginVC.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/11/06.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCLoginVC.h"
#import "TCDefines.h"
#import "UIView+AutoLayout.h"

@interface TCLoginVC ()

@end

@implementation TCLoginVC

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = NSLocalizedString(@"login", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    
    UIButton *fbBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        UIImage *bgImage = [UIImage imageNamed:@"fb-login-btn"];
        UIImage *bgImageHighlight = [UIImage imageNamed:@"fb-login-btn-pressed"];
        [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [btn setBackgroundImage:bgImageHighlight forState:UIControlStateHighlighted];
        [btn setTitle:NSLocalizedString(@"  login", nil) forState:UIControlStateNormal];
        btn;
    });
    
    [self.view addSubview:fbBtn];
    
    [fbBtn centerInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
