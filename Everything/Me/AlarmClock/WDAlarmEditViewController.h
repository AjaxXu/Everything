//
//  WDAlarmEditViewController.h
//  Everything
//
//  Created by Louis on 16/7/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WDAlarmClockModel;

typedef void (^ReturnAlarmModel)(WDAlarmClockModel *model);

@interface WDAlarmEditViewController : UIViewController

@property (nonatomic, strong) WDAlarmClockModel *model;
@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, copy) ReturnAlarmModel block;

- (void)returnBlock: (ReturnAlarmModel)returnBlock;

@end
