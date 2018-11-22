//
//  GJTBorderProperty.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "UIView+GJTBorderProperty.h"

UIBezierPath * GJTBorderLinePath(CGSize size, GJTBorderLineStyle style, UIRectCorner corner, CGSize radii,CGFloat lineWidth) {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = lineWidth;
    if(GJTBorder_Line_Top == (GJTBorder_Line_Top & style)) {
        [path moveToPoint:CGPointMake(radii.width, lineWidth/2)];
        [path addLineToPoint:CGPointMake(size.width - radii.width, lineWidth/2)];
    }
    if(GJTBorder_Line_Right == (GJTBorder_Line_Right & style)) {
        [path moveToPoint:CGPointMake(size.width - lineWidth/2, radii.height)];
        [path addLineToPoint:CGPointMake(size.width - lineWidth/2, size.height - radii.height)];
    }
    if(GJTBorder_Line_Bottom == (GJTBorder_Line_Bottom & style)) {
        [path moveToPoint:CGPointMake(size.width - radii.width, size.height  - lineWidth/2)];
        [path addLineToPoint:CGPointMake(radii.width, size.height  - lineWidth/2)];
    }
    if(GJTBorder_Line_Left == (GJTBorder_Line_Left & style)) {
        [path moveToPoint:CGPointMake(lineWidth/2, size.height - radii.height)];
        [path addLineToPoint:CGPointMake(lineWidth/2, radii.height)];
    }
    
    if(corner == 0) {
        return (path);
    }
    
    if(UIRectCornerTopLeft == (UIRectCornerTopLeft & corner)) {
        [path moveToPoint:CGPointMake(0, radii.height)];
        [path addQuadCurveToPoint:CGPointMake(radii.width, 0) controlPoint:CGPointMake(0, 0)];
    } else {
        [path moveToPoint:CGPointMake(0, radii.height)];
        [path addLineToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(radii.width, 0)];
    }
    
    if(UIRectCornerTopRight == (UIRectCornerTopRight & corner)) {
        [path moveToPoint:CGPointMake(size.width - radii.width, 0)];
        [path addQuadCurveToPoint:CGPointMake(size.width, radii.height) controlPoint:CGPointMake(size.width, 0)];
    } else {
        [path moveToPoint:CGPointMake(size.width - radii.width, 0)];
        [path addLineToPoint:CGPointMake(size.width, 0)];
        [path addLineToPoint:CGPointMake(radii.width, radii.height)];
    }
    
    if(UIRectCornerBottomRight == (UIRectCornerBottomRight & corner)) {
        [path moveToPoint:CGPointMake(size.width, size.height - radii.height)];
        [path addQuadCurveToPoint:CGPointMake(size.width - radii.width, size.height) controlPoint:CGPointMake(size.width, size.height)];
    } else {
        [path moveToPoint:CGPointMake(size.width, size.height - radii.height)];
        [path addLineToPoint:CGPointMake(size.width, size.height)];
        [path addLineToPoint:CGPointMake(size.width - radii.width, size.height)];
    }
    
    if(UIRectCornerBottomLeft == (UIRectCornerBottomLeft & corner)) {
        [path moveToPoint:CGPointMake(radii.width, size.height)];
        [path addQuadCurveToPoint:CGPointMake(0, size.height - radii.height) controlPoint:CGPointMake(0, size.height)];
    } else {
        [path moveToPoint:CGPointMake(radii.width, size.height)];
        [path addLineToPoint:CGPointMake(0, size.height)];
        [path addLineToPoint:CGPointMake(0, size.height - radii.height)];
    }
    return (path);
}

UIBezierPath * GJTBorderLinePathWithSize(CGSize size, GJTBorderLineStyle style, UIRectCorner corner, CGSize radii) {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat lineWidth = 0;
    if(GJTBorder_Line_Top == (GJTBorder_Line_Top & style)) {
        [path moveToPoint:CGPointMake(radii.width, lineWidth/2)];
        [path addLineToPoint:CGPointMake(size.width - radii.width, lineWidth/2)];
    }
    if(GJTBorder_Line_Right == (GJTBorder_Line_Right & style)) {
        [path moveToPoint:CGPointMake(size.width - lineWidth/2, radii.height)];
        [path addLineToPoint:CGPointMake(size.width - lineWidth/2, size.height - radii.height)];
    }
    if(GJTBorder_Line_Bottom == (GJTBorder_Line_Bottom & style)) {
        [path moveToPoint:CGPointMake(size.width - radii.width, size.height  - lineWidth/2)];
        [path addLineToPoint:CGPointMake(radii.width, size.height  - lineWidth/2)];
    }
    if(GJTBorder_Line_Left == (GJTBorder_Line_Left & style)) {
        [path moveToPoint:CGPointMake(lineWidth/2, size.height - radii.height)];
        [path addLineToPoint:CGPointMake(lineWidth/2, radii.height)];
    }
    
    if(corner == 0) {
        return (path);
    }
    
    if(UIRectCornerTopLeft == (UIRectCornerTopLeft & corner)) {
        [path moveToPoint:CGPointMake(0, radii.height)];
        [path addQuadCurveToPoint:CGPointMake(radii.width, 0) controlPoint:CGPointMake(0, 0)];
    } else {
        [path moveToPoint:CGPointMake(0, radii.height)];
        [path addLineToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(radii.width, 0)];
    }
    
    if(UIRectCornerTopRight == (UIRectCornerTopRight & corner)) {
        [path moveToPoint:CGPointMake(size.width - radii.width, 0)];
        [path addQuadCurveToPoint:CGPointMake(size.width, radii.height) controlPoint:CGPointMake(size.width, 0)];
    } else {
        [path moveToPoint:CGPointMake(size.width - radii.width, 0)];
        [path addLineToPoint:CGPointMake(size.width, 0)];
        [path addLineToPoint:CGPointMake(radii.width, radii.height)];
    }
    
    if(UIRectCornerBottomRight == (UIRectCornerBottomRight & corner)) {
        [path moveToPoint:CGPointMake(size.width, size.height - radii.height)];
        [path addQuadCurveToPoint:CGPointMake(size.width - radii.width, size.height) controlPoint:CGPointMake(size.width, size.height)];
    } else {
        [path moveToPoint:CGPointMake(size.width, size.height - radii.height)];
        [path addLineToPoint:CGPointMake(size.width, size.height)];
        [path addLineToPoint:CGPointMake(size.width - radii.width, size.height)];
    }
    
    if(UIRectCornerBottomLeft == (UIRectCornerBottomLeft & corner)) {
        [path moveToPoint:CGPointMake(radii.width, size.height)];
        [path addQuadCurveToPoint:CGPointMake(0, size.height - radii.height) controlPoint:CGPointMake(0, size.height)];
    } else {
        [path moveToPoint:CGPointMake(radii.width, size.height)];
        [path addLineToPoint:CGPointMake(0, size.height)];
        [path addLineToPoint:CGPointMake(0, size.height - radii.height)];
    }
    return (path);
}

void GJTADDBorderLine(UIView* view,UIColor* borderColor,GJTBorderLineStyle borderStyle,CGFloat borderWidth,UIRectCorner corner,CGSize cornerSize){
    UIBezierPath *linePath = GJTBorderLinePathWithSize(view.frame.size, borderStyle, corner, cornerSize);
    linePath.lineWidth = borderWidth;
    if(borderColor && linePath && !CGPathIsEmpty(linePath.CGPath)) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        CGContextSetLineWidth(context, borderWidth);
        CGContextSetFillColorWithColor(context, [view backgroundColor].CGColor);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextAddPath(context, linePath.CGPath);
        CGContextStrokePath(context);
        UIGraphicsPopContext();
    }
    
    if(cornerSize.width == 0 || cornerSize.height == 0) {
        return;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:cornerSize];
    if(![maskPath isEmpty]) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }
}

static NSString* GJTBorderPropertyKey_borderColor = @"GJTBorderPropertyKey_borderColor";
static NSString* GJTBorderPropertyKey_borderWidth = @"GJTBorderPropertyKey_borderWidth";
static NSString* GJTBorderPropertyKey_borderStyle = @"GJTBorderPropertyKey_borderStyle";
static NSString* GJTBorderPropertyKey_corner      = @"GJTBorderPropertyKey_corner";
static NSString* GJTBorderPropertyKey_cornerSize  = @"GJTBorderPropertyKey_cornerSize";

#import <objc/runtime.h>
@implementation UIView (GJTBorderProperty)

- (void)setBorderColor:(UIColor *)borderColor{
    objc_setAssociatedObject(self, &GJTBorderPropertyKey_borderColor,borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    objc_setAssociatedObject(self, &GJTBorderPropertyKey_borderWidth,@(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBorderStyle:(GJTBorderLineStyle)borderStyle{
    objc_setAssociatedObject(self, &GJTBorderPropertyKey_borderStyle,@(borderStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCorner:(UIRectCorner)corner{
    objc_setAssociatedObject(self, &GJTBorderPropertyKey_corner,@(corner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCornerSize:(CGSize)cornerSize{
    objc_setAssociatedObject(self, &GJTBorderPropertyKey_cornerSize,NSStringFromCGSize(cornerSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*)borderColor{
    return objc_getAssociatedObject(self, &GJTBorderPropertyKey_borderColor);
}

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, &GJTBorderPropertyKey_borderWidth) floatValue];
}

- (GJTBorderLineStyle)borderStyle{
    return (GJTBorderLineStyle)[objc_getAssociatedObject(self, &GJTBorderPropertyKey_borderStyle) unsignedIntegerValue];
}

- (UIRectCorner)corner{
    return (UIRectCorner)(GJTBorderLineStyle)[objc_getAssociatedObject(self, &GJTBorderPropertyKey_corner) unsignedIntegerValue];
}

- (CGSize)cornerSize{
    NSString* sizeString = objc_getAssociatedObject(self, &GJTBorderPropertyKey_cornerSize);
    return CGSizeFromString(sizeString);
}

- (void)addBorderLineWithStyle:(GJTBorderLineStyle)style{
    [self addBorderLineWithStyle:style color:UIColor.lightGrayColor width:1.0f/[[UIScreen mainScreen] scale]];
}

- (void)addBorderLineWithStyle:(GJTBorderLineStyle)style color:(UIColor*)borderColor width:(CGFloat)borderWidth{
    self.borderStyle = style;
    self.borderColor = borderColor;
    self.borderWidth = borderWidth;
    [self setNeedsDisplay];
}

@end
