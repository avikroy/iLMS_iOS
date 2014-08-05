//
//  iLMSAppDelegate.h
//  iLMS
//
//  Created by Avik Roy on 5/22/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLMSViewController;
@class iLMSSearchSamples;

@interface iLMSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) iLMSViewController *viewController;
@property(nonatomic, retain) UINavigationController *localNavigation;
@property (nonatomic, retain) iLMSSearchSamples *samples;
@property (nonatomic, retain) NSString *deviceToken;

- (void)logoutAction;

@end
