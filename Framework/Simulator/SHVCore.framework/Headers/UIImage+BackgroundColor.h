//
//  UIImage+BackgroundColor.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/8/15.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BackgroundColor)

- (UIImage *)removeColorWithMinHueAngle:(float)minHueAngle maxHueAngle:(float)maxHueAngle;

@end
