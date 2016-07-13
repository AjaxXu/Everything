//
//  WDEditNickNameViewController.h
//  Everything
//
//  Created by Louis on 16/7/14.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WDEditNickNameViewController : UIViewController

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@end
