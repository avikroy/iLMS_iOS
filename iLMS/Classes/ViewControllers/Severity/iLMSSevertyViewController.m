//
//  iLMSSevertyViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/30/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSSevertyViewController.h"
#import "iLMSSevertyViewController.h"
#import "iLMSSearhResultViewController.h"
#import "iLMSSearchSamples.h"
#import "UIImage+Resize.h"

@interface iLMSSevertyViewController ()<MBProgressHUDDelegate>{
    NSMutableArray *arrTitle,*arrSubTitle,*arrImg;
}
@property (nonatomic, retain) NSString * selectedActionText;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSMutableArray *sampleArray;

@end

@implementation iLMSSevertyViewController

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
    [self createHUD];
    self.sampleArray=[[NSMutableArray alloc] init];
    self.headerView.layer.cornerRadius=3.0;
    arrTitle=[[NSMutableArray alloc]initWithObjects:@"Normal",@"Warning",@"Action",nil];
    arrSubTitle=[[NSMutableArray alloc]initWithObjects:@"Tap to view samples with Normal severity",@"Tap to view samples with Warning severity",@"Tap to view samples with Action severity",nil];
    arrImg=[[NSMutableArray alloc]initWithObjects:@"Unknown",@"Caution",@"Urgent",nil];
//    self.tableSeverity.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    if ([self.tableSeverity respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableSeverity     setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -action selector

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrTitle count];
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.textLabel.text=[arrTitle objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:13];
    cell.detailTextLabel.text=[arrSubTitle objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.font=[UIFont italicSystemFontOfSize:11];
    if([iLMSCommon isiPad]){
        cell.imageView.image=[UIImage imageNamed:[arrImg objectAtIndex:indexPath.row]];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
        cell.detailTextLabel.font=[UIFont italicSystemFontOfSize:13];
    }else{
      cell.imageView.image=[ UIImage imageWithImage:[UIImage imageNamed:[arrImg objectAtIndex:indexPath.row]] scaledToSize:CGSizeMake(40, 40)];  
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(76.0/255.0) green:(161.0/255.0) blue:(255.0/255.0) alpha:1.0]; // perfect color suggested by @mohamadHafez
    bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([iLMSCommon isiPad]){
        return 100;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

#pragma mark - uitableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedActionText=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self searchSeverity];
}

#pragma mark - network connection

- (void)searchSeverity{
    [self showHUD];
    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager generlSearchRequestWithCriteria:@"Severity" searchText:self.selectedActionText additionalSearchText:@""] Action:[RequestAction returnGeneralSearchAction] API:[RequestManager returnAPI_URL]];
}


- (void)responseSuccess:(id)response{
    [self hideHUD];
    if([response isKindOfClass:[NSDictionary class]]){
        NSDictionary *responseDict=[[[[(NSDictionary *)response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"WP7FetchSearchDetailsResponse"] objectForKey:@"WP7FetchSearchDetailsResult"] ;
        NSDictionary *finalDict=[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL];
        if(finalDict){
            NSLog(@"%@",[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL]);
            self.sampleArray=[[NSMutableArray alloc  ] init];
            NSArray *sapleArray=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
            
            for(int count=0;count<[sapleArray count];count++){
                iLMSSearchSamples *aSample=[[iLMSSearchSamples alloc] initWithDictionary:[sapleArray objectAtIndex:count]];
                [self.sampleArray addObject:aSample];
            }
            
            
            iLMSSearhResultViewController *aController=[[iLMSSearhResultViewController alloc] initWithNibName:@"iLMSSearhResultViewController" bundle:nil];
            aController.searchArray=[[NSArray alloc] initWithArray:self.sampleArray];
            if([self.selectedActionText isEqualToString: @"0"]){
                aController.strSearchType=@"Normal";

            }else if([self.selectedActionText isEqualToString: @"1"]){
                aController.strSearchType=@"Warning";

            }else{
                aController.strSearchType=@"Action";

            }
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



@end
