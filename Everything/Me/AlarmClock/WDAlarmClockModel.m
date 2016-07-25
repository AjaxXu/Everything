//
//  WDAlarmClockModel.m
//  Everything
//
//  Created by Louis on 16/7/23.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmClockModel.h"
#import "NSDate+Utilities.h"

@implementation WDAlarmClockModel

- (instancetype)init
{
    if (self = [super init]) {
        _title = @"闹钟";
        _bgm = @"提醒";
        _alertBody = @"愿每天叫醒你的不是我，是梦想";
        NSDate *date = [NSDate new];
        _hour = date.hour;
        _minute = date.minute;
        _isAlarm = YES;
    }
    return self;
}

- (id)copy
{
    WDAlarmClockModel *model = [[WDAlarmClockModel alloc] init];
    model.title = [self.title copy];
    model.bgm = [self.bgm copy];
    model.alertBody = self.alertBody;
    model.hour = self.hour;
    model.minute = self.minute;
    model._id = [self._id copy];
    model.isAlarm = self.isAlarm;
    model.repeatDays = [self.repeatDays copy];
    return model;
}

+ (NSString*)getAlarmClockRepeatDaysWithNumbers:(NSArray *)days
{
    if (!days || days.count <= 0 || days.count > 7) {
        return nil;
    }
    if (days.count == 7) {
        return @"每天";
    }
    if (days.count == 2 && [days[0] intValue] == 6 && [days[1] intValue] == 7) {
        return @"周末";
    }
    if (days.count == 5 && [days[0] intValue] == 1 && [days[1] intValue] == 2 && [days[2] intValue] == 3 && [days[3] intValue] == 4 && [days[4] intValue] == 5) {
        return @"工作日";
    }
    NSDictionary *dic = @{@1: @"周一 ", @2: @"周二 ", @3: @"周三 ", @4: @"周四 ", @5: @"周五 ", @6: @"周六 ", @7: @"周日" };
    NSMutableString *dayString = [NSMutableString new];
    for (id day in days) {
        [dayString appendString:dic[day]];
    }
    return [NSString stringWithString:dayString];
}

+ (NSString*)getAlarmClockRepeatDaysWithNumbers:(NSArray *)days inDetail:(BOOL)isDetail
{
    NSString *dayString = [WDAlarmClockModel getAlarmClockRepeatDaysWithNumbers:days];
    if (!dayString && isDetail) {
        return @"永不";
    }
    return dayString;
}

@end
