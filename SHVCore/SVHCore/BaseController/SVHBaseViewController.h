//
//  SVHBaseViewController.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVHBaseViewController : UIViewController{
@public
    //键盘相关
    CGRect _keyboardBounds;
    NSTimeInterval _keybardAnmiatedTimeinterval;
}

@property (nonatomic, assign)BOOL enabelPopGestureRecognizer;/* 是否开启右滑手势 默认开启*/

-(void)hideKeyboard;
- (void)remoeTapGesure;

/** 重设self.view的frame isRoot为Yes表示有Tabbar */
- (void)resetViewFrame:(BOOL)isRoot;

/** 键盘通知 */
- (void)keyboardWillShow:(NSNotification*)notification;
- (void)keyboardDidShow:(NSNotification*)notification;
- (void)keyboardWillHide:(NSNotification*)notification;
- (void)keyboardDidHide:(NSNotification*)notification;

@end
