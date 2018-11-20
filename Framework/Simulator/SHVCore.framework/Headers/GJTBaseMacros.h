//
//  GJTBaseMacros.h
//  Liaodao
//
//  Created by hsw on 2018/3/28.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GJTScreenBounds [UIScreen mainScreen].bounds
#define GJTIsiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define GJTIsiPhoneX (GJTScreenBounds.size.height >= 812.0f && GJTScreenBounds.size.width >= 375.0f && GJTIsiPhone)
#define GJTStatusBarHeight (GJTIsiPhoneX?44.0f:20.0f)
#define GJTTabBarHeight (GJTIsiPhoneX?83.0f:49.0f)
#define GJTBottomSafeMargin (GJTIsiPhoneX ? 34 : 0)

#ifdef DEBUG
#define GJTLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define GJTLog(xx, ...)  ((void)0)
#endif
