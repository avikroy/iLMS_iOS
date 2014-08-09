//
//  iLMSSearhResultViewController.m
//  iLMS
//
//  Created by Avik Roy on 5/28/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSSearhResultViewController.h"
#import "iLMSSearchSamples.h"
#import "ViewReportViewController.h"
#import "UIImage+Resize.h"

@interface iLMSSearhResultViewController ()
@end

@implementation iLMSSearhResultViewController

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
    
    if(!self.strSearchType){
        self.strSearchType=@"General Search";
    }
//    if(self.searchArray){
//        self.ownSearchArray=[[[NSArray alloc] initWithArray:self.ownSearchArray] retain];
//        [[UIAlertView alloc] ini]
//    }
    self.lblHeaderSearchType.text=self.strSearchType;
    
    self.headerView.layer.cornerRadius=3.0;
    self.tableViewHeader.layer.cornerRadius=3.0;
    self.tableViewHeader.layer.borderWidth=1.0;
//    self.tableViewHeader.layer.borderColor=[[UIColor colorWithRed:139/255. green:201/255. blue:246/255. alpha:1] CGColor];
//    self.tableViewHeader.backgroundColor=[UIColor colorWithRed:139/255. green:201/255. blue:246/255. alpha:1];

//    self.searchTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.lblCompanyName.text=[NSString stringWithFormat:@"Company : %@",[[iLMSLoggedinUser getSharedinstance] userType  ]];
    self.lblUserName.text=[NSString stringWithFormat:@"Welcome %@",[[iLMSLoggedinUser getSharedinstance] userPassword  ]];
    
    //Plant ID|Unit Name|Sample
   // Name|Sample Date
    self.headerLabel.text=@"Plant ID | Unit Name | \nSample No | Sample Date";
    
    if([[UIDevice currentDevice] userInterfaceIdiom ]==UIUserInterfaceIdiomPad){
        self.headerLabel.text=@"Plant ID | Unit Name | Sample No | Sample Date";

    }else{
        CGRect frame = self.headerLabel.frame;
        
        if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft|| [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight)
        {
            frame.size.width=450;
        }
        else
        {
            frame.size.width=700;
            
        }
        
        self.headerLabel.frame=frame;
    }
    self.headerLabel.numberOfLines=0;
    
    
    self.ownSearchArray=[[NSMutableArray alloc] init];
    for(int count=0;count<[self.searchArray count];count++){
        iLMSSearchSamples *sample=[self.searchArray objectAtIndex:count];

        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setObject:sample.SampleNo forKey:@"UnitName"]; //corresponds to plant id
        [dict setObject:sample.UnitName forKey:@"SampleNo"]; //corresponds to unit name
        [dict setObject:sample.SampleNumber forKey:@"SampleID"]; //corresponds to sample id
        [dict setObject:sample.SampleDate forKey:@"SampleDate"];//corresponds to sample date
        
        [self.ownSearchArray addObject:dict];

    }
    
    self.headerLabel.numberOfLines=0;
    self.headerLabel.textColor=[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1];
    [self.headerLabel sizeToFit];
    self.headerLabel.font=[UIFont boldSystemFontOfSize:14];
    
    if(self.searchArray.count==0){
        self.headerLabel.text=@"No Record Found";
    }
    
    if ([self.searchTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.searchTable setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    if(self.searchArray==nil || self.searchTable==nil){
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ownSearchArray count];
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    
    NSMutableDictionary *aDict=[self.ownSearchArray objectAtIndex:indexPath.row];
//
    cell.textLabel.text=[NSString stringWithFormat:@"%@.   %@ | %@ |  \n%@ | %@ ",[NSString stringWithFormat:@"%ld",indexPath.row+1],[aDict objectForKey:@"UnitName"],[aDict objectForKey:@"SampleNo"],[aDict objectForKey:@"SampleID"],[aDict objectForKey:@"SampleDate"]];
    
    if([[UIDevice currentDevice] userInterfaceIdiom ]==UIUserInterfaceIdiomPad){
        cell.textLabel.text=[NSString stringWithFormat:@"%@.   %@ | %@ |  %@ | %@ ",[NSString stringWithFormat:@"%ld",indexPath.row+1],[aDict objectForKey:@"UnitName"],[aDict objectForKey:@"SampleNo"],[aDict objectForKey:@"SampleID"],[aDict objectForKey:@"SampleDate"]];
        
    }

    
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.numberOfLines=0;
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    [cell.textLabel sizeToFit];
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    
    NSMutableAttributedString *text =[[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [text addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, 3)];

    [cell.textLabel setAttributedText: text];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(76.0/255.0) green:(161.0/255.0) blue:(255.0/255.0) alpha:1.0]; // perfect color suggested by @mohamadHafez
    bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchTable deselectRowAtIndexPath:indexPath animated:YES ];
    
    @try {
        if(tableView!=nil){
            if(indexPath!=nil){
                if(self.ownSearchArray!=nil){
                    if(self.searchArray!=nil){
                        ViewReportViewController *aController=[[ViewReportViewController alloc] initWithNibName:@"ViewReportViewController" bundle:nil];
                        aController.samples=[[self.searchArray objectAtIndex:indexPath.row] retain];
                        [self.navigationController pushViewController:aController animated:YES];
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

#pragma mark - action selector
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - roatation

- (NSUInteger)supportedInterfaceOrientations
{
//    CGRect frame = self.headerLabel.frame;
//    
//    if ([UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeLeft|| [UIDevice currentDevice].orientation==UIInterfaceOrientationLandscapeRight)
//    {
//        frame.size.width=450;
//    }
//    else
//    {
//        frame.size.width=450;
//        
//    }
//    
//    self.headerLabel.frame=frame;
//    
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotate
{
    
    return YES;
}


@end
