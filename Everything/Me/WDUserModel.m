//
//  WDUserModel.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDUserModel.h"

@implementation WDUserModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_head_image forKey:@"head_image"];
    [aCoder encodeInteger:_gender forKey:@"gender"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.head_image = [aDecoder decodeObjectForKey:@"head_image"];
        self.gender = [aDecoder decodeIntegerForKey:@"gender"];
    }
    return self;
}

@end
