//
//  WDUserTableViewCell.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDUserTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "WDUserModel.h"

@implementation WDUserTableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 这行代是为了解决tableview开启了字母序列索引之后cell会向左缩进一段距离的问题
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        [self setupView];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.size.width = 375;
//    [super setFrame:frame];
//}

- (void)setupView
{
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_nameLabel];
    
    CGFloat margin = 20;
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView, margin)
    .widthIs(71)
    .heightEqualToWidth()
    .centerYEqualToView(self.contentView);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconImageView, 15)
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, margin)
    .heightIs(71);
}

- (void)setModel:(WDUserModel *)model
{
    _model = model;
    _nameLabel.text = [NSString stringWithFormat:@"%@", model.username];
    [_iconImageView setHeaderWithURLString: model.head_image];
}

+ (CGFloat)fixedHeight
{
    return 95;
}

@end
