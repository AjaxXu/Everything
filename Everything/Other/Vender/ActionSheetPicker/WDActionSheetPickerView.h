//
//  WDActionSheetPickerView.h
//  Everything
//
//  Created by Louis on 16/7/22.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WDActionSheetPickerStyle) {
    
    WDActionSheetPickerStyleTextPicker,
    
    WDActionSheetPickerStyleYearMonthPicker,
    
    WDActionSheetPickerStyleDatePicker,
    
    WDActionSheetPickerStyleTimePicker,
};

@class WDActionSheetPickerView;

/**
 ActionSheetPickerView delegate.
 */
@protocol WDActionSheetPickerViewDelegate <NSObject>

@optional
- (void)actionSheetPickerView:(WDActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles;
- (void)actionSheetPickerView:(WDActionSheetPickerView *)pickerView didSelectDate:(NSDate*)date;
- (void)actionSheetPickerView:(WDActionSheetPickerView *)pickerView didChangeRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)actionSheetPickerViewDidCancel:(WDActionSheetPickerView *)pickerView;
- (void)actionSheetPickerViewWillCancel:(WDActionSheetPickerView *)pickerView;
@end

/**
 ActionSheet style UIPickerView
 */
@interface WDActionSheetPickerView : UIControl

- (instancetype)initWithTitle:(NSString *)title delegate:(id<WDActionSheetPickerViewDelegate>)delegate;

@property(nonatomic, weak) id<WDActionSheetPickerViewDelegate> delegate;

@property(nonatomic, assign) WDActionSheetPickerStyle actionSheetPickerStyle;

@property(nonatomic, strong) UIColor *toolbarTintColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *toolbarButtonColor UI_APPEARANCE_SELECTOR;


///----------------------
/// @name Show / Hide
///----------------------


/**
 Show picker view with slide up animation.
 */
-(void)show;

/**
 Show picker view with slide up animation, completion block will be called on animation completion.
 */
-(void)showWithCompletion:(void (^)(void))completion;

/**
 Dismiss picker view with slide down animation.
 */
-(void)dismiss;

/**
 Dismiss picker view with slide down animation, completion block will be called on animation completion.
 */
-(void)dismissWithCompletion:(void (^)(void))completion;


///-----------------------------------------
/// @name IQActionSheetPickerStyleTextPicker
///-----------------------------------------

/**
 selected titles for each component. Please use [ NSArray of NSString ] format. (Not Animated)
 */
@property(nonatomic, strong) NSArray *selectedTitles;

/**
 set selected titles for each component. Please use [ NSArray of NSString ] format.
 */
-(void)setSelectedTitles:(NSArray *)selectedTitles animated:(BOOL)animated;

/**
 Titles to show for component. Please use [ NSArray(numberOfComponents) of [ NSArray of NSString ](RowValueForEachComponent)] format, even there is single row to show, For example.
 @[ @[ @"1", @"2", @"3", ], @[ @"11", @"12", @"13", ], @[ @"21", @"22", @"23", ]].
 */
@property(nonatomic, strong) NSArray *titlesForComponents;

/**
 Width to adopt for each component. Please use [NSArray of NSNumber/NSNull] format. If you don't want to specify a row width then use NSNull to calculate row width automatically.
 */
@property(nonatomic, strong) NSArray *widthsForComponents;

/**
 Font for the UIPickerView
 */
@property(nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;

/**
 *  Color for the UIPickerView
 */
@property(nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;


/**
 Select the provided index row for each component. Please use [ NSArray of NSNumber ] format for indexes. Ignore if actionSheetPickerStyle is IQActionSheetPickerStyleDatePicker.
 */
-(void)selectIndexes:(NSArray *)indexes animated:(BOOL)animated;

/**
 If YES then it will force to scroll third picker component to pick equal or larger row then the first.
 */
@property(nonatomic, assign) BOOL isRangePickerView;

/**
 Reload a component in pickerView.
 */
-(void)reloadComponent:(NSInteger)component;

/**
 Reload all components in pickerView.
 */
-(void)reloadAllComponents;


/**
 selected date. Can also be use as setter method (not animated).
 */
@property(nonatomic, assign) NSDate *date; //get/set date.

/**
 set selected date.
 */
-(void)setDate:(NSDate *)date animated:(BOOL)animated;

/**
 Minimum selectable date in UIDatePicker. Default is nil.
 */
@property (nonatomic, retain) NSDate *minimumDate;

/**
 Maximum selectable date in UIDatePicker. Default is nil.
 */
@property (nonatomic, retain) NSDate *maximumDate;

@end
