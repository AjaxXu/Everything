//
//  WDNavigationController.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDNavigationController.h"

@implementation WDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = WDThemeColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.statusBarStyle = UIStatusBarStyleLightContent;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        // 替换back按钮
        //        UIBarButtonItem *backBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"backStretchBackgroundNormal"
        //                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
        //                                                                                  target:self
        //                                                                                  action:@selector(back)];
        //        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
