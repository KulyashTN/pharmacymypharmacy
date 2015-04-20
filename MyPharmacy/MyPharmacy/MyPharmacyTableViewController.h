//
//  MyPharmacyTableViewController.h
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPharmacyTableViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSArray * tablets;
@property (weak, nonatomic) IBOutlet UITableView *TabletsTableView;
@property (weak, nonatomic) IBOutlet UILabel *NoTabletLabel;
@end
