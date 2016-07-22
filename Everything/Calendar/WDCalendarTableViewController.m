//
//  WDCalendarTableViewController.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDCalendarTableViewController.h"
#import "FSCalendar.h"
#import "RACSignal.h"
#import "UIControl+RACSignalSupport.h"
#import "WDActionSheetPickerView.h"
#import "NSDate+Utilities.h"

@interface WDCalendarTableViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance, WDActionSheetPickerViewDelegate>
@property (weak , nonatomic, readwrite) FSCalendar *calendar;
//@property (strong, nonatomic) NSCalendar *lunarCalendar;
//@property (strong, nonatomic) NSArray<NSString *> *lunarChars;
@property (strong, nonatomic) NSMutableDictionary *fillDefaultColors;
@property (strong, nonatomic) NSMutableArray *datesWithEvents;

@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) WDActionSheetPickerView *calendarPickerView;

@end

@implementation WDCalendarTableViewController

- (NSMutableArray *)datesWithEvents
{
    if (_datesWithEvents==nil) {
        _datesWithEvents =[[NSMutableArray alloc]init];
    }
    
    return _datesWithEvents;
}

- (NSMutableDictionary *)fillDefaultColors
{
    if (_fillDefaultColors==nil) {
        
        _fillDefaultColors =[[NSMutableDictionary alloc]init];
    }
    return _fillDefaultColors;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.lunarCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    //    self.lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十"];
    //    
    //    //    2016.05.1~2016.06.23
    //    //        [self setTimeStamp:@"1462061008" endTimeStamp:@"1466647408"];
    //    
    //    //时间分段  标记月嫂档期
    //    NSArray *arr = @[
    //                     @{
    //                         @"start_time" : @"1464111733",  //2016.05.25
    //                         @"end_time" : @"1464511733"   //2016.05.29
    //                         },
    //                     @{
    //                         @"start_time" : @"1464811733",//2016.06.02
    //                         @"end_time" : @"1465111733"   //2016.06.05
    //                         },
    //                     @{
    //                         @"start_time" : @"1465511733",    //2016.06.10
    //                         @"end_time" : @"1466011733"     //2016.06.15
    //                         },
    //                     ];
    //    
    //    NSDictionary *dic = @{ @"schedule" : arr };
    //    
    //    for (NSDictionary *dict in dic[@"schedule"]) {
    //        //          NSLog(@"%@", dict);
    //        //处理时间戳  
    //        [self setTimeStamp:dict[@"start_time"]
    //              endTimeStamp:dict[@"end_time"]];
    //    }
    [self setupview];
}

#pragma mark - <FSCalendarDataSource>
//下标标点个数 最多3个
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    
    return [self.datesWithEvents containsObject:date] ? 1 : 0;
}


//日期颜色
- (UIColor*)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{
    
    NSString *dateString = [calendar stringFromDate:date format:@"yyyy/MM/dd"];
    
    NSString *key =[NSString stringWithFormat:@"%@",dateString];
    
    if ([_fillDefaultColors.allKeys containsObject:dateString]) {
        
        return _fillDefaultColors[key];
    }
    
    return nil;
}


- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([calendar isDateInToday:date]) {
        return @"今";
    }
    return nil;
}

#pragma mark- 时间戳转换成时间日期
- (void)setTimeStamp:(NSString *)startStamp endTimeStamp:(NSString *)endTimeStamp{
    
    NSInteger secondsPerDay = 24 * 60 * 60;
    NSInteger start =startStamp.integerValue;
    NSInteger end = endTimeStamp.integerValue;
    
    for (NSInteger i = start; i <= end; i += secondsPerDay) {
        NSDate *temp = [NSDate dateWithTimeIntervalSince1970:i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:temp];
        [ self.datesWithEvents addObject:currentDateStr];
    }
    
    //    NSLog(@"%ld",self.datesWithEvents.count);
    for (NSString *times in self.datesWithEvents) {
        [self.fillDefaultColors setObject:WDThemeColor forKey:times]; //设置背景色 键值
    }
    
}

#pragma mark- set up view

- (void)setupview
{
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, WDScreenWidth, 300)];
    self.calendar = calendar;
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    
    // 显示周日周一等
    _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    _calendar.headerHeight = 0.0;
    // color
    _calendar.appearance.titleDefaultColor= RGB(56, 63, 64);
    _calendar.appearance.weekdayTextColor = [UIColor lightGrayColor];
    _calendar.appearance.selectionColor = WDThemeColor;
    _calendar.appearance.todaySelectionColor = [UIColor blackColor];
    // font
    _calendar.appearance.adjustsFontSizeToFitContentSize = NO;
    _calendar.appearance.weekdayFont = [UIFont systemFontOfSize:10];
    _calendar.appearance.titleFont = [UIFont systemFontOfSize:17];
    // 边框
    _calendar.clipsToBounds = YES;
    // 多选
    _calendar.allowsMultipleSelection = YES;
    // 本地化
    _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    [self.view addSubview:_calendar];
    
    _titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [_titleBtn setTitle:[[NSDate new] stringWithFormat:@"yyyy年M月"] forState:UIControlStateNormal];
    [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:@"cal_down"] forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:@"cal_down"] forState:UIControlStateHighlighted];
    [_titleBtn setImagePosition:WD_ImagePositionRight spacing:5];
    
    
    self.navigationItem.titleView = _titleBtn;
    
    [[_titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [_titleBtn setImage:[UIImage imageNamed:@"cal_up"] forState:UIControlStateNormal];
        if (!_calendarPickerView) {
            _calendarPickerView = [[WDActionSheetPickerView alloc] initWithTitle:@"选择日期" delegate:self];
            [_calendarPickerView setActionSheetPickerStyle:WDActionSheetPickerStyleYearMonthPicker];
        }
        [_calendarPickerView show];
    }];
}

#pragma mark - WDActionSheetPickerViewDelegate

- (void)actionSheetPickerView:(WDActionSheetPickerView *)pickerView didSelectDate:(NSDate*)date
{
    [_titleBtn setImage:[UIImage imageNamed:@"cal_down"] forState:UIControlStateNormal];
    [_titleBtn setTitle:[date stringWithFormat:@"yyyy年M月"] forState:UIControlStateNormal];
    [_calendar setCurrentPage:date animated:NO];
}

- (void)actionSheetPickerViewWillCancel:(WDActionSheetPickerView *)pickerView
{
    [_titleBtn setImage:[UIImage imageNamed:@"cal_down"] forState:UIControlStateNormal];
}

@end
