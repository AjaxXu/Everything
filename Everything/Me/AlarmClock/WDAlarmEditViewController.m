//
//  WDAlarmEditViewController.m
//  Everything
//
//  Created by Louis on 16/7/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmEditViewController.h"
#import "NSDate+Utilities.h"
#import "WDAlarmClockModel.h"
#import "WDSingleTextFiledViewController.h"
#import "WDWeekdaySelectViewController.h"
#import "WDAlarmMusicViewController.h"

static const NSInteger bigRowCount = 1000;

@interface WDAlarmEditViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation WDAlarmEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    if (_model) {
        [self selectHour:_model.hour minute:_model.minute];
    } else {
        [self selectNow];
    }
}

- (void)setupView
{
    self.title = @"编辑闹钟";
    self.view.backgroundColor = WDGlobalBackgroundColor;
    
    _pickerView = [UIPickerView new];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    
    _pickerView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view, 64).heightIs(200);
    _tableView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_pickerView, 30).heightIs(180);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle: @"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClock)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 24 * bigRowCount;
        case 1:
            return 60 * bigRowCount;
        default:
            break;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *dateLabel = (UILabel *)view;
    if (!dateLabel) {
        dateLabel = [[UILabel alloc] init];
        [dateLabel setFont:[UIFont systemFontOfSize:22]];
    }
    switch (component) {
        case 0:{
            NSString *currentHour = [NSString stringWithFormat:@"%02ld",(long)(row % 24) ];
            [dateLabel setText:currentHour];
            dateLabel.textAlignment = NSTextAlignmentLeft;
            break;
        }
        case 1:{
            NSString *currentMin = [NSString stringWithFormat:@"%02ld",row % 60];
            [dateLabel setText:currentMin];
            dateLabel.textAlignment = NSTextAlignmentRight;
        }
        default:
            break;
    }
    return dateLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            _model.hour = row % 24;
            break;
        case 1:
            _model.minute = row % 60;
            break;
        default:
            break;
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

#pragma mark - tableview delegate, datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"identifier"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"重复";
        cell.detailTextLabel.text = [WDAlarmClockModel getAlarmClockRepeatDaysWithNumbers:_model.repeatDays inDetail:YES];
    }
    else if (indexPath.row == 1){
        cell.textLabel.text = @"标签";
        cell.detailTextLabel.text = _model.title;
    }
    else if (indexPath.row == 2){
        cell.textLabel.text = @"铃声";
        cell.detailTextLabel.text = _model.bgm;
    }
    else if (indexPath.row == 3){
        cell.textLabel.text = @"提示语";
        cell.detailTextLabel.text = _model.alertBody;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    if (indexPath.row == 0) {
        WDWeekdaySelectViewController *wsVC = [WDWeekdaySelectViewController new];
        wsVC.weekdays = _model.repeatDays;
        WeakSelf
        [wsVC returnBlock:^(NSMutableArray *array) {
            weakSelf.model.repeatDays = [NSMutableArray new];
            for (int i = 0; i < array.count; i++) {
                if ([array[i] intValue] == 1) {
                    [weakSelf.model.repeatDays addObject:@(i+1)];
                }
            }
            [weakSelf.tableView reloadData];
        }];
        vc = wsVC;
    }
    else if (indexPath.row == 1){
        WDSingleTextFiledViewController *stfVC = [WDSingleTextFiledViewController new];
        stfVC.text = _model.title;
        stfVC.title = @"标签";
        WeakSelf
        [stfVC returnText:^(NSString *text) {
            weakSelf.model.title = text;
            [weakSelf.tableView reloadData];
        }];
        vc = stfVC;
    }
    else if (indexPath.row == 2){
        WDAlarmMusicViewController *amVC = [WDAlarmMusicViewController new];
        amVC.music = _model.bgm;
        WeakSelf
        [amVC returnBlock:^(NSString *text) {
            weakSelf.model.bgm = text;
            [weakSelf.tableView reloadData];
        }];
        vc = amVC;
    }
    else if (indexPath.row == 3){
        WDSingleTextFiledViewController *stfVC = [WDSingleTextFiledViewController new];
        stfVC.text = _model.title;
        stfVC.title = @"提示语";
        WeakSelf
        [stfVC returnText:^(NSString *text) {
            weakSelf.model.alertBody = text;
            [weakSelf.tableView reloadData];
        }];
        vc = stfVC;
    }
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark -private method

- (void)setModel:(WDAlarmClockModel *)model
{
    _model = model;
    [self selectHour:_model.hour minute:_model.minute];
}

- (void)selectHour:(NSUInteger)hour minute: (NSUInteger) minute
{
    [_pickerView selectRow: minute + (60 * bigRowCount /2) inComponent: 1 animated: NO];
    [_pickerView selectRow: hour + (24 *bigRowCount /2 ) inComponent: 0 animated: NO];
}

-(void)selectNow
{
    NSDate *date = [NSDate new];
    [self selectHour:date.hour minute:date.minute];
}

- (void)saveClock
{
    NSDictionary *alarmDict = [_model yy_modelToJSONObject];
    NSString *userID = WDUserDefaultObjectForKey(kUserID);
    [alarmDict setValue:userID forKey:@"userID"];
    NSString *urlString = nil;
    if (self.isNew || !_model._id) {
        urlString = @"/alarm_clock/new";
    } else {
        urlString = [NSString stringWithFormat:@"/alarm_clock/%@/update", _model._id];
    }
    [SVProgressHUD showWithStatus:@"保存闹钟"];
    [WDNetOperation postRequestWithURL:urlString parameters:alarmDict success:^(id responseObject){
        _model._id = responseObject[@"content"][@"_id"];
        if (self.block != nil)
        {
            self.block(_model);
        }
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error){
        [SVProgressHUD showErrorWithStatus:@"保存闹钟失败" duration:1];
    }];
}

- (void)returnBlock: (ReturnAlarmModel)returnBlock
{
    _block = returnBlock;
}

@end
