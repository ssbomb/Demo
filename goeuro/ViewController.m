//
//  ViewController.m
//  goeuro
//
//  Created by Ray on 2016/9/29.
//  Copyright © 2016年 test. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
#import "GContainerViewController.h"
#import "BusTableViewController.h"
#import "TrainTableViewController.h"
#import "FlightTableViewController.h"

@interface ViewController ()<GContainerViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    

    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM d"];
    NSString *dateStr = [df stringFromDate:now];
    
    UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 230, 40)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont systemFontOfSize:13.0];
    titleView.textColor = [UIColor whiteColor];
    titleView.numberOfLines = 0;
    NSString *title = @"Berlin - Munich \n";
    title = [title stringByAppendingString:dateStr];
    titleView.text = [NSString stringWithFormat:@"%@", title];
    
    self.navigationItem.titleView = titleView;

    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    BusTableViewController *busTableVC =[sb instantiateViewControllerWithIdentifier:@"BusTableViewController"];
    busTableVC.title = @"Bus";
    TrainTableViewController *trainTableVC =[sb instantiateViewControllerWithIdentifier:@"TrainTableViewController"];
    trainTableVC.title = @"Train";
    FlightTableViewController *flightTableVC =[sb instantiateViewControllerWithIdentifier:@"FlightTableViewController"];
    flightTableVC.title = @"Flight";
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.backgroundColor = backgroundColorApp;
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    GContainerViewController *containerVC = [[GContainerViewController alloc]initWithControllers:@[trainTableVC,busTableVC,flightTableVC]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containerVC.view];
    
    self.demoManager  = [DemoManager sharedInstance];
    [self.demoManager getDatafromServer:0 withSucess:^(NSMutableArray *result) {
        
    }];
    [self.demoManager getDatafromServer:1 withSucess:^(NSMutableArray *result) {
        
    }];
    [self.demoManager getDatafromServer:2 withSucess:^(NSMutableArray *result) {
        
    }];
    
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    [topview setBackgroundColor:backgroundColorApp];
    [self.view addSubview:topview];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
