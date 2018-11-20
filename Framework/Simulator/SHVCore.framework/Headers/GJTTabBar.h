//
//  MyTabbar.h
//  test
//
//  Created by huang shervin on 12-10-27.
//  Copyright (c) 2012年 huang shervin. All rights reserved.
//
#import "GJTTabBarButton.h"
#import "GJTBaseView.h"

@protocol GJTTabBarDelegate <NSObject>

@optional
- (void)didSelectObject:(GJTTabBarButton*)object atIndex:(NSUInteger)index;
- (void)didDoubleClickedWithObject:(GJTTabBarButton*)object atIndex:(NSUInteger)index;

@end

@interface GJTTabBar : GJTBaseView<GJTTabBarButtonDelegate>{
    CGFloat _buttonWidth;
    NSUInteger _currentSelectedIndex;
    UIImageView* _backgroudImageView;
}

@property (nonatomic ,strong)NSArray* items;//item 需要在初始化的时候指定

//backgroudImage 与backgroudView,两者最多只能有一个
@property (nonatomic ,strong)UIImage* backgroudImage;//tabbar的背景图片；
@property (nonatomic ,strong)UIView* backgroudView;

@property (nonatomic ,weak)id<GJTTabBarDelegate> delegate;
@property (nonatomic,readonly)NSUInteger lastSelectedIndex;//上一次选中的item的序号
@property (nonatomic,readonly)NSUInteger currentSelectedIndex;

- (id)initWithItems:(NSArray*)items frame:(CGRect)frame;

- (void)setSelectedItem:(NSUInteger)index;

- (void)setBadgeValue:(NSString*)badgeValue atIndex:(NSInteger)index;

@end

@interface GJTTabBarItem : NSObject

@property (nonatomic ,strong)NSString* title;
@property (nonatomic ,strong)UIImage* image;//按钮默认图片
@property (nonatomic ,strong)UIImage* hightLightedImage;//按钮高亮时候的图片
@property (nonatomic ,strong)UIColor* titleColor;//文字默认状态时候的颜色
@property (nonatomic ,strong)UIColor* hightLightedColor;//文字高亮时候的颜色
@property (nonatomic)NSUInteger tag;//按钮的tag；
@property (nonatomic,copy) NSString * label;// 标签
@property (nonatomic,copy)NSString* badgeValue;

+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image hightLightImage:(UIImage*)hightLightedImage color:(UIColor*)color hightLightedColor:(UIColor*)hightLightColor tag:(NSUInteger)tag;

@end
