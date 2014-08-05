//
//  iLMSAppDelegate.m
//  iLMS
//
//  Created by Avik Roy on 5/22/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSAppDelegate.h"
#import "iLMSViewController.h"
#import "MenuViewController.h"

@implementation iLMSAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientchanged:) name:UIDeviceOrientationDidChangeNotification object:nil];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self performSelector:@selector(goDownPortrait) withObject:nil afterDelay:0.0];
    self.viewController = [[iLMSViewController alloc] initWithNibName:@"iLMSViewController" bundle:nil];
    self.localNavigation=[[UINavigationController alloc] initWithRootViewController:self.viewController ];
    
    self.window.rootViewController = self.localNavigation;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:139/255. green:201/255. blue:246/255. alpha:1.0]];
    [self.localNavigation.navigationBar setTranslucent:NO];
    
    if([RememberMe getUserArrayForKey:kUserData]){
        iLMSLoggedinUser *aUser=[[iLMSLoggedinUser alloc] initWithArray:[RememberMe getUserArrayForKey:kUserData]  withRemeberMeOptionOn:YES];
        if(aUser.loginSuccess){
            [iLMSLoggedinUser createSharedInstance:aUser];
            aUser=[iLMSLoggedinUser getSharedinstance];
            
            MenuViewController *menuVC=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            [self.localNavigation pushViewController:menuVC animated:NO];
        }
        
    }

     
    [self.window makeKeyAndVisible];
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push Notification Delegate

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"My token is: %@", newToken);
    self.deviceToken=newToken;
    
//    NSUserDefaults *user_defaults = [NSUserDefaults standardUserDefaults];
//    [user_defaults setObject:newToken forKey:@"DeviceToken"];
//    [user_defaults synchronize];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo);
    NSDictionary *dictPush=[userInfo objectForKey:@"response"];
    if ([dictPush valueForKey:@"message"]!= nil &&
        ![[dictPush valueForKey:@"message"] isKindOfClass:[NSNull class]])
    {
        NSString *strPush=[dictPush valueForKey:@"message"];
        if(strPush.length>0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName]
                                                            message:strPush
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}


#pragma mark - custom methodes

- (void)logoutAction {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Are you sure to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm ", nil];
    [alert show];
    //    [iLMSCommon logout];
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self.localNavigation popToRootViewControllerAnimated:YES];
        [RememberMe resetUserArrayForKey:kUserData];

    }else{
        
    }
}

- (void)orientchanged:(id)sender{
    if([[UIDevice currentDevice] orientation]==UIDeviceOrientationPortrait){
        [self performSelector:@selector(goDownPortrait) withObject:nil afterDelay:0.0];
    }else{
        [self performSelector:@selector(goDownHorizontal) withObject:nil afterDelay:0.0];
    }
}


- (void)goDownPortrait{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        self.window.backgroundColor=[UIColor colorWithRed:139/255. green:201/255. blue:246/255. alpha:1.0];
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.origin.y = 20;
        frame.size.height-=20;
        self.window.frame = frame;
    }
    
}

- (void)goDownHorizontal{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        self.window.backgroundColor=[UIColor colorWithRed:139/255. green:201/255. blue:246/255. alpha:1.0];
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.origin.x = 20;
        frame.size.height-=20;
        self.window.frame = frame;
    }
    
}

@end
