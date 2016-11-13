//
//  DemoManager.h
//  goeuro
//
//  Created by ray on 2016/11/11.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoManager : NSObject
+ (DemoManager *)sharedInstance;
-(void)getDatafromServer:(int)page withSucess:(void(^)(NSMutableArray*))success;
@end
