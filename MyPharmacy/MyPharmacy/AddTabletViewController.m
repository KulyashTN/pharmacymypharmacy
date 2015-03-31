//
//  AddTabletViewController.m
//  MyPharmacy
//
//  Created by Kulyash Orazbekova on 31.03.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "AddTabletViewController.h"

@interface AddTabletViewController ()

@end

@implementation AddTabletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary* d = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AlarmTabletArray"] mutableCopy];
    if([d isEqual:nil]){
        [self.NoTabletLabel setHidden:NO];
        [self.TabletsTableView setHidden:YES];
        [self.view bringSubviewToFront:self.NoTabletLabel];
    }
    else{
        [self.NoTabletLabel setHidden:YES];
        [self.TabletsTableView setHidden:NO];
        [self.view bringSubviewToFront:self.TabletsTableView];
    }
}


- (IBAction)AddTabletButton:(UIBarButtonItem *)sender {
    
}
@end
