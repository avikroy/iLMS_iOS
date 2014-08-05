//
//  iLMSTestanalysisViewController.h
//  iLMS
//
//  Created by Avik Roy on 5/30/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iLMSTestanalysisViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerTestName;
@property (weak, nonatomic) IBOutlet UIButton *btnDrpDwn;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIView *naivgationHeader;

- (IBAction)logoutAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)btnDrpDwnAction:(id)sender;
- (IBAction)showAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end
