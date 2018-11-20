//
//  SRRefreshView.h
//  SlimeRefresh
//
//  A refresh view looks like UIRefreshControl
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSlimeView.h"

static CGFloat SR_SlimeView_Default_Height = 44.0f;

@class SRRefreshView;

typedef void (^SRRefreshBlock)(SRRefreshView* sender);

@protocol SRRefreshDelegate;


@interface SRRefreshView : UIView

// set the slime's style by this property.
@property (nonatomic, strong, readonly) SRSlimeView *slime;

// set your refresh icon.
@property (nonatomic, strong, readonly) UIImageView *refleshView;

// set activityIndicatorView propertys
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicatorView;

//select one to receive the refreshing message.
@property (nonatomic, strong)     SRRefreshBlock      block;
@property (nonatomic, weak)   id<SRRefreshDelegate>   delegate;

//set the state loading or not.
@property (nonatomic, assign)   BOOL    loading;

//default is false, if true when slime go back it will have a alpha effect to go to miss.
@property (nonatomic, assign)   BOOL    slimeMissWhenGoingBack;

// 
@property (nonatomic, assign)   CGFloat upInset;

- (void)setLoadingWithexpansion;

// send scrollView event here
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDraging;

// as the name, called when loading over.
- (void)endRefreshSuccess:(BOOL)success;

// init default is 32
- (id)initWithHeight:(CGFloat)height;

//拉断了
- (void)pullApart;

// 在iPhone X界面tableview如果从顶部开始,则为了不让刘海挡住刷新视图,将刷新视图像下偏移offset(22就好)个点.默认0
- (void)setRefleshViewOffSet:(CGFloat)offset;
@end

@protocol SRRefreshDelegate <NSObject>

@optional
//start refresh.
- (void)slimeRefreshStartRefresh:(SRRefreshView*)refreshView;

@end
