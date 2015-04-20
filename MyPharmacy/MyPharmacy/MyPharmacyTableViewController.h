//
//  MyPharmacyTableViewController.h
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 07.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPharmacyTableViewController : UITableViewController <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray * tablets;

@end
