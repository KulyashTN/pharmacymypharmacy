//
//  ViewController.m
//  MyPharmacy
//
//  Created by Tamerlan on 24.02.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "ViewController.h"
#import "MFSideMenu.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)showLeftMenuPressed:(id)sender {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
