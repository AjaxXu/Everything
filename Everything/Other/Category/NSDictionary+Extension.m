//
//  NSDictionary+Extension.m
//  Everything
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)


- (void)setHeight: (CGFloat) height withIndexPath: (NSIndexPath*) indexPath
{
    NSString *heightStr = [NSString stringWithFormat:@"%f", height];
    [self setValue:heightStr forKey:[NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row]];
}

- (CGFloat)getHeightWithIndexPath: (NSIndexPath*)indexPath
{
    CGFloat height = [[self objectForKey:[NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row]] floatValue];
    return height;
}
@end
