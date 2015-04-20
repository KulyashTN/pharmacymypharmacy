//
//  AddTabletViewController.h
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTabletViewController : UIViewController

@property (strong, nonatomic) NSMutableArray * tablets;
@property (weak, nonatomic) IBOutlet UITableView *TabletsTableView;
@property (weak, nonatomic) IBOutlet UILabel *NoTabletLabel;

@end
