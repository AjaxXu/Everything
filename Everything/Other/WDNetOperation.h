//
//  WDNetOperation.h
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDNetOperation : NSObject

typedef void (^success)(id responseObject);
typedef void (^failure)(NSError *error);

+ (void)getRequestWithURL:(NSString *)URLString parameters:(id)parameters success:(success)success failure:(failure)failure;

@end
