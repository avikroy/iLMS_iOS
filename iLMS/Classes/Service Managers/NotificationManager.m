//
//  NotificationManager.m
//  iLMS
//
//  Created by Avik on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

+ (void)registerNotificationWithTarget:(id)_target selector:(SEL)_selector name:(NSString *)notificationname{
    [[NSNotificationCenter defaultCenter] addObserver:_target selector:_selector name:notificationname object:nil];
    
}

+ (void)unregisterNotificationWithTarget:(id)_target  name:(NSString *)notificationname{
    [[NSNotificationCenter defaultCenter] removeObserver:_target name:notificationname object:nil];
}

@end
