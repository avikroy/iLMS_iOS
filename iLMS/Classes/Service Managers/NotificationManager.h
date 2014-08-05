//
//  NotificationManager.h
//  iLMS
//
//  Created by Avik on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFY_LOGIN @"kNotifyLogin"


@interface NotificationManager : NSObject
+ (void)registerNotificationWithTarget:(id)_target selector:(SEL)_selector name:(NSString *)notificationname;
+ (void)unregisterNotificationWithTarget:(id)_target  name:(NSString *)notificationname;
@end
