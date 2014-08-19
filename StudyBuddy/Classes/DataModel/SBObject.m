//
//  SBObject.m
//  StudyBuddy
//
//  Created by MacOs on 8/18/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBObject.h"

@implementation SBObject

+ (id)objectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

    }

    return self;
}

@end
