//
//  GJTBottomSaveView.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/4.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "GJTBottomSaveView.h"

@implementation GJTBottomSaveView

+ (CGFloat)viewHeight{
    return 55.0f + GJTBottomSafeMargin;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _button1 = [GJTBaseButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"保存修改" forState:UIControlStateNormal];
        [_button1 setBackgroundColor:GJTColorForHex(@"#FF7460")];
        _button1.layer.cornerRadius = 5.0f;
        _button1.layer.masksToBounds = YES;
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        _button2 = [GJTBaseButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"保存修改" forState:UIControlStateNormal];
        [_button2 setBackgroundColor:GJTColorForHex(@"#FF7460")];
        _button2.layer.cornerRadius = 5.0f;
        _button2.layer.masksToBounds = YES;
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:_button1];
        [self addSubview:_button2];
        self.borderLineStyle = GJTBorder_Line_Top;
        self.borderColor = UIColor.lightGrayColor;
        self.borderWidth = 1.0f/GJTScreenScale();
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat left_right_space = 10.0f;
    _button1.frame = CGRectMake(left_right_space, 5, self.width - left_right_space*2, 40);
    if (self.showTwoButton) {
        _button1.frame = CGRectMake(left_right_space, 5, (self.width - left_right_space*3)/2, 40);
        _button2.frame = CGRectMake(_button1.right + left_right_space, 5, _button1.width, 40);
    }else {
        _button2.frame = CGRectZero;
    }
    _button1.centerY = _button2.centerY = (self.height - GJTBottomSafeMargin)/2;
}

@end
