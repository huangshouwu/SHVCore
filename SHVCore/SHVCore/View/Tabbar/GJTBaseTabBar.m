//
//  NOEEBaseTabBar.m
//  Lottery
//
//  Created by caiyi on 2017/11/24.
//  Copyright © 2017年 9188.com. All rights reserved.
//

#import "GJTBaseTabBar.h"

@implementation GJTBaseTabBar{
    UIEdgeInsets _oldSafeAreaInsets;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _oldSafeAreaInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _oldSafeAreaInsets = UIEdgeInsetsZero;
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(_oldSafeAreaInsets, self.safeAreaInsets)) {
        [self invalidateIntrinsicContentSize];
        
        if (self.superview) {
            [self.superview setNeedsLayout];
            [self.superview layoutSubviews];
        }
    }
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    
    if ([self respondsToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            float bottomInset = [self safeAreaInsets].bottom;
            BOOL isPhoneX  = ([[UIScreen mainScreen] bounds].size.height >= 812.0f && [[UIScreen mainScreen] bounds].size.width >= 375.0f && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone));
            if (bottomInset <= 0 && isPhoneX) {
                bottomInset = 34;
            }
            if (bottomInset > 0 && size.height < 50 && (size.height + bottomInset < 90)) {
                size.height += bottomInset;
            }
        }
    }
    return size;
}

- (void)setFrame:(CGRect)frame {
    if (self.superview) {
        if (frame.origin.y + frame.size.height != self.superview.frame.size.height) {
            frame.origin.y = self.superview.frame.size.height - frame.size.height;
        }
    }
    [super setFrame:frame];
}

@end
