//
//  DashboardViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/25/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (weak, nonatomic) IBOutlet UITableView *tableDashboard;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *headerNavigation;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)backAction:(id)sender;
- (IBAction)logoutAction:(id)sender;
@end
