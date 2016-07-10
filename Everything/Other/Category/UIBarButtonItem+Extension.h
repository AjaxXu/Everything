//
//  UIBarButtonItem+Extension.h
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIkit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonLeftItemWithImageName: (NSString *)imageName
                                        target: (id)target
                                        action: (SEL)action;
+ (instancetype)barButtonRightItemWithImageName: (NSString *)imageName
                                         target: (id)target
                                         action: (SEL)action;
+ (instancetype)barButtonItemWithImageName: (NSString *)imageName
                           imageEdgeInsets: (UIEdgeInsets)imageEdgeInsets
                                    target: (id)target
                                    action: (SEL)action;
+ (instancetype)barButtonItemWithTitle: (NSString*)title
                                target: (id)target
                                action: (SEL)action;
+ (instancetype)barButtonItemWithTitle: (NSString*)title
                         selectedTitle: (NSString*)title
                                target: (id)target
                                action: (SEL)action;

@end
