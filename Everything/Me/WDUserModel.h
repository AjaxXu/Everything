//
//  WDUserModel.h
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDUserModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) NSUInteger gender;
@property (nonatomic, strong) NSString *head_image;

@end
