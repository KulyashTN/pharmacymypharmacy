//
//  AddByHandsViewController.m
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "AddByHandsViewController.h"

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
    dataDict = [[NSMutableDictionary alloc]init];
    self.expDateTextField.delegate = self;
    if(self.dic!=nil){
        [self method:self.dic];
        come=YES;
    }else{
        come=NO;
    }
    
    
}

- (void)viewDidLayoutSubviews
{
    [self.scroll setContentSize:CGSizeMake(320, 1000)];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.expDateTextField) {
    }
    return YES;
}
-(BOOL)allCheck{
    NSLog(@"+%@+",self.quantityTextField.text);
    if ([self.nameTextField.text length]==0){
        [self checkFunc:1];
        return NO;
    }else if ([self.expDateTextField.text length]<10){
        [self checkFunc:2];
        return NO;
    }else if ([self.expDateTextField.text length]==10){
        NSString *day = [self.expDateTextField.text substringWithRange:NSMakeRange(0,2)];
        NSString *month = [self.expDateTextField.text substringWithRange:NSMakeRange(3,2)];
        NSString *year = [self.expDateTextField.text substringWithRange:NSMakeRange(6,4)];
        if ([day intValue]<=0 || [day intValue]>31 || [month intValue]<=0 ||[month intValue]>12 || [year intValue]<2015){
            [self checkFunc:2];
            return NO;
        }
    }else if ([self.quantityTextField.text length]==0){
        NSLog(@"asdasd");
        [self checkFunc:3];
        return NO;
    }else{
        return YES;
    }
    return NO;
}
- (IBAction)doneActionButton:(id)sender {
    NSString* nameTablet = self.nameTextField.text;
    NSString* qualityTablet = self.quantityTextField.text;
    NSString *dateString = self.expDateTextField.text;
    NSLog(@"%d",[self.quantityTextField.text length]);
    BOOL check = [self allCheck];
    NSLog(@"%@",check);
    if (check){
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
    }else{
//        [self checkFunc:5];
    }
}

-(void)checkFunc:(int)checkInt{
    NSString *checkString = [[NSString alloc]init];
    if (checkInt==1){
        checkString = @"Name not can be empty";
        self.nameTextField.text=@"";
        self.nameTextField.layer.cornerRadius=8.0f;
        self.nameTextField.layer.masksToBounds=YES;
        self.nameTextField.layer.borderColor=[[UIColor redColor]CGColor];
        self.nameTextField.layer.borderWidth= 1.0f;
    }else if (checkInt==2){
        checkString = @"The date is not correct";
        self.expDateTextField.text=@"";
        [self.expDateTextField setPlaceholder:@"01-01-2015"];
        self.expDateTextField.layer.cornerRadius=8.0f;
        self.expDateTextField.layer.masksToBounds=YES;
        self.expDateTextField.layer.borderColor=[[UIColor redColor]CGColor];
        self.expDateTextField.layer.borderWidth= 1.0f;
    }else if (checkInt==3){
        checkString = @"Quantity not can be empty";
        self.quantityTextField.text=@"";
        self.quantityTextField.layer.cornerRadius=8.0f;
        self.quantityTextField.layer.masksToBounds=YES;
        self.quantityTextField.layer.borderColor=[[UIColor redColor]CGColor];
        self.quantityTextField.layer.borderWidth= 1.0f;
    }else{
        checkString = @"Smth is wrong";
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",checkString] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];

    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma MASKA TELEPHON
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    int length = (int)[mobileNumber length];
    if(length > 4) {
        mobileNumber = [mobileNumber substringFromIndex: length-4];
    }
    return mobileNumber;
}

-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = (int)[mobileNumber length];
    return length;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.expDateTextField){
        NSString *nameRegex = @"[0-9]+";
        NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
        if (string.length==0) {
            return YES;
        }
        else if(![nameTest evaluateWithObject:string]){
            return NO;
        }
        
        int length = [self getLength:self.expDateTextField.text];
        
        if(length == 8) {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 2) {
            NSString *num = [self formatNumber:self.expDateTextField.text];
            self.expDateTextField.text = [NSString stringWithFormat:@"%@-",num];
            if(range.length > 0)
                self.expDateTextField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:2]];
        }
        else if(length == 4) {
            NSString *num = [self formatNumber:self.expDateTextField.text];
            self.expDateTextField.text = [NSString stringWithFormat:@"%@-%@-",[num substringToIndex:2],[num substringFromIndex:2]];
            if(range.length > 0)
                self.expDateTextField.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:2],[num substringFromIndex:2]];
        }
        return YES;
    }
    return YES;
}


@end
