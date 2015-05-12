//
//  UIBorderLabel.m
//  MyPharmacy
//
//  Created by Tamerlan Imanov on 30.04.15.
//  Copyright (c) 2015 Tamerlan. All rights reserved.
//

#import "UIBorderLabel.h"

@implementation UIBorderLabel
@synthesize topInset, leftInset, bottomInset, rightInset;

-(void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {
                            self.topInset,
                            self.leftInset,
                            self.bottomInset,
                            self.rightInset
                            };
    
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end
