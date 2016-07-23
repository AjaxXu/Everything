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
@property (nonatomic, strong) NSString *bgm;
@property (nonatomic, strong) NSArray *repeatDays;
@property (nonatomic, assign) NSUInteger hour;
@property (nonatomic, assign) NSUInteger minute;
@property (nonatomic, strong) NSString *alertBody;
@property (nonatomic, assign) BOOL isAlarm;

@end
