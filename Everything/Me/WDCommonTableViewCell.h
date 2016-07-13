//
//  WDCommonTableViewCell.h
//  Everything
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDCellModel;

@interface WDCommonTableViewCell : UITableViewCell

@property (nonatomic, strong) WDCellModel *model;

- (CGFloat)fixedHeight;

@end
