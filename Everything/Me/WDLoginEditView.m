//
//  WDLoginEditView.m
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDLoginEditView.h"

@implementation WDLoginEditView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithEdgeInsets: (UIEdgeInsets)edgeInsets button: (UIButton *)button
{
    if (self = [super init])
    {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = RGB(109, 109, 109);
        
        _inputView = [UITextField new];
        _inputView.font = [UIFont systemFontOfSize:16];
        _inputView.textColor = RGB(109, 109, 109);
        [_inputView setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        UILabel *separateLine = [UILabel new];
        separateLine.backgroundColor = RGB(109, 109, 109);
        
        [self addSubview:_nameLabel];
        [self addSubview:_inputView];
        [self addSubview:separateLine];
        
        _nameLabel.sd_layout
        .leftSpaceToView(self, edgeInsets.left)
        .centerYEqualToView(self)
        .topEqualToView(self).minWidthIs(50)
        .bottomEqualToView(self);
        [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        _inputView.sd_layout
        .leftSpaceToView(_nameLabel, 10)
        .rightSpaceToView(self, 10)
        .topEqualToView(_nameLabel)
        .bottomEqualToView(_nameLabel)
        .centerYEqualToView(self);
        
        separateLine.sd_layout
        .leftEqualToView(_nameLabel)
        .rightSpaceToView(self, edgeInsets.right)
        .bottomEqualToView(self)
        .heightIs(0.5);
        
        if (button)
        {
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [self addSubview:button];
            button.sd_layout
            .rightSpaceToView(self, edgeInsets.right)
            .centerYEqualToView(self);
            [button setupAutoSizeWithHorizontalPadding:0 buttonHeight: 45];
            _inputView.sd_layout.rightSpaceToView(button, 5);
            
        }
    }
    return self;
}

@end
