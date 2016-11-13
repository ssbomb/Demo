//
//  BaseViewController.h
//  goeuro
//
//  Created by Ray on 2016/11/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
#import "DemoManager.h"

@interface BaseViewController : UIViewController
@property (nonatomic, strong) SDWebImageManager *imageManager;
@property (nonatomic, strong) DemoManager *demoManager;

@end
