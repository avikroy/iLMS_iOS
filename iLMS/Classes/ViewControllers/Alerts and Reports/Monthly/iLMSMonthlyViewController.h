//
//  iLMSMonthlyViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/28/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSMonthlyViewController : UIViewController<UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (weak, nonatomic) IBOutlet UILabel *lblJan;
@property (weak, nonatomic) IBOutlet UILabel *lblFeb;
@property (weak, nonatomic) IBOutlet UILabel *lblMarch;
@property (weak, nonatomic) IBOutlet UILabel *lblApr;
@property (weak, nonatomic) IBOutlet UILabel *lblMay;
@property (weak, nonatomic) IBOutlet UILabel *lblJun;
@property (weak, nonatomic) IBOutlet UILabel *lblJuly;
@property (weak, nonatomic) IBOutlet UILabel *lblAug;
@property (weak, nonatomic) IBOutlet UILabel *lblSept;
@property (weak, nonatomic) IBOutlet UILabel *lbloct;
@property (weak, nonatomic) IBOutlet UILabel *lblNov;
@property (weak, nonatomic) IBOutlet UILabel *lblDec;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolPicker;
@property (strong, nonatomic) IBOutlet UIView *navigationHeader;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *headerView;


- (IBAction)doneAction:(id)sender;

- (IBAction)logoutAction:(id)sender;

- (IBAction)backAction:(id)sender;

- (IBAction)dateSelected:(id)sender;


@end
