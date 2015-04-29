//
//  AddByHandsViewController.m
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "AddByHandsViewController.h"
#import "DatabaseManager.h"
@interface AddByHandsViewController ()
@property(strong, nonatomic) NSMutableArray * tablets;
@end

@implementation AddByHandsViewController{
    NSMutableDictionary *dataDict;
    BOOL come;
}

-(NSMutableArray *)tablets{
    if (!_tablets){
        _tablets= [[[NSUserDefaults standardUserDefaults] objectForKey:@"myPharmacyKey"] mutableCopy];
    }
    if (!_tablets)  _tablets = [[NSMutableArray alloc]init];
    return _tablets;
}

-(void)method:(NSDictionary *)d{
    self.nameTextField.text=[d objectForKey:@"nameOfTablet"];
    self.quantityTextField.text=[d objectForKey:@"qualityOfTablet"];
    self.expDateTextField.text=[d objectForKey:@"expOfDate"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    dataDict = [[NSMutableDictionary alloc]init];
    self.nameTextField.placeholder = @"Name of tablet";
    self.quantityTextField.placeholder = @"Quantity of tablet";
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd MMM YYYY"];
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
    self.expDateTextField.text = date_String;
    
    
    self.expDateTextField.delegate = self;
    [self.datePicker removeFromSuperview];
    self.expDateTextField.inputView = self.datePicker;
    
    self.datePicker.hidden = YES;
    if(self.dic!=nil){
        [self method:self.dic];
        come=YES;
    }else{
        come=NO;
    }
}


-(void)hideKeyBoard {
    [self.expDateTextField resignFirstResponder];
    self.datePicker.hidden = YES;
    [self.nameTextField resignFirstResponder];
    [self.quantityTextField resignFirstResponder];
}

- (IBAction)clickToPicker:(id)sender {
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    self.expDateTextField.text = [dateFormat stringFromDate:date];
}


- (void)viewDidLayoutSubviews
{
    [self.scroll setContentSize:CGSizeMake(320, 1100)];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.expDateTextField) {
        [self.expDateTextField resignFirstResponder];
        self.datePicker.hidden = NO;
    }
    return YES;
}

- (IBAction)doneActionButton:(id)sender {
    UIAlertView *errorAlert = [[UIAlertView alloc]init];
    errorAlert.message =@"";
    errorAlert.title = @"Error";
    [errorAlert addButtonWithTitle:@"OK"];
    NSMutableString *errorMessage = [[NSMutableString alloc]init];
    if ([self.nameTextField.text length]==0 || [self.quantityTextField.text length]==0){
        if ([self.nameTextField.text length]==0){
            [errorMessage appendString:@"Name not can be empty\n"];
            [self errorText:self.nameTextField];
        }else{
            [self correctText:self.nameTextField];
        }
        if ([self.quantityTextField.text length]==0){
            [errorMessage appendString:@"Quantity not can be empty"];
            [self errorText:self.quantityTextField];
        }else{
            [self correctText:self.quantityTextField];
        }
        errorAlert.message = errorMessage;
        [errorAlert show];
    }else{
        NSString* nameTablet = self.nameTextField.text;
        NSString* qualityTablet = self.quantityTextField.text;
        NSString *dateString = self.expDateTextField.text;
        [dataDict setObject:nameTablet forKey:@"nameOfTablet"];
        [dataDict setObject:qualityTablet forKey:@"qualityOfTablet"];
        [dataDict setObject:dateString forKey:@"expOfDate"];
        if(come==YES){
            [self.tablets replaceObjectAtIndex:myIndex withObject:dataDict];
        }
        else if(come==NO){
            [self.tablets addObject:dataDict];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.tablets forKey:@"myPharmacyKey"];
        [self performSegueWithIdentifier:@"back" sender:self];
        
    }
}
-(void)errorText:(UITextField*)text1{
    text1.text=@"";
    text1.layer.cornerRadius=8.0f;
    text1.layer.masksToBounds=YES;
    text1.layer.borderColor=[[UIColor redColor]CGColor];
    text1.layer.borderWidth= 1.0f;
}

-(void)correctText:(UITextField*)text1{
    text1.layer.cornerRadius=8.0f;
    text1.layer.masksToBounds=NO;
    text1.layer.borderColor=[[UIColor clearColor]CGColor];
    text1.layer.borderWidth= 1.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
