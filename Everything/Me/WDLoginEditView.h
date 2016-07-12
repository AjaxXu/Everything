//
//  WDLoginEditView.h
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDLoginEditView : UIView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *inputView;

- (instancetype)initWithEdgeInsets: (UIEdgeInsets)edgeInsets button: (UIButton *)buton;

@end
