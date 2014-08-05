//
//  iLMSViewGraphController.h
//  iLMS
//
//  Created by Avik Roy on 6/1/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSViewGraphController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UILabel *lblGraphName;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, strong) NSString *strURL,*strGraphNames;

- (IBAction)logoutAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
