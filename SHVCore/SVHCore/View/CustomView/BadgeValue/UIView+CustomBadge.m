//
//  UIView+CustomBadge.m
//  SUBTest
//
//  Created by chinaPnr on 13-11-11.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import "UIView+CustomBadge.h"
#import <objc/runtime.h>
#import "GJTCommonTool.h"
#import "GJTUIViewAdditions.h"
static NSString *badgeViewKey;

@implementation UIView(CustomBadge)

- (GJTCustomBadgeView *)badgeView {
    GJTCustomBadgeView *badgeView = (GJTCustomBadgeView *)objc_getAssociatedObject(self, (__bridge const void *)(badgeViewKey));
    return (badgeView);
}

- (void)setBadge:(NSInteger)badge{
    [self setBadge:badge contentPosition:CGPointMake(0.7f, 0.15f)];
}

- (void)setBadge:(NSInteger)badge contentPosition:(CGPoint)position {
    if(badge > 0) {
//        NSString *badgeString = [NSString stringWithString:[@(MIN(badge, NOE_DEF_BADGE_NUMBER_MAX)) stringValue]];
        NSString *badgeString = [NSString stringWithString:[@(badge) stringValue]];
        GJTCustomBadgeView *badgeView = [self badgeView];
        if(!badgeView) {
            badgeView = [[GJTCustomBadgeView alloc] initWithFrame:CGRectMake(0, 0, NOE_DEF_BADGE_SIZE, 13)];
            objc_setAssociatedObject(self, (__bridge const void *)(badgeViewKey), badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self addSubview:badgeView];
        }
        badgeView.type = CustomBadgeTypeNumber;
        badgeView.badgeLabel.text = badgeString;
        CGSize stringSize = GJTTextSizeWithText(badgeString, badgeView.badgeLabel.font, CGSizeMake(200, badgeView.badgeLabel.font.lineHeight+2));
        CGSize hundredStringSize = GJTTextSizeWithText(@"1000", badgeView.badgeLabel.font, CGSizeMake(200, badgeView.badgeLabel.font.lineHeight+2));
        if (stringSize.width < hundredStringSize.width) {
            if (stringSize.width <= stringSize.height){
                badgeView.size = CGSizeMake(stringSize.height+4,stringSize.height+4);
            }else {
                badgeView.size = CGSizeMake(stringSize.width + 6, stringSize.height);
            }
        }else {
            badgeView.size = CGSizeMake(hundredStringSize.width + 6, hundredStringSize.height);
        }
        badgeView.hidden = NO;
        badgeView.center = CGPointMake(CGRectGetWidth(self.bounds) * position.x, CGRectGetHeight(self.bounds) * position.y);
    } else {
        GJTCustomBadgeView *badgeView = [self badgeView];
        if(badgeView) {
            badgeView.hidden = YES;
        }
    }
}

- (void)haveBadge:(BOOL)have contentPosition:(CGPoint)position {
    if(have) {
        GJTCustomBadgeView *badgeView = [self badgeView];
        if(!badgeView) {
            badgeView = [[GJTCustomBadgeView alloc] initWithFrame:CGRectMake(0, 0, NOE_DEF_BADGE_SIZE, NOE_DEF_BADGE_SIZE)];
            objc_setAssociatedObject(self, (__bridge const void *)(badgeViewKey), badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self addSubview:badgeView];
        }
        
        badgeView.type = CustomBadgeTypePoint;
        badgeView.badgeLabel.text = nil;
        badgeView.hidden = NO;
        badgeView.center = CGPointMake(CGRectGetWidth(self.bounds) * position.x, CGRectGetHeight(self.bounds) * position.y);
    } else {
        GJTCustomBadgeView *badgeView = [self badgeView];
        if(badgeView) {
            badgeView.hidden = YES;
        }
    }
}

@end
