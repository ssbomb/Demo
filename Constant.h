//
//  Constant.h
//  goeuro
//
//  Created by Ray on 2016/10/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

#define backgroundColorApp [UIColor colorWithRed:14.0/255.0 green:97.0/255.0 blue:164.0/255.0 alpha:1.0]
#define indicatorColorApp [UIColor colorWithRed:252.0/255.0 green:156.0/255.0 blue:33.0/255.0 alpha:1.0]

extern NSString * const SHOW_HOME_VIEW_NOTIF;
extern NSString * const SHOW_TAB_BAR_NOTIF;
extern NSString * const CHANGE_ACTIVE_TAB_NOTIF;
extern NSString * const SHAKE_MOTION_NOTIF;
extern NSString * const GOTO_MEMBER_NOTIF;
extern NSString * const LOAD_CATALOG_DB_NOTIF;
extern NSString * const NETWORK_CONNECTED_NOTIF;
extern NSString * const NETWORK_DISCONNECTED_NOTIF;

@end
