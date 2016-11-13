//
//  ViewController.h
//  goeuro
//
//  Created by Ray on 2016/9/29.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "DemoManager.h"

@protocol parentViewDelegate <NSObject>

-(void)sortClicked:(id)sender;

@end

@interface ViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) DemoManager *demoManager;

@end

