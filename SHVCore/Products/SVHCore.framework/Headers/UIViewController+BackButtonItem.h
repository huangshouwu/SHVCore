//
//  UIViewController+BackButtonItem.h
//  Lottery
//
//  Created by huangshouwu on 14-7-14.
//  Copyright (c) 2014年 9188-MacPro1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BackButtonItem)

/**
 显示返回按钮，
 （返回按钮在导航navigationController的viewControllers数量超过1的时候才会出现）
 **/
- (void)showBackItem;

/**
 显示返回按钮，可以自行指定返回按钮的事件
（返回按钮在导航navigationController的viewControllers数量超过1的时候才会出现）
 **/
- (void)showBackItemWithAction:(SEL)action;

/**
 显示返回按钮
 （无论navigationController的viewControllers数量为几，都会在导航条左边显示返回按钮）
**/
- (void)forceShowBackItem;

/**
 显示返回按钮,可以自行指定返回按钮的事件
 （无论navigationController的viewControllers数量为几，都会在导航条左边显示返回按钮）
 **/

- (void)forceShowBackItemWithAction:(SEL)action;

- (void)forceShowBackItemWithAction:(SEL)action frame:(CGRect)frame;

/**
 可以指定图片的返回item
 **/
- (void)forceShowBackItemWithImage:(UIImage *)image;

- (void)forceShowBackItemWithImage:(UIImage *)image
                             title:(NSString*)title
                            action:(SEL)action
                             frame:(CGRect)frame;

- (void)backButtonItemAction;

- (UIButton*)createRightButtonWithImage:(UIImage*)image target:(id)target selector:(SEL)selector;

@end
