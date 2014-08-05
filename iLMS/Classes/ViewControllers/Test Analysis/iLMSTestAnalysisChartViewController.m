//
//  iLMSTestAnalysisChartViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/30/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSTestAnalysisChartViewController.h"
#import "iLMSViewGraphController.h"
#import "AsyncImageView.h"
#import "UIImage+Resize.h"

@interface iLMSTestAnalysisChartViewController ()
@property (nonatomic, retain) NSArray *arrGraphSamples;
@end


@implementation iLMSTestAnalysisChartViewController

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
//    self.tableTestGraph.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableTestGraph.separatorColor=[UIColor clearColor];
    [self getGraph];
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    self.lblAnalysisType.text=[NSString stringWithFormat:@"Test Analysis - %@",self.strAnalysisType];

    // Do any additional setup after loading the view from its nib.
    if ([self.tableTestGraph respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableTestGraph setSeparatorInset:UIEdgeInsetsZero];
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
    
//    @try {
//        
//        UIImageView *imageView=[[UIImageView alloc] init];
//        imageView.backgroundColor=[UIColor clearColor];
//        imageView.frame=CGRectMake(0.0, 0.0, 320, 220);
//        [cell.contentView    addSubview:imageView];
//        
//        APSSimpleWebView *imageGraphView=[[APSSimpleWebView alloc] init];
//        imageGraphView.frame=CGRectMake(5, 35, 310, 185);
//        [imageGraphView loadStringURL:[[self.arrGraphSamples objectAtIndex:indexPath.row]  objectForKey:@"text"] withFrame:CGRectMake(0, 0, 310, 185)];
//        [imageView addSubview:imageGraphView];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
    
    @try {
        if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft ||[UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight)
        {
            UIImageView *imageView=[[UIImageView alloc] init];
            imageView.backgroundColor=[UIColor clearColor];
            imageView.frame=CGRectMake(0.0, 0.0, 320, 220);
            [cell.contentView    addSubview:imageView];
            
            UILabel *lblType=[[UILabel alloc] initWithFrame:CGRectMake(4, 0, 400, 30)];
            if(indexPath.row==0){
                lblType.text=@"Probability Plot";
            }else if(indexPath.row==1){
                lblType.text=@"Frequency Histogram";
                
            }else if(indexPath.row==2){
               lblType.text=@"SPC IMR Chart";
                
            }else if(indexPath.row==3){
                lblType.text=@"SPC Frequency IMR Chart";
                
            }

            lblType.backgroundColor=[UIColor clearColor];
            lblType.font=[UIFont boldSystemFontOfSize:15];
            lblType.textColor=[UIColor whiteColor];
            [imageView addSubview:lblType];
            
//            APSSimpleWebView *imageGraphView=[[APSSimpleWebView alloc] init];
//            imageGraphView.frame=CGRectMake(5, 35, 470, 250);
//            [imageGraphView loadStringURL:[[self.arrGraphSamples objectAtIndex:indexPath.row]  objectForKey:@"text"] withFrame:CGRectMake(0, 0, 470, 185)];
//            [imageView addSubview:imageGraphView];
            
            AsyncImageView *imageGraphView=[[AsyncImageView alloc] init] ;
            if([iLMSCommon  isiPad]){
                imageGraphView.frame=CGRectMake(5, 35, 1014, 350);
                
            }else{
                imageGraphView.frame=CGRectMake(5, 35, 470, 250);
                
            }
            [imageGraphView loadImageFromURL:[NSURL URLWithString:[[self.arrGraphSamples objectAtIndex:indexPath.row]  objectForKey:@"text"]]];
            [imageView addSubview:imageGraphView];
        }
        else
        {
            UIImageView *imageView=[[UIImageView alloc] init];
            imageView.backgroundColor=[UIColor clearColor];
            imageView.frame=CGRectMake(0.0, 0.0, 320, 220);
            [cell.contentView    addSubview:imageView];
            
            UILabel *lblType=[[UILabel alloc] initWithFrame:CGRectMake(4, 0, 300, 30)];
            if(indexPath.row==0){
                lblType.text=@"Probability Plot";
            }else if(indexPath.row==1){
                lblType.text=@"Frequency Histogram";
                
            }else if(indexPath.row==2){
                lblType.text=@"SPC IMR Chart";
                
            }else if(indexPath.row==3){
                lblType.text=@"SPC Frequency IMR Chart";
                
            }

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
            [imageGraphView loadImageFromURL:[NSURL URLWithString:[[self.arrGraphSamples objectAtIndex:indexPath.row]  objectForKey:@"text"]]];
            [imageView addSubview:imageGraphView];
            
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    @try {
        iLMSViewGraphController *aController=[[iLMSViewGraphController alloc] initWithNibName:@"iLMSViewGraphController" bundle:nil];
        aController.strURL=[[self.arrGraphSamples objectAtIndex:indexPath.row]  objectForKey:@"text"];
        if(!aController.strGraphNames){
            if(indexPath.row==0){
                aController.strGraphNames=@"Probability Plot";
            }else if(indexPath.row==1){
                aController.strGraphNames=@"Frequency Histogram";

            }else if(indexPath.row==2){
                aController.strGraphNames=@"SPC IMR Chart";

            }else if(indexPath.row==3){
                aController.strGraphNames=@"SPC Frequency IMR Chart";

            }
        }
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
    [conn callPostMethod:[RequestManager testChartAnalysisReportChartWithName:self.selectedText] Action:[RequestAction returnTestAnalysisReportChartAction] API:[RequestManager returnAPI_URL]];
}

- (void)responseSuccess:(id)response{
    if([response isKindOfClass:[NSDictionary class]]){
        NSArray *responseArray=[[[[[response objectForKey:@"soap:Envelope"] objectForKey:@"soap:Body"] objectForKey:@"TestAnalysisReportsChartsResponse"] objectForKey:@"TestAnalysisReportsChartsResult"] objectForKey:@"string"];
        self.arrGraphSamples=responseArray;
        [self.tableTestGraph reloadData];
        
    }
}

- (void)responseFail:(id)response{
    [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:(NSString *)response delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

//#pragma mark - roatation
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationPortrait)
//    {
//        
//    }
//    else
//    {
//        
//#ifdef DEBUG
//        NSLog(@"Device rotated in Portrait");
//#endif
//        
//    }
//    [self.tableTestGraph reloadData];
//    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
//}


@end
