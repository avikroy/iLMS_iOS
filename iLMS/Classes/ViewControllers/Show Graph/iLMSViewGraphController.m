//
//  iLMSViewGraphController.m
//  iLMS
//
//  Created by Avik Roy on 6/1/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSViewGraphController.h"

@interface iLMSViewGraphController ()

@end

@implementation iLMSViewGraphController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lblGraphName.text=self.strGraphNames;
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    self.headerView.layer.cornerRadius=3.0;

    NSString* url = self.strURL;
    
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    self.webview.scalesPageToFit=YES;
    [self.webview loadRequest:request];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated    {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - selector action

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - roatation
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//}
//
//- (BOOL)shouldAutorotate
//{
//    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
//    return UIInterfaceOrientationIsLandscape(deviceOrientation);
//}

@end
