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
@interface MyPharmacyTableViewController ()

@end

@implementation MyPharmacyTableViewController{
    NSMutableArray *dataPlist;
    NSMutableDictionary * arrOfData;
    UIView *noTableView;
}

-(NSMutableArray *)tablets{
//    if (!_tablets){
        _tablets= [[[NSUserDefaults standardUserDefaults] objectForKey:@"myPharmacyKey"] mutableCopy];
//
//    }
//    if (!_tablets)  _tablets = [[NSMutableArray alloc]init];
    
    if (!_tablets) {
        _tablets = [[NSArray alloc] init];
        [noTableView setHidden:NO];
        [self.tableView setHidden:YES];
        [self.view bringSubviewToFront:noTableView];
    }
    else{
        [noTableView setHidden:YES];
        [self.tableView setHidden:NO];
        [self.view bringSubviewToFront:self.tableView];
    }

    return _tablets;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _tablets = nil;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    noTableView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320, 568)];
//    [noTableView setBackgroundColor:[UIColor lightGrayColor]];
    noTableView.backgroundColor = [UIColor redColor];
    UILabel *noTabletLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 568/2-15, 100, 30)];
    noTabletLabel.text = @"No Tablet";
    [noTabletLabel setTextColor:[UIColor grayColor]];;
    [noTableView addSubview:noTabletLabel];
    [self.tableView addSubview:noTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (IBAction)showLeftMenuPressed:(id)sender {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
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
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int number =(int)self.tablets.count;
    if (number == 0) {
        _tablets = [[NSArray alloc] init];
        [noTableView setHidden:NO];
        [self.tableView setHidden:YES];
        [self.view bringSubviewToFront:noTableView];
    }
    else{
        [noTableView setHidden:YES];
        [self.tableView setHidden:NO];
        [self.view bringSubviewToFront:self.tableView];
    }
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * myTable = self.tablets[indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",myTable[@"nameOfTablet"]];
    cell.expDateLabel.text = [NSString stringWithFormat:@"%@",myTable[@"expOfDate"]];
    cell.qualityLabel.text = [NSString stringWithFormat:@"%@ pcs.",myTable[@"qualityOfTablet"]];
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 30;
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"next"]){
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        AddByHandsViewController* n=segue.destinationViewController;
        NSMutableDictionary* d =[self.tablets objectAtIndex:indexPath.row];
        n.dic = d;
        myIndex = (int)indexPath.row;
        [self.tableView reloadData];
        
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
