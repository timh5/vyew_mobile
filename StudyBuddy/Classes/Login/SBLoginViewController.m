//
//  SBLoginViewController.m
//  StudyBuddy
//
//  Created by MacOs on 8/15/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBLoginViewController.h"

@interface SBLoginViewController ()

@end

@implementation SBLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [[SBApi sharedInstance] initSession:nil];

#ifdef TESTMODE
    [self.tfEmail setText:@"Anna@bell.com"];
    [self.tfPassword setText:@"asdf"];
#endif

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -
#pragma mark user interaction methods
- (void)actionLogin
{
    if (![self validateFields]) {

        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Plase input valid email/password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }

    [SVProgressHUD showWithStatus:@"Authenticating..." maskType:SVProgressHUDMaskTypeBlack];
    [[SBApi sharedInstance] loginWithEmail:self.tfEmail.text password:self.tfPassword.text completion:^(BOOL succeeded, NSString *errorMsg) {

        if (succeeded) {

            [SVProgressHUD dismiss];
            [self performSegueWithIdentifier:@"successLogin" sender:self];
        }
        else {

            if (errorMsg) {

                [SVProgressHUD showErrorWithStatus:errorMsg];
            }
            else {

                [SVProgressHUD dismiss];
            }
        }
    }];
}

- (void)actionForgotPassword
{
    [[SBApi sharedInstance] forgotPassword:self.tfEmail.text];
}

- (BOOL)validateFields
{
    return ([SBUtils validateText:self.tfEmail.text]) && (self.tfPassword.text.length > 0);
}

#pragma mark -
#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.tfEmail) {

        [self.tfPassword becomeFirstResponder];
    }
    else if (textField == self.tfPassword) {

        [textField resignFirstResponder];
        [self actionLogin];
    }

    return YES;
}

#pragma mark -
#pragma mark keyboard notification methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    float keyboardHeight = 220.0;
    CGRect tblRect = self.tableView.frame;
    tblRect.size.height = self.view.frame.size.height - keyboardHeight;
    [UIView animateWithDuration:0.25f animations:^{

        [self.tableView setFrame:tblRect];
    } completion:^(BOOL finished) {

        float contentOffsetY = self.tableView.tableHeaderView.frame.size.height - tblRect.size.height;
        [self.tableView setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect tblRect = self.tableView.frame;
    tblRect.size.height = self.view.frame.size.height;
    [UIView animateWithDuration:0.25f animations:^{

        [self.tableView setFrame:tblRect];
    }];
}

@end
