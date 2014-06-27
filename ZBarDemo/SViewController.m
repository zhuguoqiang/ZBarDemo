//
//  SViewController.m
//  ZBarDemo
//
//  Created by 朱国强 on 14-6-19.
//  Copyright (c) 2014年 Apple002. All rights reserved.
//

#import "SViewController.h"

@interface SViewController ()
{
    int num;
    BOOL upOrDown;
    NSTimer *timer;
}

@end

@implementation SViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanBtnAction:(id)sender
{
    num = 0;
    upOrDown = NO;
    
    ZBarReaderViewController *readerViewController = [[ZBarReaderViewController alloc] init];
    readerViewController.readerDelegate = self;
    //支持旋转
    readerViewController.supportedOrientationsMask = ZBarOrientationMaskAll;
    readerViewController.showsHelpOnFail = NO;
    readerViewController.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);//扫描感应框
    
    ZBarImageScanner *scanner = readerViewController.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    readerViewController.showsZBarControls = YES;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 420)];
    view.backgroundColor = [UIColor clearColor];
    readerViewController.cameraOverlayView = view;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)];
    label.text = @"请将扫描的二维码至于下面的框内\n谢谢！";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.lineBreakMode = 0;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    image.frame = CGRectMake(20, 80, 280, 280);
    [view addSubview:image];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _line.image = [UIImage imageNamed:@"qrcode_scan_line.png"];
    [image addSubview:_line];
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    [self presentViewController:readerViewController animated:YES completion:^{
        
    }];
}

-(void)animation1
{
    if (upOrDown == NO) {
        num ++;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (2*num == 260) {
            upOrDown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(30, 10+2*num, 220, 2);
        if (num == 0) {
            upOrDown = NO;
        }
    }
    
    
}

#pragma mark - ZBarReaderDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [timer invalidate];
    _line.frame = CGRectMake(30, 10, 220, 2);
    num = 0;
    upOrDown = NO;
    
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol;
    for (symbol in results)
        break;
    
    self.ImageVScanResult.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.lbScanResult.text = symbol.data;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [timer invalidate];
    _line.frame = CGRectMake(30, 10, 220, 2);
    num = 0;
    upOrDown = NO;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}

- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry
{
    
}

@end
