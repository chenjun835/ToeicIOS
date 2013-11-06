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
#import <Parse/Parse.h>

@interface TCLoginVC ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

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
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIButton *fbBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        UIImage *bgImage = [UIImage imageNamed:@"fb-login-btn"];
        UIImage *bgImageHighlight = [UIImage imageNamed:@"fb-login-btn-pressed"];
        [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [btn setBackgroundImage:bgImageHighlight forState:UIControlStateHighlighted];
        [btn setTitle:NSLocalizedString(@"  login", nil) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    [self.view addSubview:_activityIndicator];
    [self.view addSubview:fbBtn];
    
    [fbBtn centerInView:self.view];
    [_activityIndicator pinEdge:NSLayoutAttributeBottom toEdge:NSLayoutAttributeTop ofItem:fbBtn];
    [_activityIndicator pinAttribute:NSLayoutAttributeCenterX toSameAttributeOfView:fbBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Login to facebook method */
- (void)loginButtonTouchHandler:(id)sender  {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            if ([_delegate respondsToSelector:@selector(loginSuccessed)]) {
                [_delegate loginSuccessed];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
            if ([_delegate respondsToSelector:@selector(loginSuccessed)]) {
                [_delegate loginSuccessed];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}


@end
