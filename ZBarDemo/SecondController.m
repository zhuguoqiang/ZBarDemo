//
//  SecondController.m
//  ZBarDemo
//
//  Created by 朱国强 on 14-6-19.
//  Copyright (c) 2014年 Apple002. All rights reserved.
//

#import "SecondController.h"

@interface SecondController ()
{
     ZBarReaderView *_readerView;
}

@end

@implementation SecondController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _readerView = [[ZBarReaderView alloc] init];
    _readerView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    _readerView.layer.cornerRadius = 8.0f;
    _readerView.layer.borderWidth= 1.0f;
    _readerView.layer.borderColor = [[UIColor blueColor] CGColor];
    
    _readerView.readerDelegate = self;
    //关闭闪光灯
    _readerView.torchMode = 0;
    
    //扫描区域
    CGRect scanMaskRect = CGRectMake(60, 60, 200, 200);
    
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator = [[ZBarCameraSimulator alloc] initWithViewController:self];
        cameraSimulator.readerView = _readerView;
    }
    [self.view addSubview:_readerView];

    //扫描区域计算
    _readerView.scanCrop = [self getScanCropWithScanRect:scanMaskRect andReaderViewBounds:_readerView.bounds];
    
    [_readerView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZBarReaderViewDelegate

- (void) readerView: (ZBarReaderView*) readerView didReadSymbols: (ZBarSymbolSet*) symbols
fromImage: (UIImage*) image
{
    for (ZBarSymbol *symbol in symbols) {
        NSLog(@"%@", symbol.data);
        [_readerView stop];
    }
}

#pragma mark - Private

- (CGRect)getScanCropWithScanRect:(CGRect)rect andReaderViewBounds:(CGRect)rvBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.y / rvBounds.size.height;
    y = 1 - (rect.origin.x + rect.size.width) / rvBounds.size.width;
    width = rect.size.height / rvBounds.size.height;
    height = rect.size.width / rvBounds.size.width;
    
    return CGRectMake(x, y, width, height);
    
}

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
