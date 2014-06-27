//
//  SViewController.h
//  ZBarDemo
//
//  Created by 朱国强 on 14-6-19.
//  Copyright (c) 2014年 Apple002. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface SViewController : UIViewController <ZBarReaderDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lbScanResult;
@property (strong, nonatomic) IBOutlet UIImageView *ImageVScanResult;

@property (nonatomic, strong) UIImageView *line;

@end
