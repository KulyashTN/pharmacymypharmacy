//
//  subViewcontroller.m
//  PPImageScrollingTableViewControllerDemo
//
//  Created by Admin on 11.05.15.
//  Copyright (c) 2015 popochess. All rights reserved.
//

#import "subViewcontroller.h"

@interface subViewcontroller ()

@end

@implementation subViewcontroller

- (void)setDetailImage:(id)newDetailImage
{
    
    _detailImage = newDetailImage;


}

-(void)setDetailText:(id)detailText{
    _detailText=detailText;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configureView
{

    }


- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self configureView];
   // NSLog(@"asd",self.detailImage);
    
    if (self.detailImage) {
        NSLog(@"%@",self.detailImage);
        //self.subViewLabel.text =self.detailImage@"title"];
        self.subViewImageView.image=[UIImage imageNamed:self.detailImage];
        self.subViewTextView.text = self.detailText;
//        self.subViewTextView.text.lineBreakMode = NSLineBreakByWordWrapping;
        
//        [self.subViewTextView ]
        //self.subViewTextView.text=self
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
