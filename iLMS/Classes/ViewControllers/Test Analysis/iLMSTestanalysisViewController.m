//
//  iLMSTestanalysisViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/30/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSTestanalysisViewController.h"
#import "iLMSTestAnalysisChartViewController.h"
#import "UIImage+Resize.h"

@interface iLMSTestanalysisViewController ()<MBProgressHUDDelegate>{
    NSInteger selectedIndex;
}
@property (nonatomic, retain) NSArray *pickerArray,*pickerServiceArray;
@property (nonatomic, retain) NSString *selectedSearchText;
@property (nonatomic, retain) MBProgressHUD *HUD;
@end

@implementation iLMSTestanalysisViewController

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
    self.navigationItem.titleView=self.naivgationHeader;
    UIImage *logoImage=[ UIImage imageWithImage:[UIImage imageNamed:@"login.png"] scaledToSize:CGSizeMake(30, 30)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:logoImage]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.headerView.layer.cornerRadius=3.0;
    [self createHUD];

    [self initializePicker];
    self.selectedSearchText=@"";
    selectedIndex=0;
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
    self.toolPicker.hidden=YES;
    self.pickerTestName.hidden=YES;
    self.pickerTestName.hidden=YES;
    self.toolPicker.alpha=0;
    self.pickerTestName.alpha=0;
    [self getTestTypes];
    
//    self.pickerArray=@[@"   --select search field--",@"   Aluminium(ppm)",@"   Boron(ppm)",@"  Calcium(ppm)",@"  Chromium(ppm)",@"  Copper(ppm)",@"  Fuel Dilution(%)",@"  Glycol(%)",@"  Iron(ppm)",@"   ISO 4406 Level",@"   Lead(ppm)",@"  Magnesium(ppm)",@"  Molybdenum(ppm)",@"  Nickel(ppm)",@"  Nitration(x. 100)abs/",@"  Oxidation(x. 100)abs/",@"  Phosphorus(ppm)",@"   PQ-90",@"  Silicon(ppm)",@"  Sodium(ppm)",@"  Soot(abs/cm)",@"  Suiphation(x. 100)abs/",@"  TAN(mgKOH/Kg)",@"  TBN(mgKOH/Kg)",@"  Tin(ppm)",@"  Total Particle Count",@"  Visc @ 40 OC (cST)",@"  Visc @ 100 OC (cST)",@"  Water(%)",@"  Zinc(ppm)"];
//    self.pickerServiceArray=@[@"--select search field--",@"Aluminium",@"Boron",@"Calcium",@"Chromium",@"Copper",@"FuelDilution",@"Glycol",@"Iron",@"ISO4406Level",@"Lead",@"Magnesium",@"Molybdenum",@"Nickel",@"Nitration",@"Oxidation",@"Phosphorus",@"PQ-90",@"Silicon",@"Sodium",@"Soot",@"Suiphation",@"  TAN",@"TBN",@"Tin",@"TotalParticleCount",@"Visc@40",@"Visc@100",@"Water",@"Zinc"];
    
    [[self pickerTestName] reloadAllComponents];
    
}

- (void)showPicker{
    self.toolPicker.hidden=NO;
    self.pickerTestName.hidden=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.toolPicker.alpha=1;
        self.pickerTestName.alpha=1;
    }];
}

- (void)hidePicker{
    [UIView animateWithDuration:0.3 animations:^{
        self.toolPicker.alpha=0;
        self.pickerTestName.alpha=0;
        
    } completion:^(BOOL finished){
        self.toolPicker.hidden=YES;
        self.pickerTestName.hidden=YES;
        
    }];
    
}

- (void)moveToChart{
    iLMSTestAnalysisChartViewController *aController=[[iLMSTestAnalysisChartViewController alloc] initWithNibName:@"iLMSTestAnalysisChartViewController" bundle:nil];
    aController.selectedText=self.selectedSearchText    ;
    aController.strAnalysisType=[NSString stringWithFormat:@"   %@",[[[self.pickerArray objectAtIndex:selectedIndex] objectForKey:@"ListText"] objectForKey:@"text"]];
    [self.navigationController pushViewController:aController animated:YES];
}

#pragma mark -selector action

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDrpDwnAction:(id)sender {
    [self showPicker    ];
}

- (IBAction)showAction:(id)sender {
    [self moveToChart];
}

- (IBAction)doneAction:(id)sender {
    [self hidePicker];
}

#pragma mark - picker datasource

- (NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger )pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[[[self.pickerArray objectAtIndex:row] objectForKey:@"ListText"] objectForKey:@"text"] stringByTrimmingLeadingAndTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (CGFloat )pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

#pragma mark - picker delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedIndex=row;
    self.selectedSearchText=[[[self.pickerArray objectAtIndex:row] objectForKey:@"ListID"] objectForKey:@"text"];
    [self.btnDrpDwn setTitle:[NSString stringWithFormat:@"   %@",[[[self.pickerArray objectAtIndex:row] objectForKey:@"ListText"] objectForKey:@"text"]]forState:UIControlStateNormal];
    
}

#pragma mark - network connection

- (void)getTestTypes{
    [self showHUD];
    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager testDetailsTest] Action:[RequestAction returnTestDetailsTestAction] API:[RequestManager returnAPI_URL]];
}

- (void)responseSuccess:(id)response{
    [self hideHUD];
    if([response isKindOfClass:[NSDictionary class]]){
        NSDictionary *responseDict=[[[[(NSDictionary *)response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"WP7GetTestDetailsTestResponse"] objectForKey:@"WP7GetTestDetailsTestResult"] ;
        NSDictionary *finalDict=[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL];
        if(finalDict){
            NSLog(@"%@",[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL]);
            self.pickerArray=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
            [self.pickerTestName reloadAllComponents];
            
//            for(int count=0;count<[sapleArray count];count++){
//                iLMSSearchSamples *aSample=[[iLMSSearchSamples alloc] initWithDictionary:[sapleArray objectAtIndex:count]];
//                [self.sampleArray addObject:aSample];
//            }
            
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

@end
