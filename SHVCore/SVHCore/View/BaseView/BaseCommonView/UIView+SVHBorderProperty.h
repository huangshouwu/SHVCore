//
//  SVHBorderProperty.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SVHBorderLineStyle) {
    SVHBorder_Line_None      =   0UL,          //无边框
    SVHBorder_Line_Top       =   1UL << 0,     //仅上边框
    SVHBorder_Line_Bottom    =   1UL << 1,     //仅下边框
    SVHBorder_Line_Left      =   1UL << 2,     //仅左边框
    SVHBorder_Line_Right     =   1UL << 3,     //仅右边框
    SVHBorder_Line_All       =   SVHBorder_Line_Top | SVHBorder_Line_Bottom | SVHBorder_Line_Left | SVHBorder_Line_Right,    //四周边框
};

/** 给view 画边线 */
void SVHADDBorderLine(UIView* view,UIColor* borderColor,SVHBorderLineStyle borderStyle,CGFloat borderWidth,UIRectCorner corner,CGSize cornerSize);

@interface UIView (SVHBorderProperty)

@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) SVHBorderLineStyle borderStyle;

@property (assign, nonatomic) UIRectCorner corner;
@property (assign, nonatomic) CGSize cornerSize;


/**
 简易版添加边线方法，borderColor为UIColor.lightGreyColor;borderWidth为1.0/[[UIScreen mainScreen] scale]

 @param style 边线添加位置
 */
- (void)addBorderLineWithStyle:(SVHBorderLineStyle)style;

/**
 添加边线方法

 @param style 边线添加位置
 @param borderColor 边线颜色
 @param borderWidth 边线的高度
 */
- (void)addBorderLineWithStyle:(SVHBorderLineStyle)style color:(UIColor*)borderColor width:(CGFloat)borderWidth;

@end
