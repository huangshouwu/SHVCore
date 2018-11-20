//
//  GJTBorderProperty.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, GJTBorderLineStyle) {
    GJTBorder_Line_None      =   0UL,          //无边框
    GJTBorder_Line_Top       =   1UL << 0,     //仅上边框
    GJTBorder_Line_Bottom    =   1UL << 1,     //仅下边框
    GJTBorder_Line_Left      =   1UL << 2,     //仅左边框
    GJTBorder_Line_Right     =   1UL << 3,     //仅右边框
    GJTBorder_Line_All       =   GJTBorder_Line_Top | GJTBorder_Line_Bottom | GJTBorder_Line_Left | GJTBorder_Line_Right,    //四周边框
};

/** 给view 画边线 */
void GJTADDBorderLine(UIView* view,UIColor* borderColor,GJTBorderLineStyle borderStyle,CGFloat borderWidth,UIRectCorner corner,CGSize cornerSize);

@interface UIView (GJTBorderProperty)

@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) GJTBorderLineStyle borderStyle;

@property (assign, nonatomic) UIRectCorner corner;
@property (assign, nonatomic) CGSize cornerSize;


/**
 简易版添加边线方法，borderColor为UIColor.lightGreyColor;borderWidth为1.0/[[UIScreen mainScreen] scale]

 @param style 边线添加位置
 */
- (void)addBorderLineWithStyle:(GJTBorderLineStyle)style;

/**
 添加边线方法

 @param style 边线添加位置
 @param borderColor 边线颜色
 @param borderWidth 边线的高度
 */
- (void)addBorderLineWithStyle:(GJTBorderLineStyle)style color:(UIColor*)borderColor width:(CGFloat)borderWidth;

@end
