//
//  UIImageView+Extension.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

- (void)setHeaderWithURL:(NSURL *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserHeader"] circleImage];
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                   completed:^(UIImage *image,
                               NSError *error,
                               SDImageCacheType cacheType,
                               NSURL *imageURL) {
                       self.image = image ? [image circleImage] : placeholder;
                   }];
}

- (void)setHeaderWithURLString: (NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:[kBaseURL stringByAppendingString:urlString]];
    [self setHeaderWithURL:url];
}

@end
