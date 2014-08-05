//
//  ViewReportViewController.h
//  iLMS
//
//  Created by Debasish on 28/05/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLMSSearchSamples;

@interface ViewReportViewController : UIViewController<UITableViewDataSource    ,UITableViewDelegate>
@property (nonatomic, retain) iLMSSearchSamples *samples;
@property (strong, nonatomic) IBOutlet UITableView *tableViewdetails;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) NSMutableArray *arrTitle,*arrSubtitle;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *naivgationHeader;

- (IBAction)backAction:(id)sender;
- (IBAction)testDetailsAction:(id)sender;
- (IBAction)logoutAction:(id)sender;

@end
