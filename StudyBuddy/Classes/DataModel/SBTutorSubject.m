//
//  SBTutorSubject.m
//  StudyBuddy
//
//  Created by MacOs on 8/18/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBTutorSubject.h"

@implementation SBTutorSubject

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

        self.subjectID = dict[@"ID"];
        self.subjectCategory = dict[@"category"];
        self.subjectName = dict[@"name"];
    }

    return self;
}

@end
