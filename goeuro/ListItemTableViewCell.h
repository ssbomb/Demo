//
//  ListItemTableViewCell.h
//  goeuro
//
//  Created by Ray on 2016/11/10.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *travelLogo;
@property (weak, nonatomic) IBOutlet UILabel *travelTime;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *direct;

@property (nonatomic, strong) IBOutlet UIImageView *artWorkImageView;
@property (nonatomic, strong) IBOutlet UILabel *playListNameLabel;
@end
