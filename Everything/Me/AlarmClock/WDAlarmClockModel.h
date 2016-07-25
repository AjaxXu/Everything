//
//  WDAlarmClockModel.h
//  Everything
//
//  Created by Louis on 16/7/23.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDAlarmClockModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *bgm;
@property (nonatomic, strong) NSMutableArray *repeatDays;
@property (nonatomic, assign) NSUInteger hour;
@property (nonatomic, assign) NSUInteger minute;
@property (nonatomic, strong) NSString *alertBody;
@property (nonatomic, assign) BOOL isAlarm;

+ (NSString*)getAlarmClockRepeatDaysWithNumbers:(NSArray *)days;
+ (NSString*)getAlarmClockRepeatDaysWithNumbers:(NSArray *)days inDetail:(BOOL)isDetail;


@end
