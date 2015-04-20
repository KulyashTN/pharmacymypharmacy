//
//  NewTablet.m
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "NewTablet.h"

@interface NewTablet (){
    NSMutableDictionary *arrayOfData;
    int k;
    NSMutableArray *week;
    BOOL come;
}

@property(strong, nonatomic) NSMutableArray * tablets;

@end

@implementation NewTablet



-(void)method:(NSDictionary *)d{
    
    self.Name.text=[d objectForKey:@"name"];
    self.Notes.text=[d objectForKey:@"notes"];
    self.TimePicker.date=[d objectForKey:@"date"];
    if([[d objectForKey:@"food"] isEqualToString:@"with food"]) self.FoodControl.selectedSegmentIndex=0;
    else self.FoodControl.selectedSegmentIndex=1;
    week = [[d objectForKey:@"weekArray"] mutableCopy];

    NSMutableArray* buttons = [[NSMutableArray alloc] initWithObjects:self.sundayButton, self.mondayButton, self.tuesdayButton, self.wednesdayButton, self.thursdayButton, self.fridayButton, self.saturdayButton, nil];
    
    int ii=0;
    
    for(int i=0;i<7;i++){
        UIButton* b=[buttons objectAtIndex:i];
        ii+=[[week objectAtIndex:i] integerValue];
        if([[week objectAtIndex:i] isEqualToString:@"1"]){
            [b setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
            [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else{
            [b setBackgroundImage:nil forState:UIControlStateNormal];
            [b setTitleColor:[UIColor colorWithRed:115.0f/255.0f green:214.0f/255.0f blue:22.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        }
    }
    
    if(ii==0){
        [self.RepeatSwitch setOn:NO animated:NO];
    }
   
    if([self.RepeatSwitch isOn]){
        [self.ViewWithButtons setAlpha:1.0];
        [self.FoodControl.layer setFrame:CGRectMake(16, 418, 288, 29)];
        
    }
    else{
        [self.ViewWithButtons setAlpha:0.0];
        [self.FoodControl.layer setFrame:CGRectMake(16, 366, 288, 29)];
    }



}


-(NSMutableArray *)tablets{
    if (!_tablets){
        _tablets= [[[NSUserDefaults standardUserDefaults] objectForKey:@"AlarmTabletArray"] mutableCopy];
    }
    
    if (!_tablets) {
        _tablets = [[NSMutableArray alloc] init];
}
    
    return _tablets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    k=0;
    
    week = [NSMutableArray new];
    arrayOfData = [NSMutableDictionary new];
    for(int i=0;i<7;i++){
        [week addObject:@"1"];
    }
    
    if(self.dic!=nil){ [self method:self.dic]; come=YES;}
    else{come=NO;}
    
    if([self.RepeatSwitch isOn]){
        [self.FoodControl.layer setFrame:CGRectMake(16, 418, 288, 29)];
    }
    else{
        [self.FoodControl.layer setFrame:CGRectMake(16, 366, 288, 29)];
    }
    self.Name.autocorrectionType = UITextAutocorrectionTypeNo;
    self.Notes.autocorrectionType = UITextAutocorrectionTypeNo;

    
    
    
}


- (IBAction)SwichRepeat:(UISwitch *)sender {
    if([sender isOn]){
        [UIView animateWithDuration:0.5 animations:^(void){
            [self.ViewWithButtons setAlpha:1.0];
            [self.FoodControl.layer setFrame:CGRectMake(16, 418, 288, 29)];
        }];
        
    }
    else{
        [UIView animateWithDuration:0.5 animations:^(void){
            [self.ViewWithButtons setAlpha:0.0];
            [self.FoodControl.layer setFrame:CGRectMake(16, 366, 288, 29)];
        }];
        
    }
}

- (IBAction)WeekButtons:(UIButton *)sender {
    

    if([[week objectAtIndex:sender.tag] isEqualToString:@"1"]){
        [week replaceObjectAtIndex:sender.tag withObject:@"0"];
        
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:115.0f/255.0f green:214.0f/255.0f blue:22.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    }
    else{
        
        [week replaceObjectAtIndex:sender.tag withObject:@"1"];
        [sender setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
}




- (IBAction)SaveOrCancelButton:(UIButton *)sender {
    if(sender.tag==0){
        [arrayOfData setObject:self.TimePicker.date forKey:@"date"];
        NSLog(@"date = %@", [arrayOfData objectForKey:@"date"]);
        
        [arrayOfData setObject:[NSString stringWithFormat:@"%@",self.Name.text] forKey:@"name"];
        //NSLog(@"name = %@", [arrayOfData objectForKey:@"name"]);
        
        [arrayOfData setObject:[NSString stringWithFormat:@"%@",self.Notes.text] forKey:@"notes"];
        //NSLog(@"notes = %@", [arrayOfData objectForKey:@"notes"]);
        
        if(![self.RepeatSwitch isOn]){
            for(int i=0;i<7;i++){
                [week replaceObjectAtIndex:i withObject:@"0"];
            }
        }
        
        [arrayOfData setObject:week forKey:@"weekArray"];
        //NSLog(@"week = %@", [arrayOfData objectForKey:@"weekArray"]);
        
        if(self.FoodControl.selectedSegmentIndex==0) [arrayOfData setObject:@"with food" forKey:@"food"];
        else [arrayOfData setObject:@"without food" forKey:@"food"];
        //NSLog(@"food = %@", [arrayOfData objectForKey:@"food"]);
        
        
        if(come==YES){
            [self.tablets replaceObjectAtIndex:myIndex withObject:arrayOfData];
        }
        else if(come==NO){
            [self.tablets addObject:arrayOfData];
        }
        //NSLog(@"ar1 = %@",self.tablets);
        [[NSUserDefaults standardUserDefaults] setObject:self.tablets forKey:@"AlarmTabletArray"];
       // NSLog(@"ar2 = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AlarmTabletArray"]);
        
        
        //Local Notification
        
        UIApplication *app = [UIApplication sharedApplication];
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification) {
            notification.soundName = @"tablet.mp3";
            notification.alertBody = [NSString stringWithFormat:@"Drink it %@. %@",[arrayOfData objectForKey:@"food"], [arrayOfData objectForKey:@"notes"]];
            notification.alertTitle = self.Name.text;
            
            NSDateFormatter* f = [NSDateFormatter new];
            [f setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *dateFromString = [f dateFromString:[f stringFromDate:self.TimePicker.date]];
            
            notification.fireDate = dateFromString;
            notification.repeatInterval=NSCalendarUnitWeekday;
            [app scheduleLocalNotification:notification];
           // NSLog(@"FIRST fireDate=%@",  notification.fireDate);

            NSDateFormatter *weekday = [NSDateFormatter new];
            [weekday setDateFormat: @"EEEE"];
            [f setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            NSString* str =[weekday stringFromDate:dateFromString];
            int ii=0;
            if([str isEqualToString:@"Sunday"]) ii=0;
            else if([str isEqualToString:@"Monday"]) ii=1;
            else if([str isEqualToString:@"Tuesday"]) ii=2;
            else if([str isEqualToString:@"Wednesday"]) ii=3;
            else if([str isEqualToString:@"Thursday"]) ii=4;
            else if([str isEqualToString:@"Friday"]) ii=5;
            else if([str isEqualToString:@"Saturday"]) ii=6;
            int iii=ii+1;

            for(int i = 1; i <= 6;i++)
            {
                if(iii==7) iii=0;
                
                if([[week objectAtIndex:iii] isEqualToString:@"1"]){
                    notification.fireDate = [dateFromString dateByAddingTimeInterval:60*60*24*i];
                    notification.repeatInterval=NSCalendarUnitWeekday;
                    //NSLog(@"fireDate=%@",  notification.fireDate);
                    [app scheduleLocalNotification:notification];
                }
                iii++;
            }
            
            [app presentLocalNotificationNow:notification];

        }
    }
    if(come==YES){
        [self.navigationController popViewControllerAnimated:YES];


    }
    else if(come==NO){
        [self performSegueWithIdentifier:@"back" sender:self];
    }
   

}







- (IBAction)takeAwayKeyboard:(UIButton *)sender {
    [self.TimePicker resignFirstResponder];
    [self.Name resignFirstResponder];
    [self.Notes resignFirstResponder];
    [self.RepeatSwitch resignFirstResponder];
    [self.ViewWithButtons resignFirstResponder];
    [self.FoodControl resignFirstResponder];
    NSLog(@"eee");
}




    
@end

