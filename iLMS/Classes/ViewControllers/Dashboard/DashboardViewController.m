//
//  DashboardViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/25/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "DashboardViewController.h"
#import "iLMSViewGraphController.h"
#import "AsyncImageView.h"
#import "UIImage+Resize.h"

@interface DashboardViewController ()
@property (nonatomic, retain) NSArray *arrGraphSamples;
@end

@implementation DashboardViewController

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
    self.navigationItem.titleView=self.headerNavigation;
    UIImage *logoImage=[ UIImage imageWithImage:[UIImage imageNamed:@"login.png"] scaledToSize:CGSizeMake(30, 30)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:logoImage]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    self.headerView.layer.cornerRadius=3.0;

    [self getGraph];
//    self.arrGraphSamples= @[@"Chart1",@"Chart2"];
//    self.tableDashboard.separatorStyle=UITableViewCellSeparatorStyleNone;
//    self.tableDashboard.separatorColor=[UIColor clearColor];
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    
    if ([self.tableDashboard respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableDashboard setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrGraphSamples count];
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"CellIdentifier";
    UITableViewCell *cell=nil;
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    ;
    
    @try {
        if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft ||[UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight)
        {
            UIImageView *imageView=[[UIImageView alloc] init];
            imageView.backgroundColor=[UIColor clearColor];
            imageView.frame=CGRectMake(0.0, 0.0, 320, 220);
            [cell.contentView    addSubview:imageView];
            
            UILabel *lblType=[[UILabel alloc] initWithFrame:CGRectMake(4, 0, 400, 30)];
            lblType.text=[[[[self.arrGraphSamples objectAtIndex:indexPath.row] objectForKey:@"string"] objectAtIndex:1] objectForKey:@"text"];
            lblType.backgroundColor=[UIColor clearColor];
            lblType.font=[UIFont boldSystemFontOfSize:15];
            lblType.textColor=[UIColor whiteColor];
            [imageView addSubview:lblType];
            
            AsyncImageView *imageGraphView=[[AsyncImageView alloc] init] ;
            if([iLMSCommon  isiPad]){
                imageGraphView.frame=CGRectMake(5, 35, 1014, 350);

            }else{
                imageGraphView.frame=CGRectMake(5, 35, 470, 250);

            }
            [imageGraphView loadImageFromURL:[NSURL URLWithString:[[[[self.arrGraphSamples objectAtIndex:indexPath.row] objectForKey:@"string"] objectAtIndex:0] objectForKey:@"text"]]];
            [imageView addSubview:imageGraphView];
//            cell.selectionStyle=UITableViewCellSelectionStyleBlue;
        }
        else
        {
            UIImageView *imageView=[[UIImageView alloc] init];
            imageView.backgroundColor=[UIColor clearColor];
            imageView.frame=CGRectMake(0.0, 0.0, 320, 220);
            [cell.contentView    addSubview:imageView];
            
            UILabel *lblType=[[UILabel alloc] initWithFrame:CGRectMake(4, 0, 300, 30)];
            lblType.text=[[[[self.arrGraphSamples objectAtIndex:indexPath.row] objectForKey:@"string"] objectAtIndex:1] objectForKey:@"text"];
            lblType.backgroundColor=[UIColor clearColor];
            lblType.font=[UIFont boldSystemFontOfSize:15];
            lblType.textColor=[UIColor whiteColor];
            [imageView addSubview:lblType];
            
            AsyncImageView *imageGraphView=[[AsyncImageView alloc] init] ;
            if([iLMSCommon isiPad]){
                imageGraphView.frame=CGRectMake(5, 35, 758, 285);

            }else{
                imageGraphView.frame=CGRectMake(5, 35, 310, 185);

            }

            [imageGraphView loadImageFromURL:[NSURL URLWithString:[[[[self.arrGraphSamples objectAtIndex:indexPath.row] objectForKey:@"string"] objectAtIndex:0] objectForKey:@"text"]]];
            [imageView addSubview:imageGraphView];
            
//            cell.selectionStyle=UITableViewCellSelectionStyleBlue;
            
            
        }

        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.backgroundColor = [UIColor colorWithRed:(76.0/255.0) green:(161.0/255.0) blue:(255.0/255.0) alpha:1.0]; // perfect color suggested by @mohamadHafez
//    bgColorView.layer.masksToBounds = YES;
//    cell.selectedBackgroundView = bgColorView;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft || [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight ){
        if([iLMSCommon isiPad]){
            return 395;
        }else{
            return 295;

        }

    }
    if([iLMSCommon isiPad]){
        return 330;
    }
    return 230;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    @try {
        iLMSViewGraphController *aController=[[iLMSViewGraphController alloc] initWithNibName:@"iLMSViewGraphController" bundle:nil];
        aController.strURL=[[[[self.arrGraphSamples objectAtIndex:indexPath.row] objectForKey:@"string"] objectAtIndex:0] objectForKey:@"text"];
        aController.strGraphNames=[[[[self.arrGraphSamples objectAtIndex:indexPath.row] objectForKey:@"string"] objectAtIndex:1] objectForKey:@"text"];
        [self.navigationController pushViewController:aController animated:YES];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

#pragma mark - action selector
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logoutAction:(id)sender {
    [iLMSCommon logout];
}


#pragma mark - network connection

- (void)getGraph{
    ConnectionManager *conn=[[ConnectionManager alloc] initWithTarget:self SuccessAction:@selector(responseSuccess:) FailureAction:@selector(responseFail:)];
    [conn callPostMethod:[RequestManager analyzReportChart] Action:[RequestAction returnAnalyzeReportChartAction] API:[RequestManager returnAPI_URL]];
}

- (void)responseSuccess:(id)response{
    if([response isKindOfClass:[NSDictionary class]]){
        NSArray *responseArray=[[[[[response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"AnalyzeReportsChartsResponse"] objectForKey:@"AnalyzeReportsChartsResult"] objectForKey:@"ArrayOfString"];
        self.arrGraphSamples=responseArray;
        [self.tableDashboard reloadData];
        
    }
}

- (void)responseFail:(id)response{
    
}

#pragma mark - roatation

- (NSUInteger)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationPortrait)
    {
        
    }
    else
    {
        
#ifdef DEBUG
        NSLog(@"Device rotated in Portrait");
#endif
        
    }
    [self.tableDashboard reloadData];
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotate
{
    
    return YES;
}

@end
