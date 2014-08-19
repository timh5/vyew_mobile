//
//  SBUtils.m
//  StudyBuddy
//
//  Created by MacOs on 8/15/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBUtils.h"

@implementation SBUtils

+ (BOOL)validateEmail:(NSString *)email
{
    email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validateText:(NSString *)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (text.length > 0);
}

@end
