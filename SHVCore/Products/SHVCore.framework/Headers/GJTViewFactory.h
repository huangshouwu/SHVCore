//
//  GJTViewFactory.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJTViewFactory : NSObject

/** label工厂方法 */
+ (UILabel*)createLabelWithFrame:(CGRect)frame;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font color:(UIColor*)color;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font color:(UIColor*)color text:(NSString*)text;
+ (UILabel*)setLabel:(UILabel*)label font:(UIFont*)font color:(UIColor*)color text:(NSString*)text;

@end
