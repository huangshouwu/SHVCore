//
//  SVHBaseMacros.h
//  Liaodao
//
//  Created by hsw on 2018/3/28.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SVHScreenBounds [UIScreen mainScreen].bounds
#define SVHIsiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SVHIsiPhoneX (SVHScreenBounds.size.height >= 812.0f && SVHScreenBounds.size.width >= 375.0f && SVHIsiPhone)
#define SVHStatusBarHeight (SVHIsiPhoneX?44.0f:20.0f)
#define SVHTabBarHeight (SVHIsiPhoneX?83.0f:49.0f)
#define SVHBottomSafeMargin (SVHIsiPhoneX ? 34 : 0)

#ifdef DEBUG
#define SVHLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define SVHLog(xx, ...)  ((void)0)
#endif
