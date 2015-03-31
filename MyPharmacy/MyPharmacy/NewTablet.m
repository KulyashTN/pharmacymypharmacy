//
//  NewTablet.m
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "NewTablet.h"

@interface NewTablet (){
    NSArray *hour;
    NSMutableArray *minute, *week;
    NSMutableDictionary *arrayOfData;
    int k;
    NSString* h, *m;
    
}
@end

@implementation NewTablet

- (void)viewDidLoad {
    [super viewDidLoad];
    k=0;
    hour = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"00", nil];
    
    minute = [NSMutableArray new];
    week = [NSMutableArray new];
    arrayOfData = [NSMutableDictionary new];
    for(int i=0;i<7;i++){
        [week addObject:@"1"];
    }
    for(int i=0;i<6;i++){
        for(int j=0;j<10;j++)
        [minute addObject:[NSString stringWithFormat:@"%d%d",i,j]];
    }
    
    self.TimePicker.delegate = self;
    self.TimePicker.dataSource = self;
    
    
    if([self.RepeatSwitch isOn]){
        [self.FoodControl.layer setFrame:CGRectMake(16, 418, 288, 29)];
    }
    else{
        [self.FoodControl.layer setFrame:CGRectMake(16, 366, 288, 29)];
    }

    
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return 24;
    }
    else
        return 60;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0){
        return hour[row];
    }
    else
        return minute[row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(component==0){
        h=hour[row];
    }
    else if(component==1){
        m=minute[row];
    }
    [arrayOfData setObject:[NSString stringWithFormat:@"%@:%@",h,m] forKey:@"time"];
   // NSLog(@"time = %@", [arrayOfData objectForKey:@"time"]);

}


- (IBAction)SwichRepeat:(UISwitch *)sender {
    if([sender isOn]){
        [UIView animateWithDuration:0.5 animations:^(void){
        [self.ViewWithButtons setHidden:NO];
        [self.FoodControl.layer setFrame:CGRectMake(16, 418, 288, 29)];
        }];
        
    }
    else{
        
        
        [UIView animateWithDuration:0.5 animations:^(void){
            [self.ViewWithButtons setHidden:YES];
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
        [arrayOfData setObject:[NSString stringWithFormat:@"%@",self.Name.text] forKey:@"name"];
        NSLog(@"name = %@", [arrayOfData objectForKey:@"name"]);
        
        [arrayOfData setObject:[NSString stringWithFormat:@"%@",self.Notes.text] forKey:@"notes"];
        NSLog(@"notes = %@", [arrayOfData objectForKey:@"notes"]);
        
        if(![self.RepeatSwitch isOn]){
            for(int i=0;i<7;i++){
                [week setObject:@"0" atIndexedSubscript:i];
            }
        }
        [arrayOfData setObject:week forKey:@"weekArray"];
        NSLog(@"week = %@", [arrayOfData objectForKey:@"week"]);
        
        if(self.FoodControl.selectedSegmentIndex==0) [arrayOfData setObject:@"with food" forKey:@"food"];
        else [arrayOfData setObject:@"without food" forKey:@"food"];
        NSLog(@"food = %@", [arrayOfData objectForKey:@"food"]);
        
        NSMutableArray* arrayOfAlarmTablet = [[NSMutableArray alloc]initWithObjects:arrayOfData, nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:arrayOfData forKey:@"AlarmTabletArray"];
    }
}
@end
