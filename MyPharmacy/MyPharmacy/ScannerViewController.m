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
    UIAlertView *AddAlertView;
    UITextField *textField,*textField2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCaptureSession];
    textField2.delegate =self;
    _previewLayer.frame = _previewView.bounds;
    [_previewView.layer addSublayer:_previewLayer];
    self.foundBarcodes = [[NSMutableArray alloc] init];
    
    self.barCodeTextField.delegate =self;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startRunning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.barCodeTextField) {
        if ([self.barCodeTextField.text length]>0){
    
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
//        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"title" ]);
//        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"uses" ]);
//        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"contraindications" ]);
//        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"sideEffects" ]);
//        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"howToUse" ]);
//        NSLog(@"%@",[[array objectAtIndex:0]valueForKey:@"overDose" ]);
            AddAlertView = [[UIAlertView alloc]
                                      initWithTitle:@"Attention"
                                      message:@"Please enter quantity and expiration date"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"Ok", nil];
            AddAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            textField = [AddAlertView textFieldAtIndex:0];
            textField2 = [AddAlertView textFieldAtIndex:1];
            
            textField2.delegate=self;
            textField2.secureTextEntry = NO;
            textField.placeholder = @"enter number";
            textField2.placeholder = @"01-01-2015";
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            dispatch_async(dispatch_get_main_queue(), ^{
                [AddAlertView show];
            });
        }else{
            
        }
        [databaseManager close];
        
        NSString * alertMessage = @"You found a barcode with type ";
        alertMessage = [alertMessage stringByAppendingString:[barcode getBarcodeType]];
        alertMessage = [alertMessage stringByAppendingString:@" and data "] ;
        alertMessage = [alertMessage stringByAppendingString:[barcode getBarcodeData]];

        alertMessage = [alertMessage stringByAppendingString:@"\n\nBarcode added to array of "];
        alertMessage = [alertMessage stringByAppendingString:[NSString stringWithFormat:@"%lu",(unsigned long)[self.foundBarcodes count]-1]];
        alertMessage = [alertMessage stringByAppendingString:@" previously found barcodes."];
        
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Barcode Found!"
//                                                          message:alertMessage
//                                                         delegate:self
//                                                cancelButtonTitle:@"Done"
//                                                otherButtonTitles:@"Scan again",nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Code to update the UI/send notifications based on the results of the background processing
//            [message show];

        });
    });
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if (alertView == AddAlertView){
            
        }else{
        
        }
    }
    if(buttonIndex == 1){
        if (alertView == AddAlertView){
            if ([textField2.text length]==10){
                NSString *day = [textField2.text substringWithRange:NSMakeRange(0,2)];
                NSString *month = [textField2.text substringWithRange:NSMakeRange(3,2)];
                NSString *year = [textField2.text substringWithRange:NSMakeRange(6,4)];
                if ([day intValue]>31 || [month intValue]>12 || [year intValue]<2015){
//                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The date is not correct" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
//                    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.translation.x" ];
//                    [move setFromValue:[NSNumber numberWithFloat:0.0f]];
//                    [move setToValue:[NSNurmber numberWithFloat:100.0f]];
//                    [move setDuration:1.0f];
//                    //Add animation to a specific element's layer. Must be called after the element is displayed.
//                    [[AddAlertView layer] addAnimation:move forKey:@"transform.translation.x"];
                    
//                    [AddAlertView animationDidStart:animation];

                    textField2.layer.cornerRadius=8.0f;
                    textField2.layer.masksToBounds=YES;
                    textField2.layer.borderColor=[[UIColor redColor]CGColor];
                    textField2.layer.borderWidth= 1.0f;
                    [AddAlertView show];
//                    CGRect napkinTopFrame = AddAlertView.frame;
//                    napkinTopFrame.origin.y = -napkinTopFrame.size.height;
//                    CGRect napkinBottomFrame = AddAlertView.frame;
//                    napkinBottomFrame.origin.y = AddAlertView.bounds.size.height;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [UIView animateWithDuration:1
//                                              delay:1.5
//                                            options: UIViewAnimationCurveEaseIn
//                                         animations:^{
//                                             AddAlertView.frame = napkinTopFrame;
//                                             AddAlertView.frame = napkinBottomFrame;
//                                         }
//                                         completion:^(BOOL finished){
//                                             NSLog(@"Done!");
//                                         }];
//                    });
                    textField2.text=@"";
                    [textField2 setPlaceholder:@"01-01-2015"];
                }else{
//                        NSUSERDEFAULT
                
                }
            }else{
                    NSLog(@"asdasd");
            }
        }else{
            [self startRunning];
        }
    }
}

#pragma MASKA TELEPHON
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    int length = (int)[mobileNumber length];
    if(length > 4) {
        mobileNumber = [mobileNumber substringFromIndex: length-4];
    }
    return mobileNumber;
}

-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = (int)[mobileNumber length];
    return length;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == textField2){
        NSString *nameRegex = @"[0-9]+";
        NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
        if (string.length==0) {
            return YES;
        }
        else if(![nameTest evaluateWithObject:string]){
            return NO;
        }
        
        int length = [self getLength:textField2.text];
        
        if(length == 8) {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 2) {
            NSString *num = [self formatNumber:textField2.text];
            textField2.text = [NSString stringWithFormat:@" %@-",num];
            if(range.length > 0)
                textField2.text = [NSString stringWithFormat:@" %@",[num substringToIndex:2]];
        }
        else if(length == 4) {
            NSString *num = [self formatNumber:textField2.text];
            textField2.text = [NSString stringWithFormat:@" %@-%@-",[num substringToIndex:2],[num substringFromIndex:2]];
            if(range.length > 0)
                textField2.text = [NSString stringWithFormat:@" %@-%@",[num substringToIndex:2],[num substringFromIndex:2]];
        }
        return YES;
    }
    return YES;
}

@end


