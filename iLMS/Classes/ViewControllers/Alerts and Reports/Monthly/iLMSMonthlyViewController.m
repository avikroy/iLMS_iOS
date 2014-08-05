//
//  iLMSMonthlyViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/28/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSMonthlyViewController.h"
#import "iLMSSearchSamples.h"
#import "UIImage+Resize.h"

@interface iLMSMonthlyViewController ()<MBProgressHUDDelegate>
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSMutableArray *sampleArray;
@end

@implementation iLMSMonthlyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerView.layer.cornerRadius=3.0;
    
    self.navigationItem.titleView=self.navigationHeader;
    UIImage *logoImage=[ UIImage imageWithImage:[UIImage imageNamed:@"login.png"] scaledToSize:CGSizeMake(30, 30)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:logoImage]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];

    self.sampleArray=[[NSMutableArray alloc] init];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    self.datePicker.hidden=YES;
    self.toolPicker.hidden=YES;
    self.datePicker   .datePickerMode=UIDatePickerModeDate;
    self.txtYear.text=[self getFormattedDate:[NSDate date]];
    [self createHUD];
    [self searchForYear:self.txtYear.text];
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - network connection

- (void)searchForYear:(NSString *)strYear{
    [self showHUD];
    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager getMonthlySampleChartWithText:strYear] Action:[RequestAction returnMonthlySampleAction] API:[RequestManager returnAPI_URL]];
}

- (void)responseSuccess:(id)response{
    [self hideHUD];
    if([response isKindOfClass:[NSDictionary class]]){
//        
        NSDictionary *responseDict=[[[[(NSDictionary *)response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"WP7FetchSearchDetailsResponse"] objectForKey:@"WP7FetchSearchDetailsResult"] ;
        NSDictionary *finalDict=[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL];

        NSArray *sapleArray=nil;
        id responseObject=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
        if([responseObject  isKindOfClass:[NSArray class]]){
            sapleArray=(NSArray *)responseObject;
        }else  if([responseObject  isKindOfClass:[NSDictionary class]]){
            sapleArray=[NSArray arrayWithObject:(NSDictionary *)responseObject];
        }
       
        
        [self getCountForMonth:@"Jan" forLabel:self.lblJan inArray:sapleArray];
        [self getCountForMonth:@"Feb" forLabel:self.lblFeb inArray:sapleArray];
        [self getCountForMonth:@"Mar" forLabel:self.lblMarch inArray:sapleArray];
        [self getCountForMonth:@"Apr" forLabel:self.lblApr inArray:sapleArray];
        [self getCountForMonth:@"May" forLabel:self.lblMay inArray:sapleArray];
        
        [self getCountForMonth:@"Jun" forLabel:self.lblJun inArray:sapleArray];
        [self getCountForMonth:@"Jul" forLabel:self.lblJuly inArray:sapleArray];
        [self getCountForMonth:@"Aug" forLabel:self.lblAug inArray:sapleArray];
        [self getCountForMonth:@"Sep" forLabel:self.lblSept inArray:sapleArray];
        [self getCountForMonth:@"Oct" forLabel:self.lbloct inArray:sapleArray];
        
        [self getCountForMonth:@"Nov" forLabel:self.lblNov inArray:sapleArray];
        [self getCountForMonth:@"Dec" forLabel:self.lblDec inArray:sapleArray];
    }
}

- (void)responseFail:(id)response{
    [self hideHUD];
    [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:(NSString *)response delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];}

#pragma mark - custom methodes

- (void)showDatePicker{
    self.toolPicker.hidden=NO;
    self.datePicker.hidden=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.toolPicker.alpha=1;
        self.datePicker.alpha=1;
    }];
}

- (void)hideDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
        self.toolPicker.alpha=0;
        self.datePicker.alpha=0;
        
    } completion:^(BOOL finished){
        self.toolPicker.hidden=YES;
        self.datePicker.hidden=YES;
        
    }];
    
}


- (void)getCountForMonth:(NSString *)mnth forLabel:(UILabel *)lbl inArray:(NSArray *)sapleArray{
    @try {
        lbl.text=@"[ 0 ]";
        for(int i=0;i<[sapleArray count];i++){
            if([sapleArray count]>i ){
                if([[[sapleArray objectAtIndex:i] objectForKey:@"MonthName"] isKindOfClass:[NSDictionary class]]){
                    if([[[[sapleArray objectAtIndex:i] objectForKey:@"MonthName"]objectForKey:@"text"]caseInsensitiveCompare:mnth]==NSOrderedSame){
                        if([[[sapleArray objectAtIndex:i] objectForKey:@"SampleCount"] isKindOfClass:[NSDictionary class]]){
                            lbl.text=[NSString stringWithFormat:@"[ %@ ]",[[[sapleArray objectAtIndex:i] objectForKey:@"SampleCount"] objectForKey:@"text"]];
                        }
                    }
                }
            }
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (NSString *)getFormattedDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy"];//01-jan-2000
    NSString *string = [formatter stringFromDate:date];
    return string;
}

#pragma mark - uitextfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==self.txtYear){
        [self showDatePicker];
    }
    return NO;
}

#pragma mark - selector action

- (IBAction)doneAction:(id)sender {
    [self hideDatePicker];
    [self searchForYear:self.txtYear.text];
}

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dateSelected:(id)sender {
    NSDate *senderDate=(NSDate *)[(UIDatePicker *)sender date];
    self.txtYear.text=[self getFormattedDate:senderDate];
   
}

#pragma mark - roatation

- (NSUInteger)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationPortrait)
    {
        self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 300);
    }
    else
    {
        self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 600);
        
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

@end
