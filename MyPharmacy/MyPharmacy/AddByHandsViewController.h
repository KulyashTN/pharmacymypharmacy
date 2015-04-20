//
//  AddByHandsViewController.h
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>
int myIndex;
@interface AddByHandsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UITextView *descTextAria;
@property (weak, nonatomic) NSDictionary* dic;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

-(void)method:(NSDictionary*)d;
@end
