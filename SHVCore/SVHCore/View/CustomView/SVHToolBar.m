//
//  SVHToolBar.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHToolBar.h"
#import "SVHViewFactory.h"
#import "SVHUIViewAdditions.h"

@implementation SVHToolBar

+ (CGFloat)viewHeight{
    return 40.0f;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _button1 = [SVHBaseButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"取消" forState:UIControlStateNormal];
        [_button1 setBackgroundColor:UIColor.clearColor];
        [_button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        _button2 = [SVHBaseButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"确定" forState:UIControlStateNormal];
        [_button2 setBackgroundColor:UIColor.clearColor];
        [_button2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _button2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        _titleLabel = [SVHViewFactory createLabelWithFrame:CGRectZero font:[UIFont systemFontOfSize:15.0f] color:UIColor.darkGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:_button1];
        [self addSubview:_button2];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat left_right_space = 10.0f;
    CGFloat buttonWidth = 60;
    _button1.frame = CGRectMake(left_right_space, 5, buttonWidth, buttonWidth);
    _titleLabel.frame = CGRectMake(_button1.right + left_right_space, 5, self.width - 2*buttonWidth - left_right_space*4, _titleLabel.font.lineHeight);
    _button2.frame = CGRectMake(_titleLabel.right + left_right_space, 5, _button1.width, buttonWidth);
    _button1.centerY = _button2.centerY = _titleLabel.centerY = self.height/2;
    if (_button1.hidden && _button1.hidden) {
        _titleLabel.width = self.width - left_right_space*2;
        _titleLabel.left = left_right_space;
    }
}

@end
