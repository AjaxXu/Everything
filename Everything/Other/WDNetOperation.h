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
typedef void (^progress)(NSProgress *uploadProgress);

+ (void)getRequestWithURL:(NSString *)URLString parameters:(id)parameters success:(success)success failure:(failure)failure;
+ (void)postRequestWithURL:(NSString *)URLString parameters:(id)parameters success:(success)success failure:(failure)failure;

+ (void)postDataWithURL:(NSString *)URLString parameters:(id)parameters fileData: fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(progress)progress success:(success)success failure:(failure)failure;
+ (void)postImageWithURL:(NSString *)URLString parameters:(id)parameters image: (UIImage*)image name:(NSString *)name fileName:(NSString *)fileName progress:(progress)progress success:(success)success failure:(failure)failure;

@end
