//
//  AddTabletViewController.m
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "AddTabletViewController.h"
#import "Tablets.h"
#import "MFSideMenu.h"
#import "NewTablet.h"

@interface AddTabletViewController ()<UITableViewDelegate,UITableViewDataSource>{
}

@end

@implementation AddTabletViewController

-(NSMutableArray *)tablets{
    _tablets= [[[NSUserDefaults standardUserDefaults] objectForKey:@"AlarmTabletArray"] mutableCopy];
    if (!_tablets) {
        _tablets = [[NSMutableArray alloc] init];
        [self.NoTabletLabel setHidden:NO];
        [self.TabletsTableView setHidden:YES];
        [self.view bringSubviewToFront:self.NoTabletLabel];
//        NSLog(@"nothing here");
    }
    else{
        [self.NoTabletLabel setHidden:YES];
        [self.TabletsTableView setHidden:NO];
        [self.view bringSubviewToFront:self.TabletsTableView];
//        NSLog(@"something here");
    }
   // NSLog(@"tablets = %@",_tablets);
    return _tablets;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.TabletsTableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.TabletsTableView.delegate = self;
    self.TabletsTableView.dataSource = self;

}

- (IBAction)showLeftMenuPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

#pragma mark - tableView methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number =(int)self.tablets.count;
    if(number==0) {
        [self.NoTabletLabel setHidden:NO];
        [self.TabletsTableView setHidden:YES];
        [self.view bringSubviewToFront:self.NoTabletLabel];
    }
    else{
        [self.NoTabletLabel setHidden:YES];
        [self.TabletsTableView setHidden:NO];
        [self.view bringSubviewToFront:self.TabletsTableView];
    }
    return number;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray* a = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AlarmTabletArray"]mutableCopy];
        [a removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:a forKey:@"AlarmTabletArray"];
        //[self tablets];
        [self.TabletsTableView reloadData]; // tell table to refresh now
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell;
    if([tableView isEqual:self.TabletsTableView]){
        NSLog(@"t=%@",[self.tablets objectAtIndex:indexPath.row]);
        NSMutableDictionary * dic = [self.tablets objectAtIndex:indexPath.row];
        Tablets* tablet=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //NSLog(@"dic = %@",dic);
        NSLog(@"2");
        
        tablet.name.text=[dic objectForKey:@"name"];
        tablet.notes.text = [dic objectForKey:@"notes"];
        NSDate* time = [dic objectForKey:@"date"];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Almaty"];
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat:@"HH:mm"];
//        NSLog(@"date = %@",[formatter stringFromDate:time]);
        
        tablet.time.text=[formatter stringFromDate:time];
        
        
        cell=tablet;
    }

    return cell;

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"next"]){
        NSIndexPath* indexPath = [self.TabletsTableView indexPathForSelectedRow];
        NewTablet* n=segue.destinationViewController;
        NSMutableDictionary* d =[self.tablets objectAtIndex:indexPath.row];
        n.dic = d;
        myIndex = (int)indexPath.row;
        [self.TabletsTableView reloadData];

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"next" sender:self];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 62;
//}




@end
