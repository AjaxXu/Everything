//
//  WDWeekdaySelectViewController.h
//  Everything
//
//  Created by Louis on 16/7/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ResponseArray)(NSMutableArray *array);

@interface WDWeekdaySelectViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *weekdays;
@property (nonatomic, copy) ResponseArray block;

- (void)returnBlock:(ResponseArray)block;
@end
