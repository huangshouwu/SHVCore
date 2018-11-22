//
//  MyTabbar.m
//  test
//
//  Created by huang shervin on 12-10-27.
//  Copyright (c) 2012年 huang shervin. All rights reserved.
//

#import "SVHTabBar.h"
#import "UIView+CustomBadge.h"

@implementation SVHTabBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}

- (id)initWithItems:(NSArray*)items frame:(CGRect)frame{
    self = [self initWithFrame:frame];
    if (self){
        self.items = items;
        CGRect rect;
        _lastSelectedIndex = 0;
        _buttonWidth = frame.size.width/items.count;
        rect.origin.y = 0.0f;
        rect.size = CGSizeMake(_buttonWidth, frame.size.height);
        for (SVHTabBarItem* item in items) {
            NSUInteger index = [items indexOfObject:item];
            rect.origin.x = index*_buttonWidth;
            SVHTabBarButton* button = [[SVHTabBarButton alloc] initWithItem:item frame:rect];
            [button setBadge:[item.badgeValue integerValue]];
            button.backgroundColor = [UIColor clearColor];
            button.barDelegate = self;
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setBackgroudImage:(UIImage *)backgroudImage{
    if (backgroudImage!=nil){
        _backgroudImageView.image = backgroudImage;
        [self insertSubview:_backgroudImageView ifContainView:_backgroudView];
    }
}

- (void)insertSubview:(UIView*)view ifContainView:(UIView*)containView{
    if (![self.subviews containsObject:containView]){
        [self insertSubview:view atIndex:0];
    }
}

- (void)setBackgroudView:(UIView *)backgroudView{
    if (backgroudView==nil) {
        if (_backgroudView){
            [_backgroudView removeFromSuperview];
        }
    }else {
        if (_backgroudView){
            [_backgroudView removeFromSuperview];
        }
        _backgroudView = backgroudView;
        [self insertSubview:_backgroudView ifContainView:_backgroudImageView];
    }
}

- (void)setSelectedItem:(NSUInteger)index{
    _lastSelectedIndex = _currentSelectedIndex;
    _currentSelectedIndex = index;
    if (index<self.items.count){
        SVHTabBarItem* item = [self.items objectAtIndex:index];
        for (UIView* view in self.subviews) {
            if ([view isMemberOfClass:[SVHTabBarButton class]]){
                SVHTabBarButton* button = (SVHTabBarButton*)view;
                if (item==button.item){
                    [button setHightLighted:YES];
                }else{
                    [button setHightLighted:NO];
                }
            }
        }
    }
}

- (NSUInteger)indexOfObject:(SVHTabBarButton*)object{
    if (object){
        for (SVHTabBarItem* item in self.items) {
            if (item == object.item){
                return [self.items indexOfObject:item];
            }
        }
    }
    return 0;
}

- (SVHTabBarButton*)buttonAtIndex:(NSInteger)index{
    if (index < self.subviews.count) {
        return [self.subviews objectAtIndex:index];
    }else
        return nil;
}

- (void)setBadgeValue:(NSString*)badgeValue atIndex:(NSInteger)index{
    SVHTabBarButton* button = [self buttonAtIndex:index];
    if ([button isKindOfClass:[SVHTabBarButton class]]) {
        [button setBadge:[badgeValue integerValue]];
    }
}

#pragma mark MyTabbarButtonDelegate
- (void)didSelectObject:(SVHTabBarButton *)object{
    
    //需要实现的帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.2,@0.9,@1.1,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    //把动画添加上去
    [object.layer addAnimation:animation forKey:nil];
    
    if ([self.delegate respondsToSelector:@selector(didSelectObject:atIndex:)]){
        [self.delegate didSelectObject:object atIndex:[self indexOfObject:object]];
    }
}

- (void)myTabbarDoubleClicked:(SVHTabBarButton *)object{
    if ([self.delegate respondsToSelector:@selector(myTabbarDoubleClicked:)]) {
        [self.delegate didDoubleClickedWithObject:object atIndex:[self indexOfObject:object]];
    }
}

@end

@implementation SVHTabBarItem
@synthesize title,image,titleColor,hightLightedColor,hightLightedImage,tag;

+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image hightLightImage:(UIImage*)hightLightedImage color:(UIColor*)color hightLightedColor:(UIColor*)hightLightColor tag:(NSUInteger)tag;{
    SVHTabBarItem* item = [[self alloc] init];
    item.title = title;
    item.image = image;
    item.hightLightedImage = hightLightedImage;
    item.hightLightedColor = hightLightColor;
    item.titleColor = color;
    item.tag = tag;
    return item;
}

@end
