//
//  MyPharmacyTableViewController.m
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "MyPharmacyTableViewController.h"
#import "MFSideMenu.h"
#import "TableViewCell.h"
#import "AddByHandsViewController.h"
#import "DatabaseManager.h"
@interface MyPharmacyTableViewController ()<UITableViewDelegate,UITableViewDataSource>{

}

@end

@implementation MyPharmacyTableViewController{
    NSMutableArray *dataPlist;
    NSMutableDictionary * arrOfData;
}
-(NSMutableArray *)tablets{
        _tablets= [[[NSUserDefaults standardUserDefaults] objectForKey:@"myPharmacyKey"] mutableCopy];
    if (!_tablets) {
        _tablets = [[NSArray alloc] init];
        [self.NoTabletLabel setHidden:NO];
        [self.TabletsTableView setHidden:YES];
        [self.view bringSubviewToFront:self.NoTabletLabel];
    }
    else{
        [self.NoTabletLabel setHidden:YES];
        [self.TabletsTableView setHidden:NO];
        [self.view bringSubviewToFront:self.TabletsTableView];
    }

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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
        NSMutableArray* a = [[[NSUserDefaults standardUserDefaults] objectForKey:@"myPharmacyKey"]mutableCopy];
        [a removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:a forKey:@"myPharmacyKey"];
    }
    [self.TabletsTableView reloadData];
}


    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell;
    if ([tableView isEqual:self.TabletsTableView]){
        TableViewCell* tabletCell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary * myTable = self.tablets[indexPath.row];
        
        tabletCell.nameLabel.text = [NSString stringWithFormat:@"%@",myTable[@"nameOfTablet"]];
        tabletCell.expDateLabel.text = [NSString stringWithFormat:@"%@",myTable[@"expOfDate"]];
        tabletCell.qualityLabel.text = [NSString stringWithFormat:@"%@ pcs.",myTable[@"qualityOfTablet"]];
        cell=tabletCell;
    }
    return cell;
}
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"next"]){
        NSIndexPath* indexPath = [self.TabletsTableView indexPathForSelectedRow];
        AddByHandsViewController* n=segue.destinationViewController;
        NSMutableDictionary* d =[self.tablets objectAtIndex:indexPath.row];
        n.dic = d;
        myIndex = (int)indexPath.row;
        [self.TabletsTableView reloadData];
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"next" sender:self];
}

#pragma Alert
- (IBAction)addButtomAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Camera or Hands?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Hands", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [self performSegueWithIdentifier:@"camera" sender:self];
    }else if (buttonIndex == 2){
        [self performSegueWithIdentifier:@"addHands" sender:self];
    }else{
        
    }
}



@end
