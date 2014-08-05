//
//  iLMSViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/22/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSViewController.h"
#import "MenuViewController.h"
#import "UIImage+Resize.h"

@interface iLMSViewController ()<MBProgressHUDDelegate>
@property (nonatomic, retain) MBProgressHUD *HUD;
@end

@implementation iLMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createHUD];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"640x960.png"]];
    self.navigationItem.titleView=self.navigationView;
    UIImage *logoImage=[ UIImage imageWithImage:[UIImage imageNamed:@"login.png"] scaledToSize:CGSizeMake(30, 30)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:logoImage]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.txtUserName.text=@"";
    self .txtPassword.text=@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnActionLogin:(id)sender {
    [self login];
//    MenuViewController *menuVC=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
//    [self.navigationController pushViewController:menuVC animated:YES];
}

- (IBAction)rememberMeAction:(id)sender {
    if(self.switchRemberMe.isOn){
        
    }else{
        [RememberMe resetUserArrayForKey:kUserData];
    }
    
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight || [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft){
        [UIView animateWithDuration:0.3 animations:^{
            self.mainScroll.contentOffset=CGPointMake(0, 0);
            
        }];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField   {
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight || [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft){
        [UIView animateWithDuration:0.3 animations:^{
            self.mainScroll.contentOffset=CGPointMake(0, 110);
            
        }];
    }
}


#pragma mark - custom methodes

- (BOOL)isCorrectInput{
    BOOL isCorrect=NO;
    if([[self.txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
        isCorrect=YES;
    }else{
        isCorrect=NO;
        [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Please enter Email" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
        [self.txtUserName becomeFirstResponder  ];
        return isCorrect;
    }
    if([[self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
        isCorrect=YES;
    }else{
        isCorrect=NO;
        [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Please enter Password" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles: nil] show];
        [self.txtPassword becomeFirstResponder  ];

        return isCorrect;
    }
    return isCorrect;
}

#pragma mark - network communication

- (void)login{
    if(![self isCorrectInput]){
                
    }else{
        [self showHUD];

        ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
        [conn callPostMethod:[RequestManager loginRequestForPushWithUserName:self.txtUserName.text password:self.txtPassword.text ] Action:[RequestAction returnLoginForPushAction] API:[RequestManager returnAPI_URL]];

    }
}

- (void)responseSuccess:(id)response{
    [self hideHUD];
    if([response isKindOfClass:[NSDictionary class]]){
        NSLog(@"%@",response);
        iLMSLoggedinUser *aUser=[[iLMSLoggedinUser alloc] initWithArray:[[[[[(NSDictionary *)response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"UserLogin_ForPushNotificationsResponse"] objectForKey:@"UserLogin_ForPushNotificationsResult"] objectForKey:@"string"] withRemeberMeOptionOn:self.switchRemberMe.isOn];
        if(aUser.loginSuccess){
            [iLMSLoggedinUser destroyinstance];
            [iLMSLoggedinUser createSharedInstance:aUser];
            aUser=[iLMSLoggedinUser getSharedinstance];
            
            MenuViewController *menuVC=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            [self.navigationController pushViewController:menuVC animated:YES];
        }
        

        
    }
}

- (void)responseFail:(id)response{
    [self hideHUD];
    [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:(NSString *)response delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

#pragma mark - progress indicator

- (void)createHUD{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    
    _HUD.delegate = self;
    _HUD.labelText = @"Please wait...";
    //HUD.detailsLabelText = @"Please wait...";
    _HUD.square = YES;
}

- (void)showHUD{
    [self.HUD show:YES];
}

- (void)hideHUD{
    [self.HUD hide:YES];
}

#pragma mark - roatation

- (NSUInteger)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationPortrait)
    {
        self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 400);
    }
    else
    {
        self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 400);

#ifdef DEBUG
        NSLog(@"Device rotated in Portrait");
#endif
        
    }
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotate
{
    
    return YES;
}


@end
