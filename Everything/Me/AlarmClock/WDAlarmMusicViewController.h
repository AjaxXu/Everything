//
//  WDAlarmMusicViewController.h
//  Everything
//
//  Created by Louis on 16/7/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDAlarmMusicViewController : UIViewController

@property (nonatomic, strong) NSString *music;
@property (nonatomic, copy) ReturnTextBlock block;

- (void)returnBlock:(ReturnTextBlock)returnBlock;

@end
