//
//  WDAlarmMusicViewController.m
//  Everything
//
//  Created by Louis on 16/7/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAlarmMusicViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WDAlarmMusicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *musicName;
@property (nonatomic, strong) NSIndexPath *selected;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation WDAlarmMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.block != nil)
    {
        self.block(_musicName[_selected.row]);
    }
}

- (void)setupView
{
    self.view.backgroundColor = WDGlobalBackgroundColor;
    self.title = @"铃声";
    _musicName = [NSArray arrayWithObjects:@"提醒", nil];
    
    
    _tableView = [UITableView new];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview: _tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView.sd_layout.topSpaceToView(self.view, 100).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(45 * _musicName.count);
}

#pragma mark - UITableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _musicName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.textLabel.text = _musicName[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_musicName[indexPath.row] isEqualToString:_music])
    {
        //点中
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        _selected = indexPath;
    }else{
        //没有点中
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_audioPlayer){
        [_audioPlayer stop];
    }
    NSError *error;
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.caf", _musicName[indexPath.row]] withExtension:nil];
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL: fileURL error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    [_audioPlayer play];
    // 旧的取消
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: _selected];
    cell.accessoryType = UITableViewCellAccessoryNone;
    // 选择新的
    cell = [self.tableView cellForRowAtIndexPath: indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _selected = indexPath;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)setMusic:(NSString *)music
{
    _music = music;
    [self.tableView reloadData];
}

- (void)returnBlock:(ReturnTextBlock)returnBlock {
    _block = returnBlock;
}

@end
