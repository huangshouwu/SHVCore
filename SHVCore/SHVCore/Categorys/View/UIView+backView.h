//
//  UIView+backView.h
//  Lottery
//
//  Created by huangshouwu on 13-11-13.
//  Copyright (c) 2013年 9188-MacPro1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (backView)

@property (nonatomic,readonly)UIView* backView;

- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
                      target:(id)target
                 touchAction:(SEL)selector;

- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
                      target:(id)target
                 touchAction:(SEL)selector
                   animation:(void(^)(void))animation
                timeInterval:(NSTimeInterval)interval
                   fininshed:(void(^)(BOOL finished))fininshed;

- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
                   backColor:(UIColor*)backColor
                      target:(id)target
                 touchAction:(SEL)selector
                   animation:(void(^)(void))animation
                timeInterval:(NSTimeInterval)interval
                   fininshed:(void(^)(BOOL finished))fininshed;

- (void)hideBackViewForView:(UIView *)view
                  animation:(void(^)(void))animation
               timeInterval:(NSTimeInterval)interval
                  fininshed:(void(^)(BOOL complation))fininshed;

- (void)hideBackViewForView:(UIView *)view;

@end
