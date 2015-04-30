//
//  AddByHandsViewController.m
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "AddByHandsViewController.h"
#import "DatabaseManager.h"
#import "UIBorderLabel.h"
@interface AddByHandsViewController ()
@property(strong, nonatomic) NSMutableArray * tablets;
@end

@implementation AddByHandsViewController{
    NSMutableDictionary *dataDict;
    BOOL come;
    DatabaseManager * databaseManager;
    UIBorderLabel *use,*contr,*sideEf,*hTu,*ovDose;
    UILabel *use1,*contr1,*sideEf1,*hTu1,*ovDose1;
    int setSave;
    CGFloat topInset,leftInset,bottomInset,rightInset;
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
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray * array = [databaseManager findeName:[NSString stringWithFormat:@"%@",self.nameTextField.text]];
        if ([array count]>0){
            for (int i=0;i<5; i++){
                if (i==0){
                    [self settingToLabel:use withArray:array withInt:i];
                }else if (i==1){
                    [self settingToLabel:contr withArray:array withInt:i];
                }else if (i==2){
                    [self settingToLabel:sideEf withArray:array withInt:i];
                }else if (i==3){
                    [self settingToLabel:hTu withArray:array withInt:i];
                }else if (i==4){
                    [self settingToLabel:ovDose withArray:array withInt:i];
                }
            }
        }
        [databaseManager close];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    databaseManager = [[DatabaseManager alloc] init];

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
}

-(void)settingToLabel:(UIBorderLabel*)setLabel withArray:(NSArray*)ar withInt:(int)p{
    setLabel.font = [UIFont systemFontOfSize:13];
    if (setLabel == use){
        setLabel.text = [NSString stringWithFormat:@"%@",[[ar objectAtIndex:0]valueForKey:@"uses" ]];
    }else if(setLabel == contr){
        setLabel.text= [NSString stringWithFormat:@"%@",[[ar objectAtIndex:0]valueForKey:@"contraindications" ]];
    }else if (setLabel == sideEf){
        setLabel.text = [NSString stringWithFormat:@"%@",[[ar objectAtIndex:0]valueForKey:@"sideEffects" ]];
    }else if (setLabel == hTu){
        setLabel.text = [NSString stringWithFormat:@"%@",[[ar objectAtIndex:0]valueForKey:@"howToUse" ]];
    }else if (setLabel == ovDose){
        setLabel.text = [NSString stringWithFormat:@"%@",[[ar objectAtIndex:0]valueForKey:@"overDose" ]];
    }
    setLabel.numberOfLines = 0;
    setLabel.backgroundColor = [UIColor clearColor];
    setLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maximumLabelSize = CGSizeMake(229, 9999);
    CGSize expectSize = [setLabel sizeThatFits:maximumLabelSize];
    if (p==0){
        setLabel.frame = CGRectMake(10, 250, 300, expectSize.height);
        [self setLabel:use1 withInteger:250+setSave-20];
    }else{
        setLabel.frame = CGRectMake(10, 250 + setSave, 300, expectSize.height);
        if (p==1){
            [self setLabel:contr1 withInteger:250+setSave-90];
        }else if (p==2){
            [self setLabel:sideEf1 withInteger:250+setSave-90];
        }else if (p==3){
            [self setLabel:hTu1 withInteger:250+setSave-90];
        }else if (p==4){
            [self setLabel:ovDose1 withInteger:250+setSave-90];
        }
    }
    setLabel.topInset = 10;
    setLabel.leftInset = 15;
    setLabel.bottomInset = 10;
    setLabel.rightInset = 15;
    setLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    setLabel.layer.borderWidth = 1.0;
    setSave += expectSize.height + 50;
    [self.scroll addSubview:setLabel];
}

-(void)setLabel:(UILabel*)label withInteger:(int)width{
    label.font = [UIFont systemFontOfSize:17];
    int k=0;
    if (label == use1){
        label.text = @"Uses:";
        k++;
    }else if(label == contr1){
        label.text= @"Contraindications:";
    }else if (label == sideEf1){
        label.text= @"Side effects:";
    }else if (label == hTu1){
        label.text= @"How to use:";
    }else if (label == ovDose1){
        label.text= @"Over dose:";
    }
    CGSize maximumLabelSize = CGSizeMake(30, 20);
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    if (k!=0){
        label.frame = CGRectMake(10, 225, expectSize.width, expectSize.height);
    }else{
        label.frame = CGRectMake(10, 230+width-165, expectSize.width, expectSize.height);
    }
    [self.scroll addSubview:label];
}


-(void)viewWillAppear:(BOOL)animated{
    use = [[UIBorderLabel alloc] init];
    contr = [[UIBorderLabel alloc]init];
    sideEf = [[UIBorderLabel alloc]init];
    hTu = [[UIBorderLabel alloc]init];
    ovDose = [[UIBorderLabel alloc]init];
    
    use1 = [[UILabel alloc] init];
    contr1 = [[UILabel alloc]init];
    sideEf1 = [[UILabel alloc]init];
    hTu1 = [[UILabel alloc]init];
    ovDose1 = [[UILabel alloc]init];
    
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

- (void)viewDidLayoutSubviews{
    [self.scroll setContentSize:CGSizeMake(320, setSave + 300)];
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
