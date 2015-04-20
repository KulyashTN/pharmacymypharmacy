//
//  NewTablet.h
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>


int myIndex;
@interface NewTablet : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *TimePicker;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Notes;
@property (weak, nonatomic) IBOutlet UISwitch *RepeatSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *FoodControl;
@property (weak, nonatomic) IBOutlet UIView *ViewWithButtons;
- (IBAction)SwichRepeat:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UIButton *sundayButton;
@property (weak, nonatomic) IBOutlet UIButton *mondayButton;
@property (weak, nonatomic) IBOutlet UIButton *thursdayButton;
@property (weak, nonatomic) IBOutlet UIButton *wednesdayButton;
@property (weak, nonatomic) IBOutlet UIButton *tuesdayButton;
@property (weak, nonatomic) IBOutlet UIButton *fridayButton;
@property (weak, nonatomic) IBOutlet UIButton *saturdayButton;
@property (weak, nonatomic) NSDictionary* dic;

- (IBAction)WeekButtons:(UIButton *)sender;

- (IBAction)SaveOrCancelButton:(UIButton *)sender;

- (IBAction)takeAwayKeyboard:(UIButton *)sender;

-(void)method:(NSDictionary*)d;



@end
