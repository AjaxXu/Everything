//
//  WDAlarmClockCell.m
//  Everything
//
//  Created by Louis on 16/7/23.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmClockCell.h"
#import "WDAlarmClockModel.h"
#import "YYText.h"

@interface WDAlarmClockCell()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) YYLabel *titleRepeatLabel;

@end

@implementation WDAlarmClockCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 这行代是为了解决tableview开启了字母序列索引之后cell会向左缩进一段距离的问题
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:40];
    [self.contentView addSubview:_timeLabel];
    
    _titleRepeatLabel = [YYLabel new];
    _titleRepeatLabel.frame = CGRectMake(20, 60, 220, 20);
    [self.contentView addSubview:_titleRepeatLabel];
    
    _isAlarmSwitch = [ZJSwitch new];
    _isAlarmSwitch.onText = @"ON";
    _isAlarmSwitch.offText = @"OFF";
    _isAlarmSwitch.textFont = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_isAlarmSwitch];
    
    _timeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .bottomSpaceToView(_titleRepeatLabel, 5)
    .heightIs(50);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _isAlarmSwitch.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).heightIs(50).widthIs(70);
    
}

- (void)setModel:(WDAlarmClockModel *)model
{
    _model = model;
    
    _isAlarmSwitch.on = _model.isAlarm;
    
    _timeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)_model.hour, (unsigned long)_model.minute];
    NSString *dayString = [self getAlarmClockRepeatDaysWithNumbers:_model.repeatDays];
    NSString *tagTitle = nil;
    NSRange range;
    if (dayString) {
        tagTitle = [NSString stringWithFormat:@"%@,  %@", _model.title, dayString];
        range = NSMakeRange(0, _model.title.length + 1);
    } else {
        tagTitle = [NSString stringWithFormat:@"%@", _model.title];
        range = NSMakeRange(0, _model.title.length);
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tagTitle];
    text.yy_font = [UIFont systemFontOfSize:15];
    [text yy_setFont:[UIFont boldSystemFontOfSize:15] range: range];
    _titleRepeatLabel.attributedText = text;
    
    [self changeLayout:_model.isAlarm];
}

- (NSString*)getAlarmClockRepeatDaysWithNumbers:(NSArray *)days
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

+ (CGFloat)fixedHeight
{
    return 90;
}

- (void)changeLayout:(BOOL)isAlarm
{
    if (isAlarm) {
        _timeLabel.textColor = RGB(109, 109, 109);
        _titleRepeatLabel.textColor = RGB(109, 109, 109);
        self.backgroundColor = [UIColor whiteColor];
    } else {
        _timeLabel.textColor = RGB(191, 191, 191);
        _titleRepeatLabel.textColor = RGB(191, 191, 191);
        self.backgroundColor = WDGlobalBackgroundColor;
    }
}

@end
