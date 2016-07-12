//
//  WDLabelView.m
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDLabelView.h"

@implementation WDLabelView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithEdgeInsets: (UIEdgeInsets)insets
{
    if (self = [super init])
    {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = RGB(161, 160, 165);
        self.backgroundColor = WDGlobalBackgroundColor;
        [self addSubview:_label];
        _label.sd_layout.centerYEqualToView(self).spaceToSuperView(insets);
    }
    return self;
}

@end
