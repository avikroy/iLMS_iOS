//
//  TestDetailsViewController.m
//  iLMS
//
//  Created by Debasish on 28/05/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "TestDetailsViewController.h"
#import "ViewReportCell.h"
#import "UIImage+Resize.h"


@interface TestDetailsViewController ()<MBProgressHUDDelegate>
{
    NSArray *arrTitle,*arrKeys;
    NSDictionary *dictResult;
}
@property (nonatomic, retain) MBProgressHUD *HUD;

@end

@implementation TestDetailsViewController

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
    self.headerView.layer.cornerRadius=3.0;
    arrTitle=[[NSArray alloc]initWithObjects:@"Sample no.",@"Unit name",@"Compartment",@"OilName",@"Severity",@"Sample Date",@"SMU",@"OilHrs",@"Oil  Changed",nil];
    self.tableTestDetails.separatorColor=[UIColor clearColor];
    self.tableTestDetails.separatorStyle    = UITableViewCellSeparatorStyleSingleLine;
    [self searchElement];
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    
    if ([self.tableTestDetails respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableTestDetails setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrKeys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewReportCell *cell=nil;
    NSArray *nib=nil;
    
    nib=[[ NSBundle  mainBundle]loadNibNamed:@"ViewReportCell" owner:self options:nil];
    
    cell=(ViewReportCell*)[nib objectAtIndex:0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSString *cellText=@"";
//    NSRange rangeValue = [cellText rangeOfString:@"_X0020_" options:NSCaseInsensitiveSearch];

//    BOOL found = ( rangeValue.location != NSNotFound );
//    if(found){
//        
//    }else{
//        
//    }
    cellText=[[NSString stringWithFormat:@"  %@",[arrKeys objectAtIndex:indexPath.row] ] stringByReplacingOccurrencesOfString:@"x0020" withString:@" "];
    cellText=[cellText stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    cellText=[cellText stringByReplacingOccurrencesOfString:@"  " withString:@" "];

//    cellText=[[NSString stringWithFormat:@"  %@",[[arrKeys objectAtIndex:indexPath.row] capitalizedString]] stringByReplacingOccurrencesOfString:@"X0020" withString:@" "];
    
    cell.lblTitle.text=[cellText capitalizedString];
    cell.lblSubTitle.text=[[[dictResult objectForKey:[arrKeys objectAtIndex:indexPath.row]] objectForKey:@"text"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([[cell.lblSubTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        cell.lblSubTitle.text=@"0";
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    CGRect framelbltitle=cell.lblTitle.frame;
    framelbltitle.size.width=170;
    cell.lblTitle.frame=framelbltitle;
    
    framelbltitle=cell.lblSubTitle.frame;
    framelbltitle.origin.x=175;
    framelbltitle.size.width=110;
    cell.lblSubTitle.frame=framelbltitle;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - action selector

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}

#pragma mark - network connection

- (void)searchElement{
    [self showHUD];
    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager sampleElementDetailsWithID:self.strElementID] Action:[RequestAction returnSampleElementAction] API:[RequestManager returnAPI_URL]];
}

- (void)responseSuccess:(id)response{
    [self hideHUD];
    if([response isKindOfClass:[NSDictionary class]]){
        NSDictionary *responseDict=[[[[(NSDictionary *)response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"WP7FetchSampleElementDetailsResponse"] objectForKey:@"WP7FetchSampleElementDetailsResult"] ;
        NSDictionary *finalDict=[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL];
        id object=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
        if([object isKindOfClass:[NSArray class]]){
            arrTitle=(NSMutableArray *)object;
        }else if([object isKindOfClass:[NSDictionary class]]){
            arrKeys=[object allKeys ];
            arrTitle=[[NSMutableArray alloc] initWithObjects:object , nil];
            dictResult=(NSDictionary *)object;
        }
        [self.tableTestDetails reloadData];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"There is no data to be shown" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
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
