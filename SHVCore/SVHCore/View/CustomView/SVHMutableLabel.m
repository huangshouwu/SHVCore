//
//  GJTMutableLabel.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHMutableLabel.h"

@interface SVHMutableLabel (){
    CGSize _leftLabelSize;
    CGSize _rightLabelSize;
    CGSize _leftImageViewSize;
}
@end

@implementation SVHMutableLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _leftLabel = [SVHViewFactory createLabelWithFrame:CGRectZero];
        _rightLabel = [SVHViewFactory createLabelWithFrame:CGRectZero];
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImageView.backgroundColor = [UIColor clearColor];
        _contentAlignment = NSTextAlignmentLeft;
        _leftImageView_leftLabel_space = 10;
        _leftLabel_rightLabel_space = 10;
        [self addSubview:_leftLabel];
        [self addSubview:_rightLabel];
        [self addSubview:_leftImageView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)setShowLeftImageView:(BOOL)showLeftImageView{
    _showLeftImageView = showLeftImageView;
    _leftImageView.hidden = !showLeftImageView;
    [self setNeedsLayout];
}

- (void)setLeftLabelSize:(CGSize)leftLabelSize{
    _leftLabelSize = leftLabelSize;
    _leftLabel.size = leftLabelSize;
    [self setNeedsLayout];
}

- (void)setRightLabelSize:(CGSize)rightLabelSize{
    _rightLabelSize = rightLabelSize;
    _rightLabel.size = rightLabelSize;
    [self setNeedsLayout];
}

- (void)setLeftImageViewSize:(CGSize)leftImageViewSize{
    _leftImageViewSize = leftImageViewSize;
    _leftImageView.size = leftImageViewSize;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    CGFloat leftLabelWidth = _leftLabelSize.width;
//    if (leftLabelWidth == 0) {
//        _leftLabel.width = CGRectGetWidth(self.bounds);
//        [_leftLabel sizeToFit];
//        leftLabelWidth = CGRectGetWidth(_leftLabel.frame);
//    }
    
    _leftLabel.height = _leftLabel.font.lineHeight;
    _rightLabel.height = _rightLabel.font.lineHeight;
    
    if (self.contentAlignment == NSTextAlignmentLeft) {
        CGFloat leftLabel_left = self.contentEdgeInsets.left;
        if (self.showLeftImageView) {
            _leftImageView.left = leftLabel_left;
            leftLabel_left = _leftImageView.right + _leftImageView_leftLabel_space;
        }
        _leftLabel.left = leftLabel_left;
        if (_leftLabelSize.width == 0) {/** 如果外部未指定宽度 */
            _leftLabel.width = self.width - leftLabel_left;
            [_leftLabel sizeToFit];
            if (_leftLabel.right >= self.width) {
                _leftLabel.width = self.width - _leftLabel.left;
            }
        }
        
//        if (_leftLabel.text.length) {
            _rightLabel.left = _leftLabel.right + _leftLabel_rightLabel_space;
//        }else {
//            _rightLabel.left = _leftLabel.left;
//        }
        
        if (_rightLabelSize.width == 0) {
            _rightLabel.width = self.width - _rightLabel.left - self.contentEdgeInsets.right;
        }else {
            _rightLabel.size = _rightLabelSize;
        }
    }else if (self.contentAlignment == NSTextAlignmentCenter || self.contentAlignment == NSTextAlignmentRight){
        CGFloat leftLabel_left = 0;
        if (self.showLeftImageView) {
            leftLabel_left = _leftImageViewSize.width + _leftImageView_leftLabel_space;
        }
        if (!_leftLabelSize.width) {
            _leftLabel.width = self.width - leftLabel_left;
            [_leftLabel sizeToFit];
        }
        if (!_rightLabelSize.width) {
            _rightLabel.size = CGSizeMake(self.width - _leftLabel.right, _rightLabel.font.lineHeight);
            [_rightLabel sizeToFit];
        }
        
        CGFloat contentWidth = _leftLabel.width + _rightLabel.width;
        if (_rightLabel.text.length) {
            contentWidth += _leftLabel_rightLabel_space;
        }
        if (self.showLeftImageView) {
            contentWidth += _leftImageViewSize.width + _leftImageView_leftLabel_space;
            if (self.contentAlignment == NSTextAlignmentRight) {
                _leftImageView.left = self.width - contentWidth;
            }else {
                _leftImageView.left = (self.width - contentWidth)/2;
            }
            _leftLabel.left = _leftImageView.right + _leftImageView_leftLabel_space;
        }else {
            if (self.contentAlignment == NSTextAlignmentRight) {
                _leftLabel.left = self.width - contentWidth - self.contentEdgeInsets.right;
            }else {
                _leftLabel.left = (self.width - contentWidth)/2;
            }
        }
        if (_leftLabel.text) {
            _rightLabel.left = _leftLabel.right + _leftLabel_rightLabel_space;
        }else {
            _rightLabel.left = _leftLabel.left;
        }
    }
    
//    _leftLabel.frame = CGRectMake(self.contentEdgeInsets.left, self.contentEdgeInsets.top, leftLabelWidth, _leftLabel.font.lineHeight);
//    _rightLabel.frame = CGRectMake(CGRectGetMaxX(_leftLabel.frame) + 10, CGRectGetMinY(_leftLabel.frame), CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - CGRectGetMaxX(_leftLabel.frame), _rightLabel.font.lineHeight);
    _leftLabel.top = _rightLabel.top = self.contentEdgeInsets.top;//self.height/2;
    _leftImageView.centerY = _leftLabel.centerY;
    if (_leftLabel.text.length == 0) {
        _leftImageView.centerY = self.height/2;
    }
    
    if (self.showLeftImageView && self.leftImageViewShowCircleStyle) {
        self.leftImageView.layer.cornerRadius = _leftImageViewSize.width/2;
        self.leftImageView.layer.masksToBounds = YES;
    }
}

@end
