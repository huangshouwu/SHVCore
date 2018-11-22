//
//  MyTabBarItem.m
//  test
//
//  Created by huang shervin on 12-10-27.
//  Copyright (c) 2012年 huang shervin. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

static CGFloat kImage_Title_Space = 3.5;
static CGFloat kImageTop = 6.5;
#import "SVHTabBarButton.h"
#import "SVHTabBar.h"

@interface SVHTabBarButton()<UIGestureRecognizerDelegate>
@property (nonatomic,copy) NSString * label;
@end

@implementation SVHTabBarButton

- (id)initWithItem:(SVHTabBarItem *)item frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.label = item.label;
        self.tag = item.tag;
        _item = item;
        _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.alpha = 0.01;
        _contentView.userInteractionEnabled = NO;
        [self addSubview:_contentView];
        
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _myImageView.image = item.image;
        _myImageView.highlightedImage = item.hightLightedImage;
        _myImageView.backgroundColor = [UIColor clearColor];
        _myImageView.userInteractionEnabled = NO;
        [self addSubview:_myImageView];
        
        _titilLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titilLable.text = item.title;
        _titilLable.textColor = item.titleColor;
        _titilLable.textAlignment = NSTextAlignmentCenter;
        _titilLable.backgroundColor = [UIColor clearColor];
        _titilLable.font = [UIFont systemFontOfSize:11];
        _titilLable.highlightedTextColor = item.hightLightedColor;
        [self addSubview:_titilLable];
           
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectObject)];
//        gesture.numberOfTapsRequired = 1;
//        gesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:gesture];
        
        /*******加了双击之后 单击手势响应速度有些慢**/
         
//        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap)];
//        doubleTapGesture.numberOfTapsRequired =2;
//        doubleTapGesture.numberOfTouchesRequired =1;
//        [self addGestureRecognizer:doubleTapGesture];
//
//        [gesture requireGestureRecognizerToFail:doubleTapGesture];
        
        // tabbar数据在购彩大厅接口中下发,由NOEETabBarDataLoader管理下载图片,在所有图片下载完成发出通知,每个MYTabBarButton 在通知里面用label作为key去拿新的数据并赋值给自己的相关控件
    }
    return self;
}

- (void)setHightLighted:(BOOL)hightLighted{
    _titilLable.highlighted = hightLighted;
    _myImageView.highlighted = hightLighted;
}

- (void)layoutSubviews {
   [super layoutSubviews];
    
    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGSize imageSize = CGSizeMake(22, 22);//_myImageView.image.size;
    _myImageView.frame = CGRectMake(0, kImageTop, imageSize.width, imageSize.height);
    _myImageView.center =  CGPointMake(CGRectGetWidth(self.bounds)/2.0, _myImageView.center.y) ;
    
    [_titilLable sizeToFit];
    _titilLable.frame = CGRectMake(0, CGRectGetMaxY(_myImageView.frame) + kImage_Title_Space, _titilLable.frame.size.width,_titilLable.font.lineHeight );// _titilLable.font.lineHeight;
    _titilLable.center =  CGPointMake(CGRectGetWidth(self.bounds)/2.0, _titilLable.center.y);

}

- (void)didSelectObject{
    if ([self.barDelegate respondsToSelector:@selector(didSelectObject:)]){
        [self.barDelegate didSelectObject:self];
    }
}

- (void)handleDoubleTap{
    if ([self.barDelegate respondsToSelector:@selector(myTabbarDoubleClicked:)]) {
        [self.barDelegate myTabbarDoubleClicked:self];
    }
}

@end
