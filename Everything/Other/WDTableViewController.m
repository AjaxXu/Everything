//
//  WDTableViewController.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDTableViewController.h"

@implementation WDTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
