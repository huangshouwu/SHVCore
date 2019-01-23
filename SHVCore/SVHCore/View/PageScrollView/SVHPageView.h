//
//  SVHPageView.h
//  LookUpInfo
//
//  Created by flaginfo-mac1 on 13-1-31.
//  Copyright (c) 2013年 flaginfo-mac1. All rights reserved.
//

@protocol SVHPageViewDelegate;
@protocol SVHPageViewDataSource;

typedef NS_ENUM(NSUInteger, NOEESVHPageViewEdgeSide){
    NOEESVHPageViewEdgeSideNone,
    NOEESVHPageViewEdgeSideLeft,
    NOEESVHPageViewEdgeSideRight,
    NOEESVHPageViewEdgeSideTop,
    NOEESVHPageViewEdgeSideBottom,
};

@interface SVHPageView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,weak)id<SVHPageViewDataSource> pageDataSource;
@property (nonatomic,weak)id<SVHPageViewDelegate> pageDelegate;

@property (nonatomic,readonly)NSUInteger centerPageIndex;
@property (weak, nonatomic, readonly)UIView* centerPage;
@property (weak, nonatomic, readonly)UIView* nextPage;
@property (weak, nonatomic, readonly)UIView* forwordPage;
@property (assign, nonatomic)NOEESVHPageViewEdgeSide enableEdge;

- (void)reloadView;

- (void)moveToPageAtIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end

@protocol SVHPageViewDelegate <NSObject>

@optional
- (void)pageView:(SVHPageView*)pageView willMoveToPage:(NSUInteger)pageIndex;
- (void)pageView:(SVHPageView*)pageView didMoveToPage:(NSUInteger)pageIndex;
- (void)pageView:(SVHPageView*)pageView didScrollPageOffset:(CGPoint)pageOffset;
- (void)pageViewLeftEdgePulled:(SVHPageView*)pageView;
- (void)pageViewRightEdgePulled:(SVHPageView*)pageView;
- (void)pageView:(SVHPageView*)pageView edgeSidePulled:(NOEESVHPageViewEdgeSide)edgeSide;
@end

@protocol SVHPageViewDataSource <NSObject>

@required
- (NSUInteger)numberOfPagesInPageView:(SVHPageView*)pageView;
/**
 *  所有返回的view必须被强引用
 *
 *  @param pageView
 *  @param pageIndex
 *
 *  @return
 */
- (UIView*)contentViewInPageView:(SVHPageView*)pageView atPageIndex:(NSUInteger)pageIndex;

@optional
- (CGSize)sizeForPage:(NSUInteger)pageIndex InPageView:(SVHPageView*)pageView;

@end
