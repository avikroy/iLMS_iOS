//
//  iLMSCommon.m
//  iLMS
//
//  Created by Avik Roy on 6/1/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSCommon.h"

@implementation iLMSCommon

+(NSString *)getAppDisplayName{
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    return prodName;
}

+ (BOOL)isiPad{
    if([[UIDevice    currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad){
        return YES;
    }
    return NO;

}

+ (void)logout{
    iLMSAppDelegate *app=APP_DELEGATE;
    [app logoutAction];
}


@end
