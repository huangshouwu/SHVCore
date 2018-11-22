//
//  UIView+CustomBadge.h
//  SUBTest
//
//  Created by chinaPnr on 13-11-11.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVHCustomBadgeView.h"

@interface UIView(CustomBadge)

- (SVHCustomBadgeView *)badgeView;
- (void)setBadge:(NSInteger)badge;
- (void)setBadge:(NSInteger)badge contentPosition:(CGPoint)position;
- (void)haveBadge:(BOOL)have contentPosition:(CGPoint)position;

@end
