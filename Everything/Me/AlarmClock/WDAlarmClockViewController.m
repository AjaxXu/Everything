//
//  WDAlarmClockViewController.m
//  Everything
//
//  Created by Louis on 16/7/22.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmClockViewController.h"
#import "WDAlarmClockModel.h"
#import "WDAlarmClockCell.h"
#import "RACSignal.h"
#import "RACSequence.h"
#import "UIControl+RACSignalSupport.h"
#import "NSArray+RACSequenceAdditions.h"
#import "WDAlarmEditViewController.h"

static NSString *const kAlarmCellIdentifier = @"AlarmCell";

@interface WDAlarmClockViewController ()

@property (nonatomic, strong) NSMutableArray *alarmArray;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

@end

@implementation WDAlarmClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_backBarButtonItem) {
        _backBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"nav_back"
                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                  target:self
                                                                  action:@selector(doBack)];
        self.navigationItem.leftBarButtonItem = _backBarButtonItem;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSString *dir = WDSearchPathCaches
    NSString *filename = [dir stringByAppendingPathComponent:@"alarmclocks.plist"];
    
    NSMutableArray *clocks = [NSMutableArray new];
    for (WDAlarmClockModel *model in _alarmArray) {
        [clocks addObject:[model yy_modelToJSONObject]];
    }
    
    [clocks writeToFile: filename atomically:YES];
}

- (void)loadData
{
    _alarmArray = [NSMutableArray new];
    NSArray *array = nil;
    NSString *dir = WDSearchPathCaches
    NSString *filename = [dir stringByAppendingPathComponent:@"alarmclocks.plist"];
    array = [NSArray arrayWithContentsOfFile:filename];
    //    NSLog(@"%@", array);
    if (!array) {
        array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"alarm.plist" ofType:nil]];
    }
    for (NSDictionary *dic in array) {
        WDAlarmClockModel *cellModel = [WDAlarmClockModel yy_modelWithDictionary: dic];
        [_alarmArray addObject:cellModel];
    }
    
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
    WDAlarmClockModel *cellModel = [_alarmArray objectAtIndex:indexPath.row];
    cell.model = cellModel;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[cell.isAlarmSwitch rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        ZJSwitch *sw = (ZJSwitch*)x;
        [cell changeLayout: sw.isOn];
        cellModel.isAlarm = sw.isOn;
        [_alarmArray replaceObjectAtIndex:indexPath.row withObject:cellModel];
    }];
    return cell;
}

//设置滑动时显示多个按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [_alarmArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    //删除按钮颜色
    deleteAction.backgroundColor = [UIColor redColor];
    
    //编辑
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        WDAlarmEditViewController *detailVC = [[WDAlarmEditViewController alloc]init];
        detailVC.model = [_alarmArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }];
    
    //将设置好的按钮方到数组中返回
    return @[deleteAction,moreRowAction];
    
}


- (void)setupView
{
    self.title = @"我的闹钟";
    
    // right bar button
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame= CGRectMake(0, 0, 25, 44);
    [btn1 setImage: [UIImage imageNamed:@"me_add"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(addClock) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addClock = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    //    negativeSpacer.width = -10; 可以调整与右边界的距离
    negativeSpacer.width = 0;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: negativeSpacer, addClock, nil];
    
    // tableView
    self.tableView.backgroundColor = WDGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[WDAlarmClockCell class] forCellReuseIdentifier:kAlarmCellIdentifier];
}

- (void)addClock
{
    
}

- (void)doBack
{
    //    NSDictionary *userDict = [_userModel yy_modelToJSONObject];
    //    [WDUserDefaults setObject:userDict forKey:kUserModel];
    //    [WDUserDefaults synchronize];
    //    NSString *tableID = [WDUserDefaults objectForKey:kUserID];
    //    [WDNetOperation postRequestWithURL:[NSString stringWithFormat:@"/users/%@", tableID] parameters:userDict success:nil failure:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
