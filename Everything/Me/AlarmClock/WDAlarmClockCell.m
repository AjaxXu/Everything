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
    NSString *dayString = [WDAlarmClockModel getAlarmClockRepeatDaysWithNumbers:_model.repeatDays];
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
