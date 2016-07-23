//
//  WDAppFrameTabBarController.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAppFrameTabBarController.h"

#import "WDNavigationController.h"
#import "WDHomeTableViewController.h"
#import "WDCalendarTableViewController.h"
#import "WDRecordTableViewController.h"
#import "WDMeTableViewController.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface WDAppFrameTabBarController ()

@end

@implementation WDAppFrameTabBarController

+ (void)initialize {
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = WDTabBarNormalColor;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = WDThemeColor;
    
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"WDAlarmClockViewController",
                                   kTitleKey  : @"日历",
                                   kImgKey    : @"tabbar_calendar",
                                   kSelImgKey : @"tabbar_calendarHL"},
                                 
                                 @{kClassKey  : @"WDHomeTableViewController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"tabbar_mainframe",
                                   kSelImgKey : @"tabbar_mainframeHL"},
                                 
                                 @{kClassKey  : @"WDRecordTableViewController",
                                   kTitleKey  : @"记录",
                                   kImgKey    : @"tabbar_record",
                                   kSelImgKey : @"tabbar_recordHL"},
                                 
                                 @{kClassKey  : @"WDMeTableViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tabbar_me",
                                   kSelImgKey : @"tabbar_meHL"}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        WDNavigationController *nav = [[WDNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self addChildViewController:nav];
    }];
}

@end
