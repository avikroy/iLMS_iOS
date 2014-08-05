//
//  iLMSLoggedinUser.h
//  iLMS
//
//  Created by Avik on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iLMSLoggedinUser : NSObject

@property (nonatomic, assign) BOOL loginSuccess;
@property (nonatomic, retain) NSString *custID;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userPassword;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *userType;

+ (void)createSharedInstance:(iLMSLoggedinUser *)aUser;
+ (iLMSLoggedinUser *)getSharedinstance;
+ (void)destroyinstance;
- (id)initWithArray:(NSArray *)array withRemeberMeOptionOn:(BOOL)isOn;


@end
