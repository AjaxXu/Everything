//
//  WDAlarmClockCell.m
//  Everything
//
//  Created by Louis on 16/7/23.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmClockCell.h"
#import "Everything-Swift.h"
#import "WDAlarmClockModel.h"
#import "YYText.h"

@interface WDAlarmClockCell()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) YYLabel *titleRepeatLabel;
@property (nonatomic, strong) TKSimpleSwitch *isAlarmSwitch;

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
    _timeLabel.font = [UIFont systemFontOfSize:22];
    [self.contentView addSubview:_timeLabel];
    
    _titleRepeatLabel = [YYLabel new];
    _titleRepeatLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_timeLabel];
    
    _isAlarmSwitch = [TKSimpleSwitch new];
    [self.contentView addSubview:_isAlarmSwitch];
    
    _timeLabel.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .heightIs(60);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _titleRepeatLabel.sd_layout.leftEqualToView(_timeLabel).topSpaceToView(_timeLabel, 5).bottomSpaceToView(self.contentView, 5).heightIs(20).maxWidthIs(220);
    
    _isAlarmSwitch.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).heightIs(30).widthIs(50);
}

- (void)setModel:(WDAlarmClockModel *)model
{
    NSLog(@"1111");
    _model = model;
    if (_model.isAlarm) {
        self.tintColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.tintColor = [UIColor grayColor];
        self.backgroundColor = RGB(161, 160, 165);
    }
    _isAlarmSwitch.on = _model.isAlarm;
    NSLog(@"222");
    
    _timeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)_model.hour, (unsigned long)_model.minute];
    NSString *dayString = [self getAlarmClockRepeatDaysWithNumbers:_model.repeatDays];
    NSString *tagTitle = nil;
    if (dayString) {
        tagTitle = [NSString stringWithFormat:@"%@, %@", _model.title, dayString];
    } else {
        tagTitle = [NSString stringWithFormat:@"%@", _model.title];
    }
    NSLog(@"333");
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tagTitle];
    [text yy_setFont:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, _model.title.length + 1)];
    _titleRepeatLabel.attributedText = text;
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
    return 80;
}

@end
