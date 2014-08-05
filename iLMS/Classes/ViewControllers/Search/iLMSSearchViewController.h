//
//  iLMSSearchViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/26/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSSearchViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate ,UITextFieldDelegate     >

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (weak, nonatomic) IBOutlet UIButton *btnDrpDwn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerDrpDwn;
@property (weak, nonatomic) IBOutlet UIToolbar *toolDrpDwn;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchValue;
@property (weak, nonatomic) IBOutlet UILabel *txtSearchValue1Title;
@property (weak, nonatomic) IBOutlet UILabel *txtSearchValue2Title;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchValue2;
@property (weak, nonatomic) IBOutlet UIButton *btnAction;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerSearch;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *navigationHeader;

- (IBAction)backAction:(id)sender;
- (IBAction)selectSearchFiedlAcrion:(id)sender;
- (IBAction)selectAction:(id)sender;
- (IBAction)doneAction:(id)sender;
- (IBAction)showAction:(id)sender;
- (IBAction)dateSelectedAction:(id)sender;


@end
