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
    self.descTextAria.text=[d objectForKey:@"deskOfTablet"];
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
//        UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        textField.inputView = dummyView;
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.expDateTextField) {
//        NSLog(@"%d",[self.expDateTextField.text length]);
        if ([self.expDateTextField.text length]==10){
            NSString *day = [self.expDateTextField.text substringWithRange:NSMakeRange(0,2)];
            NSString *month = [self.expDateTextField.text substringWithRange:NSMakeRange(3,2)];
            NSString *year = [self.expDateTextField.text substringWithRange:NSMakeRange(6,4)];
            if ([day intValue]>31 || [month intValue]>12 || [year intValue]<2015){
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The date is not correct" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                self.expDateTextField.text=@"";
                [self.expDateTextField setPlaceholder:@"01-01-2015"];
            }
        }
    }else if (textField == self.quantityTextField){

    }else{
        NSCharacterSet *s = [NSCharacterSet alphanumericCharacterSet];
        s = [s invertedSet];
        NSRange r = [self.expDateTextField.text rangeOfCharacterFromSet:s];
        if (r.location != NSNotFound) {
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if(textField == self.expDateTextField){
//        if([textField.text length] == 2) {
//            NSLog(@"length = 2");
//            textField.text=[NSString stringWithFormat:@"%@-",textField.text];
//        }else if([textField.text length]==5){
//            textField.text=[NSString stringWithFormat:@"%@-",textField.text];
//        }
//        if([textField.text length]>9){
//            return NO;
//        }else{
//            return YES;
//        }
//    }
    return YES;
}

- (IBAction)doneActionButton:(id)sender {
    
    NSString* nameTablet = self.nameTextField.text;
    NSString* deskTablet = self.descTextAria.text;
    NSString* qualityTablet = self.quantityTextField.text;
    NSString *dateString = self.expDateTextField.text;
    if ([dateString length]==10){
        [dataDict setObject:nameTablet forKey:@"nameOfTablet"];
        [dataDict setObject:deskTablet forKey:@"deskOfTablet"];
        [dataDict setObject:qualityTablet forKey:@"qualityOfTablet"];
        [dataDict setObject:dateString forKey:@"expOfDate"];
        if(come==YES){
            [self.tablets replaceObjectAtIndex:myIndex withObject:dataDict];
        }
        else if(come==NO){
            [self.tablets addObject:dataDict];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.tablets forKey:@"myPharmacyKey"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The date is not correct" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        self.expDateTextField.text=@"";
        [self.expDateTextField setPlaceholder:@"01-01-2015"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
