//
//  AddTablet.h
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 02.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTablet : UITableViewController
- (IBAction)Add:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UILabel *noTabletLabel;

@end
