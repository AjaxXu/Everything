//
//  WDAlarmClockViewController.m
//  Everything
//
//  Created by Louis on 16/7/22.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmClockViewController.h"
#import "Everything-Swift.h"
#import "WDAlarmClockModel.h"
#import "WDAlarmClockCell.h"

static NSString *const kAlarmCellIdentifier = @"AlarmCell";

@interface WDAlarmClockViewController ()

@property (nonatomic, strong) NSArray *alarmArray;

@end

@implementation WDAlarmClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)loadData
{
    _alarmArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"alarm.plist" ofType:nil]];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDeledate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WDAlarmClockCell fixedHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _alarmArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDAlarmClockCell *cell = [tableView dequeueReusableCellWithIdentifier: kAlarmCellIdentifier];
    WDAlarmClockModel *cellModel = [WDAlarmClockModel yy_modelWithDictionary: _alarmArray[indexPath.row]];
    
    cell.model = cellModel;
    return cell;
}

- (void)setupView
{
    self.tableView.backgroundColor = WDGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[WDAlarmClockCell class] forCellReuseIdentifier:kAlarmCellIdentifier];
}

@end
