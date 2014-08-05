//
//  iLMSSearchViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/26/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSSearchViewController.h"
#import "iLMSSearchSamples.h"
#import "iLMSSearhResultViewController.h"
#import "UIImage+Resize.h"

#define SELECT_CRITERIA @"--Select Criteria--"

@interface iLMSSearchViewController() <MBProgressHUDDelegate>
{
    NSInteger selectedIndex,selectedIndexAction;
}
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSArray *pickerArray,*pickerValueArray;;
@property (nonatomic, retain) NSString *selectedSearchText,*selectedActionText;
@property (nonatomic, retain) NSMutableArray *sampleArray;
@property (nonatomic, retain) UITextField *referenceTextField;

@end

@implementation iLMSSearchViewController

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
    self.navigationItem.titleView=self.navigationHeader;
    UIImage *logoImage=[ UIImage imageWithImage:[UIImage imageNamed:@"login.png"] scaledToSize:CGSizeMake(30, 30)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:logoImage]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    self.headerView.layer.cornerRadius=3.0;
    
    CGRect frame = self.txtSearchValue.frame;
    frame.size.height=41;
    self.txtSearchValue.frame=frame;

    frame = self.txtSearchValue2.frame;
    frame.size.height=41;
    self.txtSearchValue2.frame=frame;

    [self createHUD];
    [self initializePicker];
    self.txtSearchValue.text=@"";
    self.txtSearchValue2.text=@"";
    self.selectedActionText=[NSString stringWithFormat:@"%d",0];
    selectedIndex=0;
    [self setViewLauyout];
    self.sampleArray=[[NSMutableArray alloc] init];
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom methodes

- (void)initializePicker{
    self.datePickerSearch.backgroundColor = [UIColor whiteColor];
    self.toolDrpDwn.hidden=YES;
    self.pickerDrpDwn.hidden=YES;
    self.datePickerSearch.hidden=YES;
    self.toolDrpDwn.alpha=0;
    self.pickerDrpDwn.alpha=0;
    self.datePickerSearch.alpha=0;
    self.datePickerSearch   .datePickerMode=UIDatePickerModeDate;

    self.pickerArray=@[SELECT_CRITERIA,@"   Plant ID",@"   Compartment",@"   Sampled Date",@"  Severity"];
    self.pickerValueArray=@[SELECT_CRITERIA,@"   Equipment ID",@"   Compartment",@"   Sampled Date",@"  Severity"];

    selectedIndex=0;
    self.selectedSearchText=SELECT_CRITERIA;
                             
    [self.mainScroll addSubview:self.btnShow];

}

- (void)showPicker{
    self.toolDrpDwn.hidden=NO;
    self.pickerDrpDwn.hidden=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.toolDrpDwn.alpha=1;
        self.pickerDrpDwn.alpha=1;
    }];
}

- (void)hidePicker{
    [UIView animateWithDuration:0.3 animations:^{
        self.toolDrpDwn.alpha=0;
        self.pickerDrpDwn.alpha=0;

    } completion:^(BOOL finished){
        self.toolDrpDwn.hidden=YES;
        self.pickerDrpDwn.hidden=YES;
  
    }];
    
}

- (void)showDatePicker{
    self.toolDrpDwn.hidden=NO;
    self.datePickerSearch.hidden=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.toolDrpDwn.alpha=1;
        self.datePickerSearch.alpha=1;
    }];
}

- (void)hideDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
        self.toolDrpDwn.alpha=0;
        self.datePickerSearch.alpha=0;
        
    } completion:^(BOOL finished){
        self.toolDrpDwn.hidden=YES;
        self.datePickerSearch.hidden=YES;
        
    }];
    
}


#pragma mark - custom methodes

- (void)setViewLauyout{
    if(selectedIndex==0){
        self.txtSearchValue.hidden=YES;
        self.txtSearchValue1Title.hidden=YES;
        self.btnAction.hidden=YES;
        self.txtSearchValue2.hidden=YES;
        self.txtSearchValue2Title.hidden=YES;
    }else if(selectedIndex==1){
        self.txtSearchValue.hidden=NO;
        self.txtSearchValue1Title.hidden=NO;
        self.txtSearchValue1Title.text=@"Search Value";
        self.btnAction.hidden=YES;
        self.txtSearchValue2.hidden=YES;
        self.txtSearchValue2Title.hidden=YES;
    }else if(selectedIndex==2){
        self.txtSearchValue.hidden=NO;
        self.txtSearchValue1Title.hidden=NO;
        self.txtSearchValue1Title.text=@"Search Value";
        self.btnAction.hidden=YES;
        self.txtSearchValue2.hidden=YES;
        self.txtSearchValue2Title.hidden=YES;
    }else if(selectedIndex==3){
        self.txtSearchValue.hidden=NO;
        self.txtSearchValue1Title.hidden=NO;
        self.txtSearchValue1Title.text=@"From Date";
        self.txtSearchValue2Title.text=@"To Date";
        self.btnAction.hidden=YES;
        self.txtSearchValue2.hidden=NO;
        self.txtSearchValue2Title.hidden=NO;
    }else if(selectedIndex==4){
        self.txtSearchValue.hidden=YES;
        self.txtSearchValue1Title.hidden=YES;
        self.btnAction.hidden=NO;
        self.txtSearchValue2.hidden=YES;
        self.txtSearchValue2Title.hidden=YES;
    }
    
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight || [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft)
    {
        CGRect frame=self.btnShow.frame;
        CGRect frame_scroll=self.mainScroll.frame;
        if(selectedIndex==1){
            frame.origin.y=210;
            frame_scroll.size.height=170;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 300);

        }else if(selectedIndex==2){
            frame.origin.y=210;
            frame_scroll.size.height=170;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 300);
            
        }else if(selectedIndex==3){
            frame.origin.y=280;
            frame_scroll.size.height=300;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 430);
            
        }else if(selectedIndex==4){
            frame.origin.y=230;
            frame_scroll.size.height=300;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 400);
            
        }
        self.btnShow.frame=frame;
        self.mainScroll.frame=frame_scroll;
    }
    else
    {
        CGRect frame=self.btnShow.frame;
        CGRect frame_scroll=self.mainScroll.frame;
        if(selectedIndex==1){
            frame.origin.y=210;
            frame_scroll.size.height=250;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 250);
            
        }else if(selectedIndex==2){
            frame.origin.y=210;
            frame_scroll.size.height=250;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 250);
            
        }else if(selectedIndex==3){
            frame.origin.y=280;
            frame_scroll.size.height=350;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 350);
            
        }else if(selectedIndex==4){
            frame.origin.y=230;
            frame_scroll.size.height=300;
            self.mainScroll.contentSize=CGSizeMake(self.mainScroll.frame.size.width, 300);
            
        }
        self.btnShow.frame=frame;
        self.mainScroll.frame=frame_scroll;

    }

}

- (NSString *)getFormattedDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"dd-MMM-yyyy"];//01-jan-2000
    NSString *string = [formatter stringFromDate:date];
    return string;
}

#pragma mark - selector

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectSearchFiedlAcrion:(id)sender {
    self.pickerDrpDwn.tag=1;
    self.pickerArray=@[SELECT_CRITERIA,@"   Plant ID",@"   Compartment",@"   Sampled Date",@"  Severity"];
    [self showPicker];
    [self.pickerDrpDwn reloadAllComponents];
    [self.pickerDrpDwn selectRow:selectedIndex inComponent:0 animated:NO];
}

- (IBAction)selectAction:(id)sender {
    selectedIndexAction=0;
    self.pickerDrpDwn.tag=2;
    self.pickerArray=@[@"   Normal",@"   Warning",@"   Action"];
    [self showPicker];
    [self.pickerDrpDwn reloadAllComponents];
    self.selectedActionText=[NSString stringWithFormat:@"%d",0];
    [self.pickerDrpDwn selectRow:selectedIndexAction inComponent:0 animated:NO];
}

- (IBAction)doneAction:(id)sender {
    [self hideDatePicker];
    [self hidePicker];
    
}

- (IBAction)showAction:(id)sender {
    if(selectedIndex==1){
        [self search];
    }else if(selectedIndex==2){
        [self search];
    }else if(selectedIndex==3){
        [self searchDate];
    }else{
        [self searchSeverity];
    }
    
}

- (IBAction)dateSelectedAction:(id)sender {
    
    NSDate *senderDate=(NSDate *)[(UIDatePicker *)sender date];
    self.referenceTextField.text=[self getFormattedDate:senderDate];
    
}

#pragma mark - uitextfied delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(selectedIndex==3){
        self.referenceTextField=textField;
        [self showDatePicker];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField   {
    if(selectedIndex==0 || selectedIndex==1){
        if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight || [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft){
            [UIView animateWithDuration:0.3 animations:^{
                self.mainScroll.contentOffset=CGPointMake(0, 110);
                
            }];
        }else{
            
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - picker datasource

- (NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger )pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.pickerArray objectAtIndex:row] stringByTrimmingLeadingAndTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (CGFloat )pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

#pragma mark - picker delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag==1){
        selectedIndex=row;
        self.selectedSearchText=[[self.pickerValueArray objectAtIndex:row] stringByTrimmingLeadingAndTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.btnDrpDwn setTitle:[NSString stringWithFormat:@"   %@",[self.pickerArray objectAtIndex:row]]forState:UIControlStateNormal];
        self.txtSearchValue.text=@"";
        self.txtSearchValue2.text=@"";
        [self setViewLauyout];
    }else{
        selectedIndexAction=row;
        self.selectedActionText=[NSString stringWithFormat:@"%ld",(long)row];
        [self.btnAction setTitle:[NSString stringWithFormat:@"   %@",[self.pickerArray objectAtIndex:row]]forState:UIControlStateNormal];
    }
    
    
}

#pragma mark - network connection

- (void)search{
    if([self.selectedSearchText isEqualToString:SELECT_CRITERIA]){
        [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Please select a criteria" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    [self showHUD];

    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager generlSearchRequestWithCriteria:self.selectedSearchText searchText:self.txtSearchValue.text additionalSearchText:@""] Action:[RequestAction returnGeneralSearchAction] API:[RequestManager returnAPI_URL]];
}

- (void)searchSeverity{
    if([self.selectedSearchText isEqualToString:SELECT_CRITERIA]){
        [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Please select a criteria" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    [self showHUD];

    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager generlSearchRequestWithCriteria:self.selectedSearchText searchText:self.selectedActionText additionalSearchText:@""] Action:[RequestAction returnGeneralSearchAction] API:[RequestManager returnAPI_URL]];
}


- (void)searchDate{
    if([self.selectedSearchText isEqualToString:SELECT_CRITERIA]){
        [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"Please select a criteria" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    [self showHUD];

    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager generlSearchRequestWithCriteria:self.selectedSearchText searchText:self.txtSearchValue.text additionalSearchText:self.txtSearchValue2.text] Action:[RequestAction returnGeneralSearchAction] API:[RequestManager returnAPI_URL]];
}

- (void)responseSuccess:(id)response{
    [self hideHUD];
    if([response isKindOfClass:[NSDictionary class]]){
        NSDictionary *responseDict=[[[[(NSDictionary *)response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"WP7FetchSearchDetailsResponse"] objectForKey:@"WP7FetchSearchDetailsResult"] ;
        NSDictionary *finalDict=[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL];
        if(finalDict){
            NSLog(@"%@",[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL]);
            
            id result=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
            if([result isKindOfClass:[NSDictionary class]])
            {
                self.sampleArray=[[NSMutableArray alloc] init];
                iLMSSearchSamples *aSample=[[iLMSSearchSamples alloc] initWithDictionary:result];
                [self.sampleArray addObject:aSample];
                
            }
            else
            {
                self.sampleArray=[[NSMutableArray alloc] init];
                NSArray *sapleArray=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
                
                for(int count=0;count<[sapleArray count];count++){
                    iLMSSearchSamples *aSample=[[iLMSSearchSamples alloc] initWithDictionary:[sapleArray objectAtIndex:count]];
                    [self.sampleArray addObject:aSample];
                }
            }
            iLMSSearhResultViewController *aController=[[iLMSSearhResultViewController alloc] initWithNibName:@"iLMSSearhResultViewController" bundle:nil];
            aController.strSearchType=@"Sample Search Result";
            aController.searchArray=self.sampleArray;
            [self.navigationController pushViewController:aController animated:YES];
        }else{
            [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"There is no data to be shown" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
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
    [self setViewLauyout];
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotate
{
    
    return YES;
}


@end
