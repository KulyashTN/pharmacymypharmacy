//
//  Tablets.h
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tablets : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *notes;

@end
