//
//  SBLoginViewController.h
//  StudyBuddy
//
//  Created by MacOs on 8/15/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBBaseViewController.h"

@interface SBLoginViewController : SBBaseViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;

- (IBAction)actionLogin;
- (IBAction)actionForgotPassword;

@end
