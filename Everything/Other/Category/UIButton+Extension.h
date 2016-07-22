//
//  UIButton+Extension.h
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

typedef NS_ENUM(NSInteger, WD_ImagePosition) {
    WD_ImagePositionLeft = 0,              //图片在左，文字在右，默认
    WD_ImagePositionRight = 1,             //图片在右，文字在左
    WD_ImagePositionTop = 2,               //图片在上，文字在下
    WD_ImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (Extension)

// add action blocks
- (void)addAction:(ButtonBlock)block;
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

// add setBackgroundColor
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(WD_ImagePosition)postion spacing:(CGFloat)spacing;

@end
