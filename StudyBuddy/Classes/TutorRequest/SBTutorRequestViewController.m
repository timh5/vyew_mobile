//
//  SBTutorRequestViewController.m
//  StudyBuddy
//
//  Created by MacOs on 8/15/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBTutorRequestViewController.h"

@interface SBTutorRequestViewController ()

@end

@implementation SBTutorRequestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)actionRequestTutor
{
    [[SBApi sharedInstance] getTutorSubjects:^(NSArray *subjects, NSString *errorMsg) {

    }];
}

- (void)actionViewPreviousSession
{
    //
}

- (void)actionSignout
{
    [[SBApi sharedInstance] signOut];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
