//
//  ViewController.m
//  iOS7_BarcodeScanner
//
//  Created by Jake Widmer on 11/16/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//


#import "ScannerViewController.h"
#import "Barcode.h"
#import "DatabaseManager.h"
@import AVFoundation;   // iOS7 only import style

@interface ScannerViewController ()
@property(strong, nonatomic) NSMutableArray * tablets;
@property (strong, nonatomic) NSMutableArray * foundBarcodes;
@property (weak, nonatomic) IBOutlet UIView *previewView;

@end

@implementation ScannerViewController{
    AVCaptureSession *_captureSession;
    AVCaptureDevice *_videoDevice;
    AVCaptureDeviceInput *_videoInput;
    AVCaptureVideoPreviewLayer *_previewLayer;
    BOOL _running;
    AVCaptureMetadataOutput *_metadataOutput;
    DatabaseManager * databaseManager;
    UIAlertView *AddAlertView,*message;
    UITextField *textField1,*textField2;
    NSString* nameTablet;
    NSMutableDictionary *dataDict;
}

-(NSMutableArray *)tablets{
    if (!_tablets){
        _tablets= [[[NSUserDefaults standardUserDefaults] objectForKey:@"myPharmacyKey"] mutableCopy];
    }
    if (!_tablets)  _tablets = [[NSMutableArray alloc]init];
    return _tablets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataDict = [[NSMutableDictionary alloc]init];
    self.datePicker.hidden = YES;
    
    textField2.delegate = self;
    
    [self setupCaptureSession];
    _previewLayer.frame = _previewView.bounds;
    [_previewView.layer addSublayer:_previewLayer];
    self.foundBarcodes = [[NSMutableArray alloc] init];
    
    self.barCodeTextField.delegate =self;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    AddAlertView = [[UIAlertView alloc]
                    initWithTitle:@"Attention"
                    message:@"Please enter quantity and expiration date"
                    delegate:self
                    cancelButtonTitle:@"Cancel"
                    otherButtonTitles:@"Ok", nil];
    AddAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;

    [_previewView addSubview:AddAlertView];
    [_previewView addGestureRecognizer:tapGesture];
    
    // listen for going into the background and stop the session
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationWillEnterForeground:)
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationDidEnterBackground:)
     name:UIApplicationDidEnterBackgroundNotification
     object:nil];
    
    // set default allowed barcode types, remove types via setings menu if you don't want them to be able to be scanned
    self.allowedBarcodeTypes = [NSMutableArray new];
    [self.allowedBarcodeTypes addObject:@"org.iso.QRCode"];
    [self.allowedBarcodeTypes addObject:@"org.iso.PDF417"];
    [self.allowedBarcodeTypes addObject:@"org.gs1.UPC-E"];
    [self.allowedBarcodeTypes addObject:@"org.iso.Aztec"];
    [self.allowedBarcodeTypes addObject:@"org.iso.Code39"];
    [self.allowedBarcodeTypes addObject:@"org.iso.Code39Mod43"];
    [self.allowedBarcodeTypes addObject:@"org.gs1.EAN-13"];
    [self.allowedBarcodeTypes addObject:@"org.gs1.EAN-8"];
    [self.allowedBarcodeTypes addObject:@"com.intermec.Code93"];
    [self.allowedBarcodeTypes addObject:@"org.iso.Code128"];
    
#pragma DB
     databaseManager = [[DatabaseManager alloc] init];
}


-(void)hideKeyBoard {
    [self.barCodeTextField resignFirstResponder];
    self.datePicker.hidden = YES;
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startRunning];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == textField2) {
        [textField2 resignFirstResponder];
        self.datePicker.hidden = NO;
    }else if (textField == self.barCodeTextField){
        [self stopRunning];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.barCodeTextField) {
        self.datePicker.hidden = NO;
        if ([self.barCodeTextField.text length]>0){
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // Code to do in background processing
                
                NSArray * array = [databaseManager findeCity:[NSString stringWithFormat:@"%@",self.barCodeTextField.text]];
                NSLog(@"%lu",(unsigned long)[array count]);
                if ([array count]>0){
                    //        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"title" ]);
                    //        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"uses" ]);
                    //        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"contraindications" ]);
                    //        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"sideEffects" ]);
                    //        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"howToUse" ]);
                    //        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"overDose" ]);
                    textField1 = [AddAlertView textFieldAtIndex:0];
                    textField2 = [AddAlertView textFieldAtIndex:1];
                    textField2.secureTextEntry = NO;
                    
                    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
                    [dateformate setDateFormat:@"dd MMM YYYY"];
                    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
                    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
                    textField2.text = date_String;
                    
                    [self.datePicker removeFromSuperview];
                    textField2.inputView = self.datePicker;
                    
                    textField1.placeholder = @"enter quanity of tablet";
                    textField1.keyboardType = UIKeyboardTypeNumberPad;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [AddAlertView show];
                    });
                }else{
                    message = [[UIAlertView alloc] initWithTitle:@"Barcode not found!"
                                                         message:@"Please, try to write barcode by yourself"
                                                        delegate:self
                                               cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [message show];
                        
                    });
                }
                [databaseManager close];
            });
        }else{
            [self hideKeyBoard];
        }
        return NO;
    }
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - AV capture methods

- (void)setupCaptureSession {
    // 1
    if (_captureSession) return;
    // 2
    _videoDevice = [AVCaptureDevice
                    defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!_videoDevice) {
        NSLog(@"No video camera on this device!");
        return;
    }
    // 3
    _captureSession = [[AVCaptureSession alloc] init];
    // 4
    _videoInput = [[AVCaptureDeviceInput alloc]
                   initWithDevice:_videoDevice error:nil];
    // 5
    if ([_captureSession canAddInput:_videoInput]) {
        [_captureSession addInput:_videoInput];
    }
    // 6
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc]
                     initWithSession:_captureSession];
    _previewLayer.videoGravity =
    AVLayerVideoGravityResizeAspectFill;
    
    
    // capture and process the metadata
    _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    dispatch_queue_t metadataQueue =
    dispatch_queue_create("com.1337labz.featurebuild.metadata", 0);
    [_metadataOutput setMetadataObjectsDelegate:self
                                          queue:metadataQueue];
    if ([_captureSession canAddOutput:_metadataOutput]) {
        [_captureSession addOutput:_metadataOutput];
    }
}

- (void)startRunning {
    if (_running) return;
    [_captureSession startRunning];
    _metadataOutput.metadataObjectTypes =
    _metadataOutput.availableMetadataObjectTypes;
    _running = YES;
}
- (void)stopRunning {
    if (!_running) return;
    [_captureSession stopRunning];
    _running = NO;
}

//  handle going foreground/background
- (void)applicationWillEnterForeground:(NSNotification*)note {
    [self startRunning];
}
- (void)applicationDidEnterBackground:(NSNotification*)note {
    [self stopRunning];
}

#pragma mark - Delegate functions

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    [metadataObjects
     enumerateObjectsUsingBlock:^(AVMetadataObject *obj,
                                  NSUInteger idx,
                                  BOOL *stop)
     {
         if ([obj isKindOfClass:
              [AVMetadataMachineReadableCodeObject class]])
         {
             // 3
             AVMetadataMachineReadableCodeObject *code =
             (AVMetadataMachineReadableCodeObject*)
             [_previewLayer transformedMetadataObjectForMetadataObject:obj];
             // 4
             Barcode * barcode = [Barcode processMetadataObject:code];
             
             for(NSString * str in self.allowedBarcodeTypes){
                if([barcode.getBarcodeType isEqualToString:str]){
                    [self validBarcodeFound:barcode];
                    return;
                }
            }
         }
     }];
}

- (void) validBarcodeFound:(Barcode *)barcode{
    [self stopRunning];
    [self.foundBarcodes addObject:barcode];
    [self showBarcodeAlert:barcode];
}
- (void) showBarcodeAlert:(Barcode *)barcode{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Code to do in background processing
        
        NSArray * array = [databaseManager findeCity:[NSString stringWithFormat:@"%@",[barcode getBarcodeData]]];
        NSLog(@"%lu",(unsigned long)[array count]);
        if ([array count]>0){
            nameTablet = [NSString stringWithFormat:@"%@",[[array objectAtIndex:0]valueForKey:@"title" ]];
//                    NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"uses" ]);
//                    NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"contraindications" ]);
//                    NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"sideEffects" ]);
//                    NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"howToUse" ]);
//                    NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"overDose" ]);
            textField1 = [AddAlertView textFieldAtIndex:0];
            textField2 = [AddAlertView textFieldAtIndex:1];
            textField2.delegate=self;
            textField2.secureTextEntry = NO;
            
            NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
            [dateformate setDateFormat:@"dd MMM YYYY"];
            NSString *date_String=[dateformate stringFromDate:[NSDate date]];
            self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
            textField2.text = date_String;
            
            [self.datePicker removeFromSuperview];
            textField2.inputView = self.datePicker;
            textField1.placeholder = @"enter quanity of tablet";
            textField1.keyboardType = UIKeyboardTypeNumberPad;
            dispatch_async(dispatch_get_main_queue(), ^{
                [AddAlertView show];
            });
        }else{
            message = [[UIAlertView alloc] initWithTitle:@"Barcode not found!"
                                                 message:@"Please, try to write barcode by yourself"
                                                delegate:self
                                       cancelButtonTitle:@"Ok"
                                       otherButtonTitles:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [message show];
                
            });
        }
        [databaseManager close];
    });
}

-(BOOL) alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    return [[alertView textFieldAtIndex:0].text length] > 0;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if (alertView == AddAlertView){
            [self performSegueWithIdentifier:@"back" sender:self];
        }
    }
    if(buttonIndex == 1){
        if (alertView == AddAlertView){
            if ([textField1.text length]==0){
                textField1.text=@"";
                textField1.layer.cornerRadius=8.0f;
                textField1.layer.masksToBounds=YES;
                textField1.layer.borderColor=[[UIColor redColor]CGColor];
                textField1.layer.borderWidth= 1.0f;
                [AddAlertView show];
            }else{
                [self hideKeyBoard];
                NSString* quantityTablet = textField1.text;
                NSString *dateString = textField2.text;
                [dataDict setObject:nameTablet forKey:@"nameOfTablet"];
                [dataDict setObject:quantityTablet forKey:@"qualityOfTablet"];
                [dataDict setObject:dateString forKey:@"expOfDate"];
                [self.tablets addObject:dataDict];
                [[NSUserDefaults standardUserDefaults] setObject:self.tablets forKey:@"myPharmacyKey"];
                [self performSegueWithIdentifier:@"back" sender:self];
            }
        }
    }
}
@end


