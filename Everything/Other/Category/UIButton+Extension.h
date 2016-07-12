//
//  UIButton+Extension.h
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Extension)

// add action blocks
- (void)addAction:(ButtonBlock)block;
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

// add setBackgroundColor
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end
