//
//  SBRoom.m
//  StudyBuddy
//
//  Created by MacOs on 8/18/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBRoom.h"

@implementation SBRoom

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {

        self.canInvite = [dict[@"canInvite"] boolValue];
        self.ext = dict[@"ext"];
        self.folderID = dict[@"folderID"];
        self.groupStr = dict[@"groupStr"];
        self.roomID = dict[@"id"];
        self.invitees = dict[@"invitees"];
        self.isPublic = [dict[@"isPublic"] boolValue];
        self.isPublished = [dict[@"isPublished"] boolValue];
        self.lastEdit = dict[@"lastEdit"];
        self.meetingID = dict[@"meetingID"];
        self.name = dict[@"name"];
        self.owner = dict[@"owner"];
        self.ownerID = dict[@"ownerID"];
        self.pageCount = [dict[@"pageCount"] intValue];
        self.publishedFrom = dict[@"publishedFrom"];
        self.type = dict[@"type"];
    }

    return self;
}

@end
