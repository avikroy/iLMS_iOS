//
//  TestDetailsViewController.h
//  iLMS
//
//  Created by Debasish on 28/05/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestDetailsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (weak, nonatomic) IBOutlet UITableView *tableTestDetails;
@property (weak, nonatomic) NSString * strElementID;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *naivgationHeader;

- (IBAction)backAction:(id)sender;
- (IBAction)logoutAction:(id)sender;

@end
