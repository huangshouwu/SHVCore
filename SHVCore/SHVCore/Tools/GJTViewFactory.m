//
//  GJTViewFactory.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJTViewFactory.h"

@implementation GJTViewFactory

+ (UILabel*)createLabelWithFrame:(CGRect)frame{
    return [GJTViewFactory createLabelWithFrame:frame font:nil];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font{
    return [GJTViewFactory createLabelWithFrame:frame font:font color:nil];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font color:(UIColor*)color{
    return [GJTViewFactory createLabelWithFrame:frame font:font color:color text:nil];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font color:(UIColor*)color text:(NSString*)text{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    return [GJTViewFactory setLabel:label font:font color:color text:text];
}

+ (UILabel*)setLabel:(UILabel*)label font:(UIFont*)font color:(UIColor*)color text:(NSString*)text{
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = color;
    return label;
}

@end
