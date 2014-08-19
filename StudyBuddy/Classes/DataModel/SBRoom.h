//
//  SBRoom.h
//  StudyBuddy
//
//  Created by MacOs on 8/18/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBObject.h"

@interface SBRoom : SBObject

@property (nonatomic) BOOL canInvite;
@property (nonatomic, strong) NSString *ext;
@property (nonatomic, strong) NSString *folderID;
@property (nonatomic, strong) NSString *groupStr;
@property (nonatomic, strong) NSString *roomID;
@property (nonatomic, strong) NSString *invitees;
@property (nonatomic) BOOL isPublic;
@property (nonatomic) BOOL isPublished;
@property (nonatomic, strong) NSString *lastEdit;
@property (nonatomic, strong) NSString *meetingID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *ownerID;
@property (nonatomic) NSInteger pageCount;
@property (nonatomic, strong) NSString *publishedFrom;
@property (nonatomic, strong) NSString *type;

@end
