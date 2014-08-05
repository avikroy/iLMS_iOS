//
//  iLMSTestAnalysisChartViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/30/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSTestAnalysisChartViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (weak, nonatomic) IBOutlet UITableView *tableTestGraph;
@property (strong, nonatomic) NSString * selectedText,*strAnalysisType;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *naivgationHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblAnalysisType;

- (IBAction)backAction:(id)sender;
- (IBAction)logoutAction:(id)sender;


@end
