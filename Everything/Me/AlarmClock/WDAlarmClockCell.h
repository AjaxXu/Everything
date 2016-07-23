//
//  WDAlarmClockCell.h
//  Everything
//
//  Created by Louis on 16/7/23.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJSwitch.h"

@class WDAlarmClockModel;

@interface WDAlarmClockCell : UITableViewCell

@property (nonatomic, strong) WDAlarmClockModel *model;

@property (nonatomic, strong) ZJSwitch *isAlarmSwitch;

- (void)changeLayout:(BOOL)isAlarm;

+ (CGFloat)fixedHeight;

@end
