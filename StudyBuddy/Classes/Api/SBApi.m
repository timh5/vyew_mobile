//
//  SBApi.m
//  StudyBuddy
//
//  Created by MacOs on 8/15/14.
//  Copyright (c) 2014 Ibrahim. All rights reserved.
//

#import "SBApi.h"
#import "SBUser.h"
#import "SBTutorSubject.h"
#import "SBRoom.h"

#define API_BASEURL @"http://vyew.com/v4.49/amfphp/json.php/"

static SBApi *_sharedApi = nil;

@implementation SBApi

+ (SBApi *)sharedInstance
{
    if (_sharedApi == nil) {

        _sharedApi = [[SBApi alloc] init];
    }

    return _sharedApi;
}

#pragma mark -
#pragma mark network methods
// session methods
- (void)initSession:(void (^)(BOOL))completion
{
    if ([self sessionID]) {

        if (completion) {

            completion(YES);
        }

        return;
    }

    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.init" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);

        NSDictionary *responseDict = [NSDictionary dictionaryWithDictionary:responseObject];
        [self setSessionID:responseDict[@"sid"]];

        if (completion) {

            completion(YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);

        if (completion) {

            completion(NO);
        }
    }];
}

- (NSString *)sessionID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionID"];
}

- (void)setSessionID:(NSString *)sessionID
{
    if (sessionID == nil
        || [sessionID isKindOfClass:[NSNull class]]) {

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sessionID"];
    }
    else {

        [[NSUserDefaults standardUserDefaults] setObject:sessionID forKey:@"sessionID"];
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
}

// login methods
- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion
{
    if (![self sessionID]) {

        if (completion) {

            completion(NO, nil);
        }

        return;
    }

    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.login" parameters:@[email, password] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSDictionary *responseDict = [NSDictionary dictionaryWithDictionary:responseObject];

        if (completion) {

            BOOL success = [responseDict[@"result"] boolValue];
            NSString *errorMsg = [responseDict[@"message"] isKindOfClass:[NSString class]] ? responseDict[@"message"] : nil;

            if (success) {

                SBUser *user = [SBUser objectWithDictionary:responseDict];
                [SBUser setCurrentUser:user];

                [self getRooms:^(NSArray *rooms, NSString *errorMsg) {

                }];

                completion(YES, nil);
            }
            else {

                completion(NO, errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        if (completion) {

            completion(NO, error.localizedDescription);
        }
    }];
}

- (void)forgotPassword:(NSString *)email
{
    NSString *link = @"https://vyew.com/go/changepassword";
    if ([SBUtils validateEmail:email]) {

        link = [link stringByAppendingFormat:@"?em=%@", email];
    }

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

- (void)signOut
{
    [SBUser setCurrentUser:nil];
}

// tutor methods
- (void)getTutorSubjects:(void (^)(NSArray *subjects, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.getTutorSubjects" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *responseArray = responseObject;
        NSMutableArray *subjects = [NSMutableArray array];

        for (NSDictionary *dict in responseArray) {

            [subjects addObject:[SBTutorSubject objectWithDictionary:dict]];
        }

        if (completion) {

            completion(subjects, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
        if (completion) {

            completion(nil, error.localizedDescription);
        }
    }];
}

- (void)requestTutor:(NSString *)tutorID
          completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.requestTutor" parameters:@[tutorID] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

// rooms methods
- (void)getRooms:(void (^)(NSArray *rooms, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.getRooms" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *responseArray = responseObject;
        NSMutableArray *rooms = [NSMutableArray array];

        for (NSDictionary *dict in responseArray) {

            [rooms addObject:[SBRoom objectWithDictionary:dict]];
        }

        if (completion) {

            completion(rooms, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
        if (completion) {

            completion(nil, error.localizedDescription);
        }
    }];
}

- (void)getRoomUpdates:(NSString *)meetingID
             timestamp:(int)timestamp
            completion:(void (^)(NSArray *chats, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.getRoomUpdates" parameters:@[meetingID, @(timestamp)] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)joinRoom:(NSString *)roomID
      completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.joinRoom" parameters:@[roomID] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)sendChat:(NSString *)message
      completion:(void (^)(BOOL succeeded, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.sendChat" parameters:@[message] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

// pages methods
- (void)getPages:(NSString *)roomID
      completion:(void (^)(NSArray *pages, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.getPages" parameters:@[roomID] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

// imports methods
- (void)getImportURL:(NSString *)roomID
          completion:(void (^)(NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.getImportURL" parameters:@[roomID] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)checkImportStatus:(NSString *)fileID
               completion:(void (^)(int status, NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.checkImportStatus" parameters:@[fileID] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)getWowzaURL:(NSString *)roomID
         completion:(void (^)(NSString *errorMsg))completion
{
    [[AFAppDotNetAPIClient sharedClient] GET:@"VyewMobile.getWowzaURL" parameters:@[roomID] success:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@", error.localizedDescription);
    }];
}

@end

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient
{
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:API_BASEURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:0];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", nil];
    });

    return _sharedClient;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *newURLString = URLString;
    for (NSString *parameter in parameters) {

        newURLString = [newURLString stringByAppendingFormat:@"/%@", parameter];
    }

    NSDictionary *paramsDict = nil;
    NSString *sessionID = [[SBApi sharedInstance] sessionID];
    if (sessionID) {

        paramsDict = @{@"code": sessionID};
    }

    return [super GET:newURLString parameters:paramsDict success:success failure:failure];
}

- (NSString *)urlEncodedStringForString:(NSString *)str
{
    CFStringRef escapedStr = NULL;
    if (str) {

        escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                             (__bridge CFStringRef) str,
                                                             nil,
                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                             kCFStringEncodingUTF8);
    }

    return (__bridge NSString *)escapedStr;
}

@end
