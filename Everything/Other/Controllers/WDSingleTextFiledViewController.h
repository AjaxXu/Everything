//
//  WDSingleTextFiledViewController.h
//  Everything
//
//  Created by Louis on 16/7/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDSingleTextFiledViewController : UIViewController

@property (nonatomic, strong) NSString *text;
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@end
