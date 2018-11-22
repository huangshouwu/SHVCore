//
//  SVHCustomKeyboard.h
//  Lottery
//
//  Created by hsw on 16/2/23.
//  Copyright © 2016年 9188-MacPro1. All rights reserved.
//

#import "SVHBaseView.h"
#import "SVHBaseButton.h"

typedef enum {
    SVHCustomKeyboardTypeNumberPad,     /* 纯数字键盘，无小数点 */
    SVHCustomKeyboardTypeNumAndDotPad,  /* 纯数字键盘，有小数点 */
    SVHCustomKeyboardTypeNumAndXPad,    /* 数字键盘，有字母‘X’ */
}SVHCustomKeyboardType;

typedef NS_ENUM (NSInteger,SVHDeleteButtonTouchState){
    SVHDeleteButtonTouchStateBegan,
    SVHDeleteButtonTouchStateCancelled,
    SVHDeleteButtonTouchStateEnded
};

@interface SVHCustomKeyboard : SVHBaseView

+ (instancetype)keyBoardWithType:(SVHCustomKeyboardType)type;

/** 键盘高度 */
+ (CGFloat )keyBoardHeight;

/** 确定按钮 */
@property (nonatomic,strong)SVHBaseButton* sureButton;

/** 键盘当前类型 */
@property (nonatomic,readonly,assign)SVHCustomKeyboardType keyboardType;

/** 当输入框里面的内容为空时是否禁用确定按钮 */
@property (nonatomic,assign)BOOL disableSureButtonWhenTextFieldNoContent;

/** 当前的响应者 (除UITextField 其他响应者都被忽略) */
- (UITextField*)currentResponderTextField;

@end

@interface SVHDeleteButton : SVHBaseButton

typedef void(^SVHDeleteButtonTouchBlock)(SVHDeleteButton* button,SVHDeleteButtonTouchState);

@property (nonatomic,copy)SVHDeleteButtonTouchBlock touchBlock;

@end
