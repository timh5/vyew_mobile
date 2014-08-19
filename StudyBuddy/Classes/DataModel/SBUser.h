//
//  SBUser.h
//  StudyBuddy
//
//  Created by MacOs on 8/17/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBObject.h"

@interface SBUser : SBObject

@property (nonatomic, strong) NSString *em;
@property (nonatomic, strong) NSString *baseMID;
@property (nonatomic, strong) NSString *customID;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSString *homeurl;
@property (nonatomic, strong) NSString *loginID;
@property (nonatomic, strong) NSString *ls;
@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *rgid;
@property (nonatomic, strong) NSString *serverID;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *standing;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *versionID;

+ (SBUser *)currentUser;
+ (void)setCurrentUser:(SBUser *)user;

@end
