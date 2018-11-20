//
//  MyTabBarItem.h
//  test
//
//  Created by huang shervin on 12-10-27.
//  Copyright (c) 2012年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GJTTabBarButtonDelegate;
@class GJTTabBarItem;

@interface GJTTabBarButton : UIView{
    UIImageView* _myImageView;
    UIImageView* _contentView;
}

@property (nonatomic ,strong)UILabel* titilLable;
@property (nonatomic)BOOL hightLighted;
@property (nonatomic,weak)GJTTabBarItem* item;//引用item不retain，为了在Mytabbar里面可以判断用户选中的item是否是button里面的item；
@property (nonatomic ,weak)id<GJTTabBarButtonDelegate> barDelegate;

- (id)initWithItem:(GJTTabBarItem*)item frame:(CGRect)frame;

@end

@protocol GJTTabBarButtonDelegate <NSObject>

@optional
- (void)didSelectObject:(GJTTabBarButton*)object;
- (void)myTabbarDoubleClicked:(GJTTabBarButton*)object;

@end
