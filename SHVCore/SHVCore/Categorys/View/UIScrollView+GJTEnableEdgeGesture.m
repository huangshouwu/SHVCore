//
//  UIScrollView+NOEEEnableEdgeGesture.m
//  Lottery
//
//  Created by hsw on 15/12/31.
//  Copyright © 2015年 9188-MacPro1. All rights reserved.
//

#import "UIScrollView+GJTEnableEdgeGesture.h"

@implementation UIScrollView (GJTEnableEdgeGesture)

/* scrollView 允许右滑手势 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        [gestureRecognizer requireGestureRecognizerToFail:otherGestureRecognizer];/* 右滑时禁止scrollView的滚动 */
            return YES;
    }else{
            return  NO;
    }
}

@end
