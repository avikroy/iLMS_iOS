//
//  ViewReportViewController.m
//  iLMS
//
//  Created by Debasish on 28/05/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "ViewReportViewController.h"
#import "ViewReportCell.h"
#import "iLMSSearchSamples.h"
#import "TestDetailsViewController.h"
#import "UIImage+Resize.h"

@interface ViewReportViewController ()
{
    
}
@end

@implementation ViewReportViewController

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
    iLMSAppDelegate *app=APP_DELEGATE;
    [app setSamples:self.samples];
      
    self.arrTitle=[[NSMutableArray alloc]initWithObjects:@"Plant ID.",@"Unit name",@"Compartment",@"Oil Name",@"Severity",@"Sample Date",@"SMU",@"Oil Hrs",@"Oil Changed",@"Lab Comments",@"Attention",nil];
    self.arrSubtitle=[[NSMutableArray alloc] init ];
    
    @try {
        if(self.samples.SampleNo) [self.arrSubtitle addObject:self.samples.SampleNo];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.UnitName) [self.arrSubtitle addObject:self.samples.UnitName];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.Compartment) [self.arrSubtitle addObject:self.samples.Compartment];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.OilName) [self.arrSubtitle addObject:self.samples.OilName];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.Severity) [self.arrSubtitle addObject:self.samples.Severity];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.SampleDate) [self.arrSubtitle addObject:self.samples.SampleDate];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.SMU) [self.arrSubtitle addObject:self.samples.SMU];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.OilHrs) [self.arrSubtitle addObject:self.samples.OilHrs];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.OilChanged) [self.arrSubtitle addObject:self.samples.OilChanged];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.LabComment) [self.arrSubtitle addObject:self.samples.LabComment];
        else [self.arrSubtitle addObject:@""];
        
        if(self.samples.Attention) [self.arrSubtitle addObject:self.samples.Attention];
        else [self.arrSubtitle addObject:@""];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    

    if ([self.tableViewdetails respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableViewdetails setSeparatorInset:UIEdgeInsetsZero];
    }

//                      WithObjects:,self.samples.UnitName,self.samples.Compartment,self.samples.OilName,self.samples.Severity,self.samples.SampleDate,self.samples.SMU,self.samples.OilHrs,self.samples.OilChanged,self.samples.LabComment,self.samples.Attention, nil];
    
    self.tableViewdetails.separatorColor=[UIColor clearColor];
    self.tableViewdetails.separatorStyle    = UITableViewCellSeparatorStyleSingleLine;
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==9){
        return 110;
    }
    return 47;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewReportCell *cell=nil;
    NSArray *nib=nil;
    
    nib=[[ NSBundle  mainBundle]loadNibNamed:@"ViewReportCell" owner:self options:nil];
    
    cell=(ViewReportCell*)[nib objectAtIndex:0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.lblTitle.text=[NSString stringWithFormat:@"  %@",[self.arrTitle objectAtIndex:indexPath.row]];
    
    cell.lblSubTitle.text=[self.arrSubtitle objectAtIndex:indexPath.row];
    cell.lblSubTitle.numberOfLines=0;
    if(indexPath.row==9){
        CGRect framelblTitle=cell.lblTitle.frame;
        framelblTitle.size.height=108;
        cell.lblTitle.frame=framelblTitle;
        
        CGRect framelblSubTitle=cell.lblSubTitle.frame;
        framelblSubTitle.size.height=108;
        cell.lblSubTitle.frame=framelblSubTitle;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -selector action

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)testDetailsAction:(id)sender {
    TestDetailsViewController *aController=[[TestDetailsViewController alloc] initWithNibName:@"TestDetailsViewController" bundle:nil];
    aController.strElementID=self.samples.SampleID;
    [self.navigationController pushViewController:aController animated:YES];
}

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}


@end
