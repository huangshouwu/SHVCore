//
//  GJTBaseNavigationController.m
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseNavigationController.h"
#import "GJTBaseViewController.h"

@interface GJTBaseNavigationController ()

@end

@implementation GJTBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        if ([rootViewController isKindOfClass:[GJTBaseViewController class]]) {
            GJTBaseViewController* vc = (GJTBaseViewController*)rootViewController;
            vc.enabelPopGestureRecognizer = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置导航栏颜色和不透明 */
    [self.navigationBar setTranslucent:NO];
//    [self.navigationBar setBarTintColor:GJTAppMainColor()];
    [self.navigationBar setBarTintColor:UIColor.redColor];
    [self.navigationBar setTintColor:UIColor.greenColor];
}

@end
