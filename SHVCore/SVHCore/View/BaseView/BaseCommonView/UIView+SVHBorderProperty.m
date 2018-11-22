//
//  SVHBorderProperty.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "UIView+SVHBorderProperty.h"

UIBezierPath * SVHBorderLinePath(CGSize size, SVHBorderLineStyle style, UIRectCorner corner, CGSize radii,CGFloat lineWidth) {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = lineWidth;
    if(SVHBorder_Line_Top == (SVHBorder_Line_Top & style)) {
        [path moveToPoint:CGPointMake(radii.width, lineWidth/2)];
        [path addLineToPoint:CGPointMake(size.width - radii.width, lineWidth/2)];
    }
    if(SVHBorder_Line_Right == (SVHBorder_Line_Right & style)) {
        [path moveToPoint:CGPointMake(size.width - lineWidth/2, radii.height)];
        [path addLineToPoint:CGPointMake(size.width - lineWidth/2, size.height - radii.height)];
    }
    if(SVHBorder_Line_Bottom == (SVHBorder_Line_Bottom & style)) {
        [path moveToPoint:CGPointMake(size.width - radii.width, size.height  - lineWidth/2)];
        [path addLineToPoint:CGPointMake(radii.width, size.height  - lineWidth/2)];
    }
    if(SVHBorder_Line_Left == (SVHBorder_Line_Left & style)) {
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

UIBezierPath * SVHBorderLinePathWithSize(CGSize size, SVHBorderLineStyle style, UIRectCorner corner, CGSize radii) {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat lineWidth = 0;
    if(SVHBorder_Line_Top == (SVHBorder_Line_Top & style)) {
        [path moveToPoint:CGPointMake(radii.width, lineWidth/2)];
        [path addLineToPoint:CGPointMake(size.width - radii.width, lineWidth/2)];
    }
    if(SVHBorder_Line_Right == (SVHBorder_Line_Right & style)) {
        [path moveToPoint:CGPointMake(size.width - lineWidth/2, radii.height)];
        [path addLineToPoint:CGPointMake(size.width - lineWidth/2, size.height - radii.height)];
    }
    if(SVHBorder_Line_Bottom == (SVHBorder_Line_Bottom & style)) {
        [path moveToPoint:CGPointMake(size.width - radii.width, size.height  - lineWidth/2)];
        [path addLineToPoint:CGPointMake(radii.width, size.height  - lineWidth/2)];
    }
    if(SVHBorder_Line_Left == (SVHBorder_Line_Left & style)) {
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

void SVHADDBorderLine(UIView* view,UIColor* borderColor,SVHBorderLineStyle borderStyle,CGFloat borderWidth,UIRectCorner corner,CGSize cornerSize){
    UIBezierPath *linePath = SVHBorderLinePathWithSize(view.frame.size, borderStyle, corner, cornerSize);
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

static NSString* SVHBorderPropertyKey_borderColor = @"SVHBorderPropertyKey_borderColor";
static NSString* SVHBorderPropertyKey_borderWidth = @"SVHBorderPropertyKey_borderWidth";
static NSString* SVHBorderPropertyKey_borderStyle = @"SVHBorderPropertyKey_borderStyle";
static NSString* SVHBorderPropertyKey_corner      = @"SVHBorderPropertyKey_corner";
static NSString* SVHBorderPropertyKey_cornerSize  = @"SVHBorderPropertyKey_cornerSize";

#import <objc/runtime.h>
@implementation UIView (SVHBorderProperty)

- (void)setBorderColor:(UIColor *)borderColor{
    objc_setAssociatedObject(self, &SVHBorderPropertyKey_borderColor,borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    objc_setAssociatedObject(self, &SVHBorderPropertyKey_borderWidth,@(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBorderStyle:(SVHBorderLineStyle)borderStyle{
    objc_setAssociatedObject(self, &SVHBorderPropertyKey_borderStyle,@(borderStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCorner:(UIRectCorner)corner{
    objc_setAssociatedObject(self, &SVHBorderPropertyKey_corner,@(corner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCornerSize:(CGSize)cornerSize{
    objc_setAssociatedObject(self, &SVHBorderPropertyKey_cornerSize,NSStringFromCGSize(cornerSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor*)borderColor{
    return objc_getAssociatedObject(self, &SVHBorderPropertyKey_borderColor);
}

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, &SVHBorderPropertyKey_borderWidth) floatValue];
}

- (SVHBorderLineStyle)borderStyle{
    return (SVHBorderLineStyle)[objc_getAssociatedObject(self, &SVHBorderPropertyKey_borderStyle) unsignedIntegerValue];
}

- (UIRectCorner)corner{
    return (UIRectCorner)(SVHBorderLineStyle)[objc_getAssociatedObject(self, &SVHBorderPropertyKey_corner) unsignedIntegerValue];
}

- (CGSize)cornerSize{
    NSString* sizeString = objc_getAssociatedObject(self, &SVHBorderPropertyKey_cornerSize);
    return CGSizeFromString(sizeString);
}

- (void)addBorderLineWithStyle:(SVHBorderLineStyle)style{
    [self addBorderLineWithStyle:style color:UIColor.lightGrayColor width:1.0f/[[UIScreen mainScreen] scale]];
}

- (void)addBorderLineWithStyle:(SVHBorderLineStyle)style color:(UIColor*)borderColor width:(CGFloat)borderWidth{
    self.borderStyle = style;
    self.borderColor = borderColor;
    self.borderWidth = borderWidth;
    [self setNeedsDisplay];
}

@end
