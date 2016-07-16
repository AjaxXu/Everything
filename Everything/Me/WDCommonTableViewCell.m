//
//  WDCommonTableViewCell.m
//  Everything
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDCommonTableViewCell.h"
#import "WDCellModel.h"

@interface WDCommonTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, assign) NSInteger height;

@end

@implementation WDCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 这行代是为了解决tableview开启了字母序列索引之后cell会向左缩进一段距离的问题
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_titleLabel];
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _height = 50;
}

- (void)setModel:(WDCellModel *)model
{
    _model = model;
    _titleLabel.text = _model.title;
    CGFloat margin = 20;
    
    if (_model.iconImageName)
    {
        if (_iconImageView)
        {
            _iconImageView.image = [UIImage imageNamed:_model.iconImageName];
            _iconImageView.sd_layout.widthIs(model.iconImageHeight);
        }
        else
        {
            _iconImageView = [UIImageView new];
            _iconImageView.image = [UIImage imageNamed:_model.iconImageName];
            [self.contentView addSubview:_iconImageView];
            
            _iconImageView.sd_layout
            .leftSpaceToView(self.contentView, margin)
            .widthIs(_model.iconImageHeight)
            .heightEqualToWidth()
            .centerYEqualToView(self.contentView);
            
            _titleLabel.sd_layout.leftSpaceToView(_iconImageView, 15);
        }
    }
    
    if (_model.indicatorType != WDTableViewCellIndicatorTypeNone)
    {
        if (_indicatorView)
        {
            
        }
        else
        {
            _indicatorView = [UIImageView new];
            _indicatorView.image = [UIImage imageNamed:@"indicator"];
            [self.contentView addSubview:_indicatorView];
            
            _indicatorView.sd_layout
            .rightSpaceToView(self.contentView, 10)
            .widthIs(30)
            .heightEqualToWidth()
            .centerYEqualToView(self.contentView);
        }
    }
    
    if (_model.rightImageName)
    {
        if (!_rightImageView) {
            _rightImageView = [UIImageView new];
            [self.contentView addSubview:_rightImageView];
        }
        
        if ([UIImage imageNamed:_model.rightImageName])
        {
            _rightImageView.image = [UIImage imageNamed:_model.rightImageName];
        }
        else
        {
            [_rightImageView setHeaderWithURLString: _model.rightImageName];
        }
        
        
        _rightImageView.sd_layout
        .rightSpaceToView(_indicatorView? _indicatorView : self.contentView, _indicatorView? 0 : 10)
        .widthIs(_model.rightImageHeight)
        .heightEqualToWidth()
        .centerYEqualToView(self.contentView);
        
        if (_model.rightImageHeight + 20 > _height) {
            _height = _model.rightImageHeight + 20;
        }
    }
    
    if (_model.desc)
    {
        if (_descLabel) {
            _descLabel.text = _model.desc;
        }else{
            _descLabel = [UILabel new];
            _descLabel.text = _model.desc;
            _descLabel.textColor = [UIColor grayColor];
            _descLabel.textAlignment = NSTextAlignmentRight;
            _descLabel.font = [UIFont systemFontOfSize:17];
            [self.contentView addSubview:_descLabel];
            
            _descLabel.sd_layout
            .rightSpaceToView(_indicatorView? _indicatorView : self.contentView, _indicatorView? 0 : 20)
            .leftSpaceToView(_titleLabel, 0)
            .heightIs(20)
            .centerYEqualToView(self.contentView);
            [_descLabel setSingleLineAutoResizeWithMaxWidth:200];
        }
    }
    
}

- (CGFloat)fixedHeight
{
    return _height;
}

@end
