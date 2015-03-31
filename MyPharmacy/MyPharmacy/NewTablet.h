//
//  NewTablet.h
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewTablet : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet
UIPickerView *TimePicker;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Notes;
@property (weak, nonatomic) IBOutlet UISwitch *RepeatSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *FoodControl;
@property (weak, nonatomic) IBOutlet UIView *ViewWithButtons;
- (IBAction)SwichRepeat:(UISwitch *)sender;

- (IBAction)WeekButtons:(UIButton *)sender;

- (IBAction)SaveOrCancelButton:(UIButton *)sender;






@end
