//
//  GContainerViewController.h
//  goeuro
//
//  Created by Ray on 2016/10/12.
//  Copyright © 2016年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GContainerViewControllerDelegate <NSObject>

-(void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller;
-(void)postListViewAction;
@end

@interface GContainerViewController : UIViewController
@property (nonatomic, weak) id <GContainerViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong, readonly) NSMutableArray *titles;
@property (nonatomic, strong, readonly) NSMutableArray *childControllers;

@property (nonatomic, strong) UIFont  *menuItemFont;
@property (nonatomic, strong) UIColor *menuItemTitleColor;
@property (nonatomic, strong) UIColor *menuItemSelectedTitleColor;
@property (nonatomic, strong) UIColor *menuBackGroudColor;
@property (nonatomic, strong) UIColor *menuIndicatorColor;

- (id)initWithControllers:(NSArray *)controllers
             topBarHeight:(CGFloat)topBarHeight
     parentViewController:(UIViewController *)parentViewController;
@end
