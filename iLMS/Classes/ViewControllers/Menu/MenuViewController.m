//
//  MenuViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/25/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "MenuViewController.h"
#import "DashboardViewController.h"
#import "iLMSSearchViewController.h"
#import "iLMSMonthlyViewController.h"
#import "ViewReportViewController.h"
#import "iLMSSevertyViewController.h"
#import "iLMSTestanalysisViewController.h"
#import "iLMSAlertsReportsViewController.h"
#import "UIImage+Resize.h"

@interface MenuViewController ()
{
    NSMutableArray *arrTitle,*arrSubTitle,*arrImg;
}
@end

@implementation MenuViewController


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
    self.navigationItem.titleView=self.navigatioHeader;
    UIImage *logoImage=[ UIImage imageWithImage:[UIImage imageNamed:@"login.png"] scaledToSize:CGSizeMake(30, 30)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:logoImage]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    //backgroundDashboard.png
    self.headerView.layer.cornerRadius=3.0;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundDashboard.png"]];

    
//    arrTitle=[[NSMutableArray alloc]initWithObjects:@"My Dashboard",@"Search Samples",@"Last Viewed Sample",@"Samples Severity",@"Test Analysis",@"Alerts & Reports",@"Settings",nil];
//    arrSubTitle=[[NSMutableArray alloc]initWithObjects:@"Tap here to view your Dashboard",@"Tap to search samples",@"Tap to view details of last viewed samples",@"Tap to navigate to samples severity list",@"Tap here to navigate to test analysis criteria",@"Tap to navigate in system reports",@"Tap to navigate to system settings",nil];
//    arrImg=[[NSMutableArray alloc]initWithObjects:@"AnalyzeReport",@"Search",@"ViewReport",@"SampleInPriority",@"TestAnalysis",@"AlertsnReports",@"settings",nil];
    
    arrTitle=[[NSMutableArray alloc]initWithObjects:@"My Dashboard",@"Search Samples",@"Last Viewed Sample",@"Samples Severity",@"Alerts & Reports",nil];
    arrSubTitle=[[NSMutableArray alloc]initWithObjects:@"Tap here to view your Dashboard",@"Tap to search samples",@"Tap to view details of last viewed samples",@"Tap to navigate to samples severity list",@"Tap to navigate in system reports",nil];
    arrImg=[[NSMutableArray alloc]initWithObjects:@"AnalyzeReport",@"Search",@"ViewReport",@"SampleInPriority",@"AlertsnReports",nil];
    
    
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    
    if ([self.tableMenu respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableMenu setSeparatorInset:UIEdgeInsetsZero];
    }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    @try {
        

        if([iLMSCommon isiPad]){
            cell.textLabel.text=[arrTitle objectAtIndex:indexPath.row];
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
            cell.detailTextLabel.text=[arrSubTitle objectAtIndex:indexPath.row];
            cell.detailTextLabel.textColor=[UIColor whiteColor];
            cell.detailTextLabel.font=[UIFont italicSystemFontOfSize:13];
            cell.imageView.image=[UIImage imageNamed:[arrImg objectAtIndex:indexPath.row]];
        }else{
            cell.textLabel.text=[arrTitle objectAtIndex:indexPath.row];
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.textLabel.font=[UIFont boldSystemFontOfSize:13];
            cell.detailTextLabel.text=[arrSubTitle objectAtIndex:indexPath.row];
            cell.detailTextLabel.textColor=[UIColor whiteColor];
            cell.detailTextLabel.font=[UIFont italicSystemFontOfSize:11];
            cell.imageView.image=[ UIImage imageWithImage:[UIImage imageNamed:[arrImg objectAtIndex:indexPath.row]] scaledToSize:CGSizeMake(40, 40)];
        }
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    }
    
    
    
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(76.0/255.0) green:(161.0/255.0) blue:(255.0/255.0) alpha:1.0]; // perfect color suggested by @mohamadHafez
    bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.contentView.backgroundColor=[UIColor clearColor];
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
    @try {
        if(indexPath.row==0){
            DashboardViewController *aController=[[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];
            [self.navigationController pushViewController:aController animated:YES];
        }else if(indexPath.row==1){
            iLMSSearchViewController *aController=[[iLMSSearchViewController alloc] initWithNibName:@"iLMSSearchViewController" bundle:nil];
            [self.navigationController pushViewController:aController animated:YES];
            
        }else if(indexPath.row==2){
            
            iLMSAppDelegate *app=APP_DELEGATE;
            if([app samples]){
                ViewReportViewController   *aController=[[ViewReportViewController alloc] initWithNibName:@"ViewReportViewController" bundle:nil];
                aController.samples=[app samples];
                [self.navigationController pushViewController:aController animated:YES];
            }else{
                [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:@"There is no data to be shown" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            }
            
        }else if(indexPath.row==3){
            iLMSSevertyViewController *aController=[[iLMSSevertyViewController alloc] initWithNibName:@"iLMSSevertyViewController" bundle:nil];
            [self.navigationController pushViewController:aController animated:YES];
            
        }else if(indexPath.row==5){
            iLMSTestanalysisViewController *aController=[[iLMSTestanalysisViewController alloc] initWithNibName:@"iLMSTestanalysisViewController" bundle:nil];
            [self.navigationController pushViewController:aController animated:YES];
            
        }else if(indexPath.row==4){
            iLMSAlertsReportsViewController *aController=[[iLMSAlertsReportsViewController alloc] initWithNibName:@"iLMSAlertsReportsViewController" bundle:nil];
            [self.navigationController pushViewController:aController animated:YES];
            
        }else if(indexPath.row==6){
            
        }

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma mark - selector action

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}

@end
