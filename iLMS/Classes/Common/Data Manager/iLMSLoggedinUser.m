//
//  iLMSLoggedinUser.m
//  iLMS
//
//  Created by Avik on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSLoggedinUser.h"

@implementation iLMSLoggedinUser

static iLMSLoggedinUser * instance=nil;

+ (void)createSharedInstance:(iLMSLoggedinUser *)aUser{
    if(instance==nil){
        instance=aUser;
    }
}

+ (void)destroyinstance{
    instance=nil;
}

+ (iLMSLoggedinUser *)getSharedinstance{
    return instance;
}

- (id)initWithArray:(NSArray *)array withRemeberMeOptionOn:(BOOL)isOn{
    if(self=[super init]){
        
        @try {
            NSString *status=[[array objectAtIndex:0] objectForKey:@"text"];
            if(status   && [status caseInsensitiveCompare:@"true"]==NSOrderedSame){
                self.loginSuccess=YES;
                self.custID=[[array objectAtIndex:1] objectForKey:@"text"];
                self.userName=[[array objectAtIndex:2] objectForKey:@"text"];
                self.userPassword   =[[array objectAtIndex:3] objectForKey:@"text"];
                self.userType=[[array objectAtIndex:4] objectForKey:@"text"];
                self.userID=[[array objectAtIndex:5] objectForKey:@"text"];
                
                if(isOn){
                    [RememberMe saveUserArray:array forKey:kUserData];
                }
            }else{
                self.loginSuccess=NO;
                
                [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Login Failed" delegate:nil cancelButtonTitle:@"Calcel" otherButtonTitles: nil] show];
            }
        }
        @catch (NSException *exception) {
            self.loginSuccess=NO;

            [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Login Failed" delegate:nil cancelButtonTitle:@"Calcel" otherButtonTitles: nil] show];

        }
        @finally {
        }
        
    }
    return self;
}



@end
