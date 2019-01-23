//
//  GJTBottomTitleButton.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "GJTBottomTitleButton.h"
CGFloat static contentView_bottomLabel_space = 10;
CGFloat static bottomDot_bottomLabel_space = 5;

@interface GJTBottomTitleButton(){
    CGSize _contentViewSize;
}
@end

@implementation GJTBottomTitleButton

- (CGFloat)viewHeight{
    return _contentViewSize.height + [self bottomLabelSize].height + contentView_bottomLabel_space;
}

- (CGSize)bottomLabelSize{
    return SVHTextSizeWithText(_bottomLabel.leftLabel.text, _bottomLabel.leftLabel.font, CGSizeMake([self bottomLabelWidth], 1000));
}

- (CGFloat)bottomLabelWidth{
    CGFloat width = CGRectGetWidth(self.bounds);
    if (self.showBottomLeftDot) {
        width -= CGRectGetMaxX(_bottomLeftDot.frame) + bottomDot_bottomLabel_space;
    }
    return width;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _centerImageView.backgroundColor = [UIColor clearColor];
        
        _centerLabel = [SVHViewFactory createLabelWithFrame:CGRectZero font:[UIFont systemFontOfSize:12.0f] color:[UIColor lightGrayColor]];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        
        _contentView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        
        _bottomLabel = [[GJTMutableLabel alloc] initWithFrame:CGRectZero];
        _bottomLabel.leftLabel.font = [UIFont systemFontOfSize:12.0f];
        _bottomLabel.rightLabel.font = [UIFont systemFontOfSize:12.0f];
        _bottomLabel.leftLabel.textColor = [UIColor darkGrayColor];
        _bottomLabel.rightLabel.textColor = [UIColor darkGrayColor];
        _bottomLabel.contentAlignment = NSTextAlignmentCenter;
        _bottomLabel.leftLabel.numberOfLines = 0;
        _bottomLabel.leftLabel.textAlignment = NSTextAlignmentCenter;
        
        _bottomLeftDot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        _bottomLeftDot.hidden = YES;
        _showBottomLeftDot = NO;
        
        self.bottomLabelSpaceToContentView = contentView_bottomLabel_space;
        
        [_contentView addSubview:_centerImageView];
        [_contentView addSubview:_centerLabel];
        [self addSubview:_contentView];
        [self addSubview:_bottomLabel];
        [self addSubview:_bottomLeftDot];
    }
    return self;
}

- (void)setShowBottomLeftDot:(BOOL)showBottomLeftDot{
    _showBottomLeftDot = showBottomLeftDot;
    _bottomLeftDot.hidden = !showBottomLeftDot;
    [self setNeedsLayout];
}

- (void)setContentViewSize:(CGSize)size{
    _contentViewSize = size;
    _contentView.frame = CGRectMake(0, self.contentView_topInset, size.width,size.height);
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _contentView.centerX = CGRectGetWidth(self.bounds)/2;
    _contentView.top = self.contentView_topInset;
    _centerImageView.hidden = !_centerImageView.image;
    _centerLabel.hidden = !_centerLabel.text.length;
    if (!_centerImageView.hidden) {
        _centerImageView.frame = CGRectMake(0, 0, _centerImageView.image.size.width, _centerImageView.image.size.height);
        if (!_centerLabel.hidden) {
            CGFloat centerLabelHeight = _centerLabel.font.lineHeight;
            CGFloat image_label_space = 5.0f;
            _centerImageView.top = (CGRectGetHeight(_contentView.frame) - CGRectGetWidth(_centerImageView.frame) - centerLabelHeight - image_label_space)/2;
            _centerImageView.centerX = CGRectGetWidth(_contentView.frame)/2;
            _centerLabel.frame = CGRectMake(0, CGRectGetMaxY(_centerImageView.frame) + image_label_space, CGRectGetWidth(_contentView.frame), _centerLabel.font.lineHeight);
        }else {
            _centerImageView.center = CGPointMake(CGRectGetWidth(_contentView.frame)/2,CGRectGetHeight(_contentView.frame)/2);
        }
    }else {
        if (!_centerLabel.hidden) {
            _centerLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_contentView.frame), _centerLabel.font.lineHeight);
            _centerLabel.center = CGPointMake(CGRectGetWidth(_contentView.frame)/2,CGRectGetHeight(_contentView.frame)/2);
        }
    }
    
    CGSize bottomLabelSize = [self bottomLabelSize];
    _bottomLabel.frame = CGRectMake(CGRectGetMaxX(_bottomLeftDot.frame) + bottomDot_bottomLabel_space, CGRectGetMaxY(_contentView.frame) + self.bottomLabelSpaceToContentView, bottomLabelSize.width, bottomLabelSize.height);
    [_bottomLabel sizeToFit];
    _bottomLabel.centerX = _contentView.centerX;
    if (!_bottomLeftDot.hidden) {
        _bottomLeftDot.left = (CGRectGetWidth(self.bounds) - CGRectGetWidth(_bottomLabel.frame) - CGRectGetWidth(_bottomLeftDot.frame) - bottomDot_bottomLabel_space)/2;
        _bottomLeftDot.centerY = _bottomLabel.centerY;
        _bottomLabel.left = CGRectGetMaxX(_bottomLeftDot.frame) + bottomDot_bottomLabel_space;
    }
}

@end
