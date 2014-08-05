//
//  iLMSSearhResultViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/28/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSSearhResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderSearchType;
@property (strong, nonatomic) IBOutlet UITableView *searchTable;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, retain) NSMutableArray  *ownSearchArray;;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (nonatomic, strong) NSString * strSearchType;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *tableViewHeader;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UIView *navigationHeader;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)backAction:(id)sender;

@end
