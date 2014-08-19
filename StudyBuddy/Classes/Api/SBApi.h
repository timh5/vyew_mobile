//
//  SBApi.h
//  StudyBuddy
//
//  Created by MacOs on 8/15/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SBApi : NSObject

+ (SBApi *)sharedInstance;

// session
- (void)initSession:(void (^)(BOOL succeeded))completion;

- (NSString *)sessionID;
- (void)setSessionID:(NSString *)sessionID;

// login
- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion;

- (void)forgotPassword:(NSString *)email;

// tutor
- (void)getTutorSubjects:(void (^)(NSArray *subjects, NSString *errorMsg))completion;
- (void)requestTutor:(NSString *)tutorID
          completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion;

// rooms
- (void)getRooms:(void (^)(NSArray *rooms, NSString *errorMsg))completion;
- (void)getRoomUpdates:(NSString *)meetingID
             timestamp:(int)timestamp
            completion:(void (^)(NSArray *chats, NSString *errorMsg))completion;
- (void)joinRoom:(NSString *)roomID
      completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion;
- (void)sendChat:(NSString *)message
      completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion;

// pages
- (void)getPages:(NSString *)roomID
      completion:(void (^)(NSArray *pages, NSString *errorMsg))completion;

// imports
- (void)getImportURL:(NSString *)roomID
          completion:(void (^)(NSString *errorMsg))completion;
- (void)checkImportStatus:(NSString *)fileID
               completion:(void (^)(int status, NSString *errorMsg))completion;
- (void)getWowzaURL:(NSString *)roomID
         completion:(void (^)(NSString *errorMsg))completion;

- (void)signOut;

@end

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
