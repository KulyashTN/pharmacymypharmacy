//
//  ViewController.h
//  iOS7_BarcodeScanner
//
//  Created by Jake Widmer on 11/16/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface ScannerViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray * allowedBarcodeTypes;
@property (weak, nonatomic) IBOutlet UITextField *barCodeTextField;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@end
