//
//  AddByHandsViewController.h
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
int myIndex;
@interface AddByHandsViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) NSDictionary* dic;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *quantity1;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

-(void)method:(NSDictionary*)d;
@end
