//
//  MenuViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/25/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableMenu;
@property (strong, nonatomic) IBOutlet UIView *navigatioHeader;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)logoutAction:(id)sender;

@end
