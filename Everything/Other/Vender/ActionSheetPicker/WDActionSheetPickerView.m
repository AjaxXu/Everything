//
//  WDActionSheetPickerView.m
//  Everything
//
//  Created by Louis on 16/7/22.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDActionSheetPickerView.h"

#import <QuartzCore/QuartzCore.h>
#import "WDActionSheetViewController.h"
#import "WDYearMonthDatePickView.h"

@interface WDActionSheetPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) WDYearMonthDatePickView *yearMonthPickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *actionToolbar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) WDActionSheetViewController *actionSheetController;

@end

@implementation WDActionSheetPickerView

@synthesize actionSheetPickerStyle  = _actionSheetPickerStyle;
@synthesize titlesForComponents     = _titlesForComponents;
@synthesize widthsForComponents     = _widthsForComponents;
@synthesize isRangePickerView       = _isRangePickerView;
@synthesize delegate                = _delegate;
@synthesize date                    = _date;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithTitle:(NSString *)title delegate:(id<WDActionSheetPickerViewDelegate>)delegate
{
    self = [super initWithFrame:CGRectZero];
    
    if (self)
    {
        //UIToolbar
        {
            _actionToolbar = [[UIToolbar alloc] init];
            _actionToolbar.barStyle = UIBarStyleDefault;
            [_actionToolbar sizeToFit];
            
            CGRect toolbarFrame = _actionToolbar.frame;
            toolbarFrame.size.height = 44;
            _actionToolbar.frame = toolbarFrame;
            
            _actionToolbar.barTintColor = WDThemeColor;
            _actionToolbar.tintColor = [UIColor whiteColor];
            
            NSMutableArray *items = [[NSMutableArray alloc] init];
            
            //  Create a cancel button to show on keyboard to resign it. Adding a selector to resign it.
            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancelClicked:)];
            [items addObject:cancelButton];
            
            //  Create a fake button to maintain flexibleSpace between cancelButton and titleLabel.(Otherwise the titleLabel will lean to the left）
            UIBarButtonItem *leftNilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [items addObject:leftNilButton];
            
            //  Create a title label to show on toolBar for the title you need.
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _actionToolbar.frame.size.width-66-57.0-16, 44)];
            _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            [_titleLabel setBackgroundColor:[UIColor clearColor]];
            [_titleLabel setTextColor:[UIColor whiteColor]];
            [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_titleLabel setText:title];
            [_titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            
            UIBarButtonItem *titlebutton = [[UIBarButtonItem alloc] initWithCustomView:_titleLabel];
            //            titlebutton.enabled = NO;
            [items addObject:titlebutton];
            
            
            //  Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
            UIBarButtonItem *rightNilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [items addObject:rightNilButton];
            
            //  Create a done button to show on keyboard to resign it. Adding a selector to resign it.
            UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked:)];
            [items addObject:doneButton];
            
            //  Adding button to toolBar.
            [_actionToolbar setItems:items];
            
            [self addSubview:_actionToolbar];
        }
        
        //UIPickerView
        {
            _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_actionToolbar.frame) , CGRectGetWidth(_actionToolbar.frame), 216)];
            _pickerView.backgroundColor = [UIColor whiteColor];
            [_pickerView setShowsSelectionIndicator:YES];
            [_pickerView setDelegate:self];
            [_pickerView setDataSource:self];
            [self addSubview:_pickerView];
        }
        
        //Year Month PickerView
        {
            _yearMonthPickerView = [[WDYearMonthDatePickView alloc] initWithFrame:_pickerView.frame];
            [self addSubview:_yearMonthPickerView];
        }
        
        //UIDatePicker
        {
            _datePicker = [[UIDatePicker alloc] initWithFrame:_pickerView.frame];
            [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            _datePicker.frame = _pickerView.frame;
            [_datePicker setDatePickerMode:UIDatePickerModeDate];
            [self addSubview:_datePicker];
        }
        
        //Initial settings
        {
            self.backgroundColor = [UIColor whiteColor];
            [self setFrame:CGRectMake(0, 0, CGRectGetWidth(_pickerView.frame), CGRectGetMaxY(_pickerView.frame))];
            [self setActionSheetPickerStyle:WDActionSheetPickerStyleTextPicker];
            
            self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            _actionToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _yearMonthPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
    }
    
    _delegate = delegate;
    
    return self;
}

-(void)setActionSheetPickerStyle:(WDActionSheetPickerStyle)actionSheetPickerStyle
{
    _actionSheetPickerStyle = actionSheetPickerStyle;
    
    switch (actionSheetPickerStyle) {
        case WDActionSheetPickerStyleTextPicker:
            [_pickerView setHidden:NO];
            [_yearMonthPickerView setHidden:YES];
            [_datePicker setHidden:YES];
            break;
        case WDActionSheetPickerStyleYearMonthPicker:
            [_yearMonthPickerView setHidden:NO];
            [_pickerView setHidden:YES];
            [_datePicker setHidden:YES];
            break;
        case WDActionSheetPickerStyleDatePicker:
            [_pickerView setHidden:YES];
            [_yearMonthPickerView setHidden:YES];
            [_datePicker setHidden:NO];
            [_datePicker setDatePickerMode:UIDatePickerModeDate];
            break;
        case WDActionSheetPickerStyleTimePicker:
            [_pickerView setHidden:YES];
            [_yearMonthPickerView setHidden:YES];
            [_datePicker setHidden:NO];
            [_datePicker setDatePickerMode:UIDatePickerModeTime];
            break;
            
        default:
            break;
    }
}

/**
 *  Set Action Bar Color
 *
 *  @param barColor Custom color for toolBar
 */
-(void)setToolbarTintColor:(UIColor *)toolbarTintColor{
    _toolbarTintColor = toolbarTintColor;
    
    [_actionToolbar setBarTintColor:toolbarTintColor];
}

/**
 *  Set Action Tool Bar Button Color
 *
 *  @param buttonColor Custom color for toolBar button
 */
-(void)setToolbarButtonColor:(UIColor *)toolbarButtonColor{
    _toolbarButtonColor = toolbarButtonColor;
    
    [_actionToolbar setTintColor:toolbarButtonColor];
}

/*!
 Font for the UIPickerView
 */
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    [_titleLabel setFont:titleFont];
}

/*!
 *  Color for the UIPickerView
 */
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    [_titleLabel setTextColor:titleColor];
}

#pragma mark - Done/Cancel

-(void)pickerCancelClicked:(UIBarButtonItem*)barButton
{
    if ([self.delegate respondsToSelector:@selector(actionSheetPickerViewWillCancel:)])
    {
        [self.delegate actionSheetPickerViewWillCancel:self];
    }
    
    [self dismissWithCompletion:^{
        
        if ([self.delegate respondsToSelector:@selector(actionSheetPickerViewDidCancel:)])
        {
            [self.delegate actionSheetPickerViewDidCancel:self];
        }
    }];
}

-(void)pickerDoneClicked:(UIBarButtonItem*)barButton
{
    switch (_actionSheetPickerStyle)
    {
        case WDActionSheetPickerStyleTextPicker:
        {
            NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
            
            for (NSInteger component = 0; component<_pickerView.numberOfComponents; component++)
            {
                NSInteger row = [_pickerView selectedRowInComponent:component];
                
                if (row!= -1)
                {
                    [selectedTitles addObject:_titlesForComponents[component][row]];
                }
                else
                {
                    [selectedTitles addObject:[NSNull null]];
                }
            }
            
            [self setSelectedTitles:selectedTitles];
            
            if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didSelectTitles:)])
            {
                [self.delegate actionSheetPickerView:self didSelectTitles:selectedTitles];
            }
            
        }
            break;
        case WDActionSheetPickerStyleYearMonthPicker:
        {
            [self setDate:_yearMonthPickerView.date];
            if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didSelectDate:)])
            {
                [self.delegate actionSheetPickerView:self didSelectDate:_yearMonthPickerView.date];
                
            }
        }
            break;
        case WDActionSheetPickerStyleDatePicker:
        case WDActionSheetPickerStyleTimePicker:
        {
            [self setDate:_datePicker.date];
            
            [self setSelectedTitles:@[_datePicker.date]];
            
            if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didSelectDate:)])
            {
                [self.delegate actionSheetPickerView:self didSelectDate:_datePicker.date];
            }
        }
            
        default:
            break;
    }
    
    [self dismiss];
}

#pragma mark - WDActionSheetPickerStyleDatePicker / WDActionSheetPickerStyleDateTimePicker / WDActionSheetPickerStyleTimePicker

-(void)dateChanged:(UIDatePicker*)datePicker
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void) setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}

-(void)setDate:(NSDate *)date animated:(BOOL)animated
{
    _date = date;
    if (_date != nil)   [_datePicker setDate:_date animated:animated];
}

-(void)setMinimumDate:(NSDate *)minimumDate
{
    _minimumDate = minimumDate;
    
    _datePicker.minimumDate = minimumDate;
}

-(void)setMaximumDate:(NSDate *)maximumDate
{
    _maximumDate = maximumDate;
    
    _datePicker.maximumDate = maximumDate;
}

#pragma mark - WDActionSheetPickerStyleTextPicker

-(void)reloadComponent:(NSInteger)component
{
    [_pickerView reloadComponent:component];
}

-(void)reloadAllComponents
{
    [_pickerView reloadAllComponents];
}

-(void)setSelectedTitles:(NSArray *)selectedTitles
{
    [self setSelectedTitles:selectedTitles animated:NO];
}

-(NSArray *)selectedTitles
{
    if (_actionSheetPickerStyle == WDActionSheetPickerStyleTextPicker)
    {
        NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
        
        NSUInteger totalComponent = _pickerView.numberOfComponents;
        
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSInteger selectedRow = [_pickerView selectedRowInComponent:component];
            
            if (selectedRow == -1)
            {
                [selectedTitles addObject:[NSNull null]];
            }
            else
            {
                NSArray *items = _titlesForComponents[component];
                
                if ([items count] > selectedRow)
                {
                    id selectTitle = items[selectedRow];
                    [selectedTitles addObject:selectTitle];
                }
                else
                {
                    [selectedTitles addObject:[NSNull null]];
                }
            }
        }
        
        return selectedTitles;
    }
    else
    {
        return nil;
    }
}

-(void)setSelectedTitles:(NSArray *)selectedTitles animated:(BOOL)animated
{
    if (_actionSheetPickerStyle == WDActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = MIN(selectedTitles.count, _pickerView.numberOfComponents);
        
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSArray *items = _titlesForComponents[component];
            id selectTitle = selectedTitles[component];
            
            if ([items containsObject:selectTitle])
            {
                NSUInteger rowIndex = [items indexOfObject:selectTitle];
                [_pickerView selectRow:rowIndex inComponent:component animated:animated];
            }
        }
    }
}

-(void)selectIndexes:(NSArray *)indexes animated:(BOOL)animated
{
    if (_actionSheetPickerStyle == WDActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = MIN(indexes.count, _pickerView.numberOfComponents);
        
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSArray *items = _titlesForComponents[component];
            NSUInteger selectIndex = [indexes[component] unsignedIntegerValue];
            
            if (selectIndex < items.count)
            {
                [_pickerView selectRow:selectIndex inComponent:component animated:animated];
            }
        }
    }
}

#pragma mark - UIPickerView delegate/dataSource

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    //If having widths
    if (_widthsForComponents)
    {
        //If object isKind of NSNumber class
        if ([_widthsForComponents[component] isKindOfClass:[NSNumber class]])
        {
            CGFloat width = [_widthsForComponents[component] floatValue];
            
            //If width is 0, then calculating it's size.
            if (width == 0)
                return ((pickerView.bounds.size.width-20)-2*(_titlesForComponents.count-1))/_titlesForComponents.count;
            //Else returning it's width.
            else
                return width;
        }
        //Else calculating it's size.
        else
            return ((pickerView.bounds.size.width-20)-2*(_titlesForComponents.count-1))/_titlesForComponents.count;
    }
    //Else calculating it's size.
    else
    {
        return ((pickerView.bounds.size.width-20)-2*(_titlesForComponents.count-1))/_titlesForComponents.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [_titlesForComponents count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titlesForComponents[component] count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labelText = [[UILabel alloc] init];
    if(self.titleFont == nil){
        labelText.font = [UIFont boldSystemFontOfSize:20.0];
    }else{
        labelText.font = self.titleFont;
    }
    labelText.backgroundColor = [UIColor clearColor];
    [labelText setTextAlignment:NSTextAlignmentCenter];
    [labelText setText:_titlesForComponents[component][row]];
    return labelText;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_isRangePickerView && pickerView.numberOfComponents == 3)
    {
        if (component == 0)
        {
            [pickerView selectRow:MAX([pickerView selectedRowInComponent:2], row) inComponent:2 animated:YES];
        }
        else if (component == 2)
        {
            [pickerView selectRow:MIN([pickerView selectedRowInComponent:0], row) inComponent:0 animated:YES];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didChangeRow:inComponent:)]) {
        [self.delegate actionSheetPickerView:self didChangeRow:row inComponent:component];
    }
}

#pragma mark - show/Hide

-(void)dismiss
{
    [_actionSheetController dismissWithCompletion:nil];
}

-(void)dismissWithCompletion:(void (^)(void))completion
{
    [_actionSheetController dismissWithCompletion:completion];
}

-(void)show
{
    [self showWithCompletion:nil];
}

-(void)showWithCompletion:(void (^)(void))completion
{
    [_pickerView reloadAllComponents];
    
    _actionSheetController = [[WDActionSheetViewController alloc] init];
    [_actionSheetController showPickerView:self completion:completion];
}


@end