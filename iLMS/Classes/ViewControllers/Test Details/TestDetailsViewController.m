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
    NSXMLParser   *xmlParser;
    NSMutableString  *soapResults;
    BOOL   elementFound;
    NSMutableArray *arrayResult;


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
    return [arrayResult count];
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
    
    NSString *key=[[[arrayResult objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    NSString *value=[[arrayResult objectAtIndex:indexPath.row] objectForKey:key];

    cellText=[[NSString stringWithFormat:@"  %@",key] stringByReplacingOccurrencesOfString:@"x0020" withString:@" "];
    cellText=[cellText stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    cellText=[cellText stringByReplacingOccurrencesOfString:@"  " withString:@" "];

    cell.lblTitle.text=[cellText capitalizedString];
    cell.lblSubTitle.text=[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
        [self parseXML:[responseDict objectForKey:@"text"]];
//        NSDictionary *finalDict=[XMLReader dictionaryForXMLString:[responseDict objectForKey:@"text"] error:NULL];
//        id object=[[finalDict objectForKey:@"NewDataSet"] objectForKey:@"Table"];
//        if([object isKindOfClass:[NSArray class]]){
//            arrTitle=(NSMutableArray *)object;
//        }else if([object isKindOfClass:[NSDictionary class]]){
//            arrKeys=[object allKeys ];
//            arrTitle=[[NSMutableArray alloc] initWithObjects:object , nil];
//            dictResult=(NSDictionary *)object;
//        }
//        [self.tableTestDetails reloadData];
        
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

#pragma mark - parse xml

- (void)parseXML:(NSString *)strData{
    
    xmlParser = [[NSXMLParser alloc] initWithData: [strData dataUsingEncoding:NSUTF8StringEncoding]];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
}

-(void)  parser:(NSXMLParser *) parser
didStartElement:(NSString *) elementName
   namespaceURI:(NSString *) namespaceURI
  qualifiedName:(NSString *) qName
     attributes:(NSDictionary *) attributeDict
{
    
    if( [elementName isEqualToString:@"Table"])
    {
        if (!arrayResult)
        {
            arrayResult=[[NSMutableArray alloc] init];
        }
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"lead"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"iron"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"aluminium"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"copper"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"chromium"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"tin"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"nickel"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"silicon"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"sodium"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"magnesium"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"zinc"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"molybdenum"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"calcium"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"phosphorous"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"boron"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"tbn"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"soot"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"glycol"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"fuel_x0020_dilution"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"oxidation"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"nitration"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"sulphation"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"tan"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"water"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"pq-90"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"isocode"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"total_particle_count"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"viscosityat100c"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"viscosityat40c"])
    {
        elementFound = TRUE;
    }
    else if([elementName isEqualToString:@"pq-90"])
    {
        elementFound = TRUE;
    }

    if(elementFound){
        soapResults = [[NSMutableString alloc] init];

    }
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if (elementFound)
    {
        [soapResults appendString: string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Parser error %@ ",[parseError description]);
}


//---when the end of element is found---
-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Table"])
    {
        NSLog(@"display the soap results%@",arrayResult);
        [self.tableTestDetails reloadData];
    }
    else if([elementName isEqualToString:@"lead"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:@"lead"]];
    }
    else if([elementName isEqualToString:@"iron"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"aluminium"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"copper"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"chromium"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"tin"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"nickel"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"silicon"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"sodium"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"magnesium"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"zinc"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"molybdenum"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"calcium"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"phosphorous"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"boron"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"tbn"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"soot"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"glycol"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"fuel_x0020_dilution"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"oxidation"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"nitration"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"sulphation"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"tan"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"water"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"pq-90"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"isocode"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"total_particle_count"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"viscosityat100c"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"viscosityat40c"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }
    else if([elementName isEqualToString:@"pq-90"])
    {
        [arrayResult addObject:[NSDictionary dictionaryWithObject:soapResults forKey:elementName]];
    }

    
//    [soapResults setString:@""];
    elementFound = FALSE;
}

@end
