//
//  MyTabBarItem.h
//  test
//
//  Created by huang shervin on 12-10-27.
//  Copyright (c) 2012年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVHTabBarButtonDelegate;
@class SVHTabBarItem;

@interface SVHTabBarButton : UIView{
    UIImageView* _myImageView;
    UIImageView* _contentView;
}

@property (nonatomic ,strong)UILabel* titilLable;
@property (nonatomic)BOOL hightLighted;
@property (nonatomic,weak)SVHTabBarItem* item;//引用item不retain，为了在Mytabbar里面可以判断用户选中的item是否是button里面的item；
@property (nonatomic ,weak)id<SVHTabBarButtonDelegate> barDelegate;

- (id)initWithItem:(SVHTabBarItem*)item frame:(CGRect)frame;

@end

@protocol SVHTabBarButtonDelegate <NSObject>

@optional
- (void)didSelectObject:(SVHTabBarButton*)object;
- (void)myTabbarDoubleClicked:(SVHTabBarButton*)object;

@end
