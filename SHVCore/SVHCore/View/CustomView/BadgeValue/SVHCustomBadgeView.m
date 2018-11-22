//
//  CustomBadge.m
//  SUBTest
//
//  Created by chinaPnr on 13-11-8.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import "SVHCustomBadgeView.h"

@interface SVHCustomBadgeView ()

@property (strong, nonatomic) NSMutableString *badgeString;
@property (strong, nonatomic) UIImageView *backgroundImgView;
@property (strong, nonatomic) UILabel *badgeLabel;

@end

@implementation SVHCustomBadgeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(_backgroundImgView) {
        _backgroundImgView.frame = self.bounds;
    }
    if(_badgeLabel) {
        _badgeLabel.frame = self.bounds;
        if(_badgeLabel.layer.cornerRadius == 0) {
            _badgeLabel.layer.cornerRadius = CGRectGetHeight(self.bounds) * 0.5f;
            _badgeLabel.clipsToBounds = YES;
        }
    }
    
    if(_type == CustomBadgeTypeNumber) {
        _badgeLabel.transform = CGAffineTransformMakeScale(1, 1);
        _badgeLabel.layer.borderWidth = 1.0f/[[UIScreen mainScreen] scale];
        _badgeLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    } else {
        _badgeLabel.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    }
}

- (void)setType:(CustomBadgeType)type {
    if(_type == type) {
        return;
    }
    _type = type;
    [self setNeedsLayout];
}

- (UIImageView *)backgroundImgView {
    if(!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc] init];
        _backgroundImgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundImgView];
        
        [self sendSubviewToBack:_backgroundImgView];
        
        [self setNeedsLayout];
    }
    return (_backgroundImgView);
}

- (UILabel *)badgeLabel {
    if(!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.font = [UIFont systemFontOfSize:11];
        _badgeLabel.clipsToBounds = YES;
        [self addSubview:_badgeLabel];
        
        [self bringSubviewToFront:_badgeLabel];
        
        [self setNeedsLayout];
    }
    return (_badgeLabel);
}

@end
