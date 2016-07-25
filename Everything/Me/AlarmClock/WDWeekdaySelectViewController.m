//
//  WDWeekdaySelectViewController.m
//  Everything
//
//  Created by Louis on 16/7/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDWeekdaySelectViewController.h"

@interface WDWeekdaySelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *weekdayName;
@property (nonatomic, strong) NSMutableArray *checkArray;

@end

@implementation WDWeekdaySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.block != nil)
    {
        self.block(_checkArray);
    }
}

- (void)setupView
{
    self.view.backgroundColor = WDGlobalBackgroundColor;
    self.title = @"重复";
    _weekdayName = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"日", nil];
    _checkArray = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0, nil];
    if (_weekdays) {
        for (id day in _weekdays) {
            _checkArray[[day intValue] - 1] = @1;
        }
    }
    
    _tableView = [UITableView new];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview: _tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView.sd_layout.topSpaceToView(self.view, 100).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(315);
}

#pragma mark - UITableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"每周%@", [_weekdayName objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[_checkArray objectAtIndex:indexPath.row] intValue] == 1)
    {
        //点中
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        //没有点中
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath ];
    
    if (cell.accessoryType ==UITableViewCellAccessoryNone){
        
        _checkArray[indexPath.row] = @1;
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
    }
    else{
        _checkArray[indexPath.row] = @0;
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)setWeekdays:(NSMutableArray *)weekdays
{
    _weekdays = weekdays;
    for (id day in _weekdays) {
        _checkArray[[day intValue] - 1] = @1;
    }
    [_tableView reloadData];
}

- (void)returnBlock:(ResponseArray)block
{
    _block = block;
}

@end
