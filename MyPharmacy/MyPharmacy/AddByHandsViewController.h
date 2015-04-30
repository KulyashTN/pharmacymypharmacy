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
@interface AddByHandsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) NSDictionary* dic;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;


@property (weak, nonatomic) IBOutlet UILabel *uses;
@property (weak, nonatomic) IBOutlet UILabel *contraindication;
@property (weak, nonatomic) IBOutlet UILabel *sideEffects;
@property (weak, nonatomic) IBOutlet UILabel *howToUse;
@property (weak, nonatomic) IBOutlet UILabel *overDose;
@property (weak, nonatomic) IBOutlet UILabel *uses1;
@property (weak, nonatomic) IBOutlet UILabel *contraindication1;
@property (weak, nonatomic) IBOutlet UILabel *quantity1;
@property (weak, nonatomic) IBOutlet UILabel *overDose1;
@property (weak, nonatomic) IBOutlet UILabel *howToUse1;
@property (weak, nonatomic) IBOutlet UILabel *sideEffects1;



@property (nonatomic) sqlite3 *contactDB;
@property (strong, nonatomic) NSString *databasePath;



@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;




-(void)method:(NSDictionary*)d;
@end
