//
//  iLMSViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/22/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UISwitch *switchRemberMe;

- (IBAction)btnActionLogin:(id)sender;
- (IBAction)rememberMeAction:(id)sender;

@end
