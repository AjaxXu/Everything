//
//  WDActionSheetViewController.h
//  Everything
//
//  Created by Louis on 16/7/22.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDActionSheetPickerView;

@interface WDActionSheetViewController : UIViewController

@property(nonatomic, strong, readonly) WDActionSheetPickerView *pickerView;

- (void)showPickerView:(WDActionSheetPickerView*)pickerView completion:(void (^)(void))completion;
- (void)dismissWithCompletion:(void (^)(void))completion;

@end