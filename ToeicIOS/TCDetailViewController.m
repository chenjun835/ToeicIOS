//
//  TCDetailViewController.m
//  ToeicIOS
//
//  Created by 陳 俊 on 2013/10/31.
//  Copyright (c) 2013年 陳 俊. All rights reserved.
//

#import "TCDetailViewController.h"
#import "TCQuestionListModel.h"
#import "TCQuestion.h"

@interface TCDetailViewController ()

@property (strong, nonatomic) TCQuestionListModel *model;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@property (weak, nonatomic) IBOutlet UILabel *questionBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionALabel;
@property (weak, nonatomic) IBOutlet UILabel *optionBLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionCLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionDLabel;

- (void)configureView;

@end

@implementation TCDetailViewController

#pragma mark - Managing the detail item

- (void)setCategory:(TCCategory *)newCategory
{
    if (_category != newCategory) {
        _category = newCategory;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.category) {
        self.navigationItem.title = _category.categoryName;
        
        _model = [[TCQuestionListModel alloc] initWithCategoryId:_category.categoryId];
        [_model loadWithLimit:kDefaultListLimit didLoadBlock:^(NSError *error) {
            if (!error && _model.list.count>0) {
                TCQuestion *question = _model.list[0];
                _questionBodyLabel.text = question.questionBody;
                _optionALabel.text = [NSString stringWithFormat:@"%@, %@", @"A", question.optionA];
                _optionBLabel.text = [NSString stringWithFormat:@"%@, %@", @"B", question.optionB];
                _optionCLabel.text = [NSString stringWithFormat:@"%@, %@", @"C", question.optionC];
                _optionDLabel.text = [NSString stringWithFormat:@"%@, %@", @"D", question.optionD];
            }
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
