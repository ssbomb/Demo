//
//  BusTableViewController.h
//  goeuro
//
//  Created by Ray on 2016/10/21.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GContainerViewController.h"
#import "ViewController.h"
#import "BaseViewController.h"
#import "SDWebImageManager.h"

@interface BusTableViewController : BaseViewController<parentViewDelegate,GContainerViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *busTableView;

-(void)postAction;


@end
