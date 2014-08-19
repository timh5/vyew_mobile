//
//  SBObject.h
//  StudyBuddy
//
//  Created by MacOs on 8/18/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBObject : NSObject

+ (id)objectWithDictionary:(NSDictionary *)dict;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
