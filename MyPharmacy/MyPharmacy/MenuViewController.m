//
//  MenuViewController.m
//  Charity
//
//  Created by Tamerlan on 19.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "MenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "UIViewController+MFSideMenuAdditions.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
{
    NSArray *menuItems,*menuItems1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuItems = @[@"Main",@"My pharmacy",@"Add tablet",@"Notes",@"About us"];
    menuItems1 = @[@"",@"",@"",@"",@""];
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.separatorColor = [UIColor clearColor];
    self.tableView1.backgroundColor = [UIColor colorWithRed:2/255.0f green:35/255.0f blue:62/255.0f alpha:1.0f];
    self.headerView.layer.masksToBounds = NO;
    self.headerView.layer.shadowOffset = CGSizeMake(-15, 20);
    self.headerView.layer.shadowRadius = 10;
    self.headerView.layer.shadowOpacity = 0.22;
    // self.clearsSelectionOnViewWillAppear = NO;
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:2/255.0f green:35/255.0f blue:62/255.0f alpha:1.0f];
    
    UIView *selectedColor = [[UIView alloc]init];
    
    selectedColor.backgroundColor = [UIColor colorWithRed:50/255.0f green:76/255.0f blue:98/255.0f alpha:1.0f];
    
    [cell setSelectedBackgroundView:selectedColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    if(indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
    {
        [cell.nameCell setTextColor:[UIColor colorWithRed:190/255.0f green:191/255.0f blue:188/255.0f alpha:1.0f]];
        [cell.iconCell setTextColor:[UIColor colorWithRed:190/255.0f green:191/255.0f blue:188/255.0f alpha:1.0f]];
        cell.imageCell.image = [UIImage imageNamed:@"soon.png"];
    }
    
    cell.nameCell.text = [menuItems objectAtIndex:indexPath.row];
    cell.iconCell.text = [menuItems1 objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    if ((indexPath.row>=0 && indexPath.row<=2) || indexPath.row==6)
    {
        if  (indexPath.row==0)
        {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"event"];
            NSArray *controllers = [NSArray arrayWithObject:viewController];
            navigationController.viewControllers = controllers;
        }else if (indexPath.row==1)
        {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myrequest"];
            NSArray *controllers = [NSArray arrayWithObject:viewController];
            navigationController.viewControllers = controllers;
        }else if (indexPath.row==2)
        {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newrequest"];
            NSArray *controllers = [NSArray arrayWithObject:viewController];
            navigationController.viewControllers = controllers;
        }else if (indexPath.row==6)
        {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
            NSArray *controllers = [NSArray arrayWithObject:viewController];
            navigationController.viewControllers = controllers;
        }
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

-(bool)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
    {
        return NO;
    }
    return YES;
}
@end
