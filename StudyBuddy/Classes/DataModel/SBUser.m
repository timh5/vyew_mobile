//
//  SBUser.m
//  StudyBuddy
//
//  Created by MacOs on 8/17/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBUser.h"

static SBUser *_currentUser = nil;

@implementation SBUser

+ (SBUser *)currentUser
{
    return _currentUser;
}

+ (void)setCurrentUser:(SBUser *)user
{
    _currentUser = user;
    if ([user.sid isKindOfClass:[NSString class]]) {

        [[SBApi sharedInstance] setSessionID:user.sid];
    }
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

        if (dict[@"em"] == nil
            || [dict[@"em"] isKindOfClass:[NSNull class]]) {

            return nil;
        }

        self.baseMID = dict[@"baseMID"];
        self.customID = dict[@"customID"];
        self.em = dict[@"em"];
        self.groups = dict[@"groups"];
        self.homeurl = dict[@"homeurl"];
        self.loginID = dict[@"loginID"];
        self.ls = dict[@"ls"];
        self.ptype = dict[@"ptype"];
        self.result = dict[@"result"];
        self.rgid = dict[@"rgid"];
        self.serverID = dict[@"serverID"];
        self.sid = dict[@"sid"];
        self.standing = dict[@"standing"];
        self.timezone = dict[@"timezone"];
        self.type = dict[@"type"];
        self.uid = dict[@"uid"];
        self.userID = dict[@"userID"];
        self.versionID = dict[@"versionID"];
    }

    return self;
}

@end
