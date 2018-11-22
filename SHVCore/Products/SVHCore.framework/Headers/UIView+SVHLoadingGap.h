//
//  UIView+SVHLoadingGap.h
//  Lottery
//
//  Created by hsw on 15/12/16.
//  Copyright © 2015年 9188-MacPro1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVHLoadingGapView.h"

@interface UIView (SVHLoadingGap)
  // 外部调用 view默认和自身一样大
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style
                       block:(SVHLoadingGapViewReloadBlock)block;

/** 显示加载中样式  可指定加载控件的颜色和显示位置 如果loadingOrigin为CGPointZero，则在view的中心, 如果loadingColor为nil 则颜色为orangeColor*/
- (void)showGapViewWithLoadingStyle:(UIColor*)loadingColor
                            atPoint:(CGPoint)loadingOrigin;

  // 外部调用 view frame 自定义
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style
                       block:(SVHLoadingGapViewReloadBlock)block
                       frame:(CGRect)frame;

  // 外部调用 view frame 自定义 文字自定义
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style block:(SVHLoadingGapViewReloadBlock)block frame:(CGRect)frame gapText:(NSString*)gapText;
  // 外部调用 view默认和自身一样大 文字自定义
- (void)showGapViewWithStyle:(SVHLoadingGapViewStyle)style block:(SVHLoadingGapViewReloadBlock)block  gapText:(NSString*)gapText;

- (void)hideGapView;

- (BOOL)gapViewIsVisibal;

- (SVHLoadingGapView *)gapView;

@end
