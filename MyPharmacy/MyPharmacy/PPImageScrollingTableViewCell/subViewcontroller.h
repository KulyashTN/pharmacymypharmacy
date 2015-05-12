//
//  subViewcontroller.h
//  PPImageScrollingTableViewControllerDemo
//
//  Created by Admin on 11.05.15.
//  Copyright (c) 2015 popochess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subViewcontroller : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *subViewImageView;
@property (weak, nonatomic) IBOutlet UITextView *subViewTextView;
@property (weak, nonatomic) IBOutlet UILabel *subViewLabel;
@property (strong, nonatomic) id detailImage;
@property (strong, nonatomic) id detailText;
@end
