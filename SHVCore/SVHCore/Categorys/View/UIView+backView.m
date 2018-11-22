//
//  UIView+backView.m
//  Lottery
//
//  Created by huangshouwu on 13-11-13.
//  Copyright (c) 2013年 9188-MacPro1. All rights reserved.
//

static const void *kBackViewIdentifier = &kBackViewIdentifier;

#import "UIView+backView.h"
#import <objc/runtime.h>


@implementation UIView (backView)
// 1 背景渐变显示出来
- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
                      target:(id)target
                 touchAction:(SEL)selector
                   animation:(void(^)(void))animation
                timeInterval:(NSTimeInterval)interval
                   fininshed:(void(^)(BOOL finished))finished{
    // 禁交互
    if (![UIApplication sharedApplication].isIgnoringInteractionEvents) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    [self showViewWithBackView:view
                         alpha:0
                        target:target
                   touchAction:selector];
    
    [UIView animateWithDuration:interval
                     animations:^(void){
                         self.backView.alpha = a;
                         if (animation) {
                             animation ();
                         }
                     }
                     completion:^(BOOL f) {
                         //开交互
                         if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         }
                         if (finished) {
                             finished(f);
                         }
                     }];
}
// 2.背景直接显示出来
- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
                   backColor:(UIColor*)backColor
                      target:(id)target
                 touchAction:(SEL)selector
                   animation:(void(^)(void))animation
                timeInterval:(NSTimeInterval)interval
                   fininshed:(void(^)(BOOL finished))fininshed{
    //禁交互
    if (![UIApplication sharedApplication].isIgnoringInteractionEvents) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    [self showViewWithBackView:view
                         alpha:a
                 backViewColor:backColor
                        target:target
                   touchAction:selector];
    
    [UIView animateWithDuration:interval
                     animations:animation
                     completion:^(BOOL f) {
                         //开交互
                         if ([UIApplication sharedApplication].isIgnoringInteractionEvents) {
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                         }
                         if (fininshed) {
                             fininshed(f);
                         }
                     }];
}
// 背景图 ,默认黑色
- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
                      target:(id)target
                 touchAction:(SEL)selector
{
    [self showViewWithBackView:view
                         alpha:a
                 backViewColor:[UIColor blackColor]
                        target:target
                   touchAction:selector];
}

- (void)showViewWithBackView:(UIView *)view
                       alpha:(CGFloat)a
               backViewColor:(UIColor*)backColor
                      target:(id)target
                 touchAction:(SEL)selector{
    if (![self backView]) {
        UIView* backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = backColor;
        backView.alpha = a;
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        [backView addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kBackViewIdentifier, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:backView];
    }
    [self addSubview:view];
    
}

- (void)hideBackViewForView:(UIView *)view
                  animation:(void(^)(void))animation
               timeInterval:(NSTimeInterval)interval
                  fininshed:(void(^)(BOOL complation))fininshed{
    __weak typeof(self) block_self = self;
    [UIView animateWithDuration:interval
                     animations:^(void){
                         self.backView.alpha = 0;
                         if (animation) {
                             animation();
                         }
                     }
                     completion:^(BOOL finish){
                         [block_self hideBackViewForView:view];
                         if (fininshed) {
                             fininshed(finish);
                         }
                     }];
}

- (void)hideBackViewForView:(UIView *)view{
    UIView* backView = [self backView];
    [view removeFromSuperview];
    [backView removeFromSuperview];
    objc_setAssociatedObject(self, kBackViewIdentifier, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //
}

- (UIView*)backView{
    UIView* backView = objc_getAssociatedObject(self, kBackViewIdentifier);
    return backView;
}

@end
