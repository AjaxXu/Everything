//
//  WDAutographViewController.h
//  Everything
//
//  Created by Louis on 16/7/14.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDAutographViewController : UIViewController

@property (nonatomic, strong) NSString *autograph;
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@end
