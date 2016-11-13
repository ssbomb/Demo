//
//  BaseViewController.m
//  goeuro
//
//  Created by Ray on 2016/11/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import "BaseViewController.h"
#import "DemoManager.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.demoManager = [DemoManager sharedInstance];
    if(self.imageManager == nil)
        self.imageManager = [SDWebImageManager sharedManager];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
