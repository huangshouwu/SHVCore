//
//  UIView+SVHLoadingGap.m
//  Lottery
//
//  Created by hsw on 15/12/16.
//  Copyright © 2015年 9188-MacPro1. All rights reserved.
//

#import "UIView+SVHLoadingGap.h"
#import <objc/runtime.h>
static NSString const *SVHLoadingGapViewKey = @"SVHLoadingGapViewKey";

@implementation UIView (SVHLoadingGap)

- (SVHLoadingGapView *)gapView {
    SVHLoadingGapView *_gapView = (SVHLoadingGapView *)objc_getAssociatedObject(self, (__bridge const void *)(SVHLoadingGapViewKey));
    return (_gapView);
}

- (SVHLoadingGapView*)createGapView{
    SVHLoadingGapView* _gapView = [[SVHLoadingGapView alloc] initWithFrame:self.bounds];
    _gapView.backgroundColor = [UIColor whiteColor];
    _gapView.contentViewCenterY = CGRectGetHeight(self.bounds)/2 - 50;
    return _gapView;
}


  // 外部调用 view默认和自身一样大
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style
                       block:(SVHLoadingGapViewReloadBlock)block{
    SVHLoadingGapView* gapView = [self gapView];
    if (!gapView) {
        gapView = [self createGapView];
        objc_setAssociatedObject(self, (__bridge const void *)(SVHLoadingGapViewKey), gapView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:gapView];
    }
    [self bringSubviewToFront:gapView];
    gapView.reloadBlock = block;
    [gapView setFrame:self.bounds];
    gapView.style = style;
    [self enableScroll:NO];
}
  // 外部调用 view frame 自定义
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style
                       block:(SVHLoadingGapViewReloadBlock)block
                       frame:(CGRect)frame{
    [self showGapViewWithStyle:style block:block];
    SVHLoadingGapView* gapView = [self gapView];
    gapView.frame = frame;
}

// 外部调用 view frame 自定义 文字自定义
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style
                       block:(SVHLoadingGapViewReloadBlock)block
                       frame:(CGRect)frame
                     gapText:(NSString*)gapText{
    [self showGapViewWithStyle:style block:block];
    SVHLoadingGapView* gapView = [self gapView];
    gapView.frame = frame;
    gapView.contentView.textLabel.text = gapText;
}

// 外部调用 view默认和自身一样大 文字自定义
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style block:(SVHLoadingGapViewReloadBlock)block  gapText:(NSString*)gapText{
    [self showGapViewWithStyle:style block:block];
    SVHLoadingGapView* gapView = [self gapView];
    gapView.contentView.textLabel.text = gapText;
}

/** 显示加载中样式  可指定加载控件的颜色和显示位置 */
- (void)showGapViewWithLoadingStyle:(UIColor*)loadingColor
                            atPoint:(CGPoint)loadingOrigin{
    [self showGapViewWithStyle:SVHLoadingGapViewStyleLoading block:nil];
    SVHLoadingGapView* gapView = [self gapView];
    if (loadingColor) {
        gapView.loadingView.color = loadingColor;
    }
    
    if (!CGPointEqualToPoint(loadingOrigin, CGPointZero)) {
        gapView.loadingView.frame = CGRectMake(loadingOrigin.x, loadingOrigin.y, 30, 30);
        gapView.loadingView.center = loadingOrigin;
    }
}

- (void)hideGapView{
    SVHLoadingGapView* gapView = [self gapView];
    if (gapView) {
        [gapView.loadingView stopAnimating];
        [gapView removeFromSuperview];
        objc_setAssociatedObject(self, (__bridge const void *)(SVHLoadingGapViewKey), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self enableScroll:YES];
    }
}

- (BOOL)gapViewIsVisibal{
    SVHLoadingGapView* gapView = [self gapView];
    if (gapView && ([gapView superview] != nil)) {
        return YES;
    }else {
        return NO;
    }
}

- (void)enableScroll:(BOOL)enable{
    if ([self isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView*)self setScrollEnabled:enable];
    }
}

//- (void)resetGapViewFrame{
//    if ([self isKindOfClass:[UIScrollView class]]) {
//        UIScrollView* gap = (UIScrollView*)self;
//        if (gap.contentOffset.y != 0) {
//            CGRect oldFrame = [[self gapView] frame];
//            CGRect newFrame = CGRectMake(0, CGRectGetMinY(oldFrame) + gap.contentOffset.y, CGRectGetWidth(oldFrame), CGRectGetHeight(oldFrame));
//            gap.frame = newFrame;
//        }
//    }
//}

@end
