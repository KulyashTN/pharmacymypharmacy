//
//  NewTablet.m
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "NewTablet.h"

@interface NewTablet (){
    NSMutableArray *week;
    NSMutableDictionary *arrayOfData;
    int k;
    
}
@end

@implementation NewTablet

- (void)viewDidLoad {
    [super viewDidLoad];
    k=0;

    week = [NSMutableArray new];
    arrayOfData = [NSMutableDictionary new];
    for(int i=0;i<7;i++){
        [week addObject:@"1"];
    }
    
    
    if([self.RepeatSwitch isOn]){
        [self.FoodControl.layer setFrame:CGRectMake(16, 418, 288, 29)];
    }
    else{
        [self.FoodControl.layer setFrame:CGRectMake(16, 366, 288, 29)];
    }

    
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
        [week setObject:@"0" atIndexedSubscript:sender.tag];
        
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:115.0f/255.0f green:214.0f/255.0f blue:22.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    }
    else{
        [week setObject:@"1" atIndexedSubscript:sender.tag];

        [sender setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)SaveOrCancelButton:(UIButton *)sender {
    if(sender.tag==0){
        NSTimeInterval secondsInSixHours =  6 * 60 * 60;
        [arrayOfData setObject:[self.TimePicker.date dateByAddingTimeInterval:secondsInSixHours] forKey:@"date"];
         NSLog(@"date = %@", [arrayOfData objectForKey:@"date"]);
        
        [arrayOfData setObject:[NSString stringWithFormat:@"%@",self.Name.text] forKey:@"name"];
        //NSLog(@"name = %@", [arrayOfData objectForKey:@"name"]);
        
        [arrayOfData setObject:[NSString stringWithFormat:@"%@",self.Notes.text] forKey:@"notes"];
        //NSLog(@"notes = %@", [arrayOfData objectForKey:@"notes"]);
        
        if(![self.RepeatSwitch isOn]){
            for(int i=0;i<7;i++){
                [week setObject:@"0" atIndexedSubscript:i];
            }
        }
        [arrayOfData setObject:week forKey:@"weekArray"];
        //NSLog(@"week = %@", [arrayOfData objectForKey:@"weekArray"]);
        
        if(self.FoodControl.selectedSegmentIndex==0) [arrayOfData setObject:@"with food" forKey:@"food"];
        else [arrayOfData setObject:@"without food" forKey:@"food"];
        //NSLog(@"food = %@", [arrayOfData objectForKey:@"food"]);
        
        NSMutableArray* arrayOfAlarmTablets = [[NSMutableArray alloc]initWithObjects:arrayOfData, nil];
        NSMutableDictionary* d = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AlarmTabletArray"] mutableCopy];
        if(![d isEqual:nil]){
            for(int i=0;i<[NSUserDefaults standardUserDefaults];i++){
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfData forKey:@"AlarmTabletArray"];
    
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
