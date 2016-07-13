//
//  NSDictionary+Extension.h
//  Everything
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (void)setHeight: (CGFloat) height withIndexPath: (NSIndexPath*) indexPath;

- (CGFloat)getHeightWithIndexPath: (NSIndexPath*)indexPath;

@end
