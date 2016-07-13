//
//  WDCellModel.h
//  Everything
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WDTableViewCellIndicatiorType) {
    WDTableViewCellIndicatorTypeNone = 0,
    WDTableViewCellIndicatorTypeRightArrow
};

@interface WDCellModel : NSObject

@property (nonatomic, strong) NSString *iconImageName;
@property (nonatomic, assign) NSInteger iconImageHeight;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *rightImageName;
@property (nonatomic, assign) NSInteger rightImageHeight;
@property (nonatomic, assign) WDTableViewCellIndicatiorType indicatorType;
@property (nonatomic, assign) BOOL canSelect;
@property (nonatomic, strong) NSString *class;

@end
