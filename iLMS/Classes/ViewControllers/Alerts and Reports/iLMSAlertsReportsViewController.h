//
//  iLMSAlertsReportsViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/31/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSAlertsReportsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (weak, nonatomic) IBOutlet UITableView *tableAlertsAndReports;
@property (strong, nonatomic) IBOutlet UIView *navigationHeader;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)logoutAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
