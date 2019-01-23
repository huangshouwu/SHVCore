//
//  SVHPageView.m
//  LookUpInfo
//
//  Created by flaginfo-mac1 on 13-1-31.
//  Copyright (c) 2013年 flaginfo-mac1. All rights reserved.
//

struct PageViewBeginDragingSet {
    CGFloat offsetX;
    BOOL fromDraging;
};

struct floatValueParts{
    long long intPart;
    double floatPart;
};

struct floatValueParts floatPart(double value){
    
    struct floatValueParts parts;
    long long intPart = (long long)value;
    double floatPart = value - intPart;
    
    parts.intPart = intPart;
    parts.floatPart = floatPart;
    return parts;
}

#import "SVHPageView.h"
//#import "UIScrollView+NOEEEnableEdgeGesture.h"

@interface SVHPageView (){
    CGPoint _beginDragingOffset;//开始拖动时候的点
    struct PageViewBeginDragingSet dragingSet;
}
@property (assign, nonatomic) NSInteger totalPages;

@end

@implementation SVHPageView
@synthesize pageDataSource,pageDelegate;

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}     

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        _totalPages = 0;
        _centerPageIndex = 0;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setPageContentSize];
    [self.centerPage setHeight:self.height];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setNeedsLayout];
}

- (void)reloadView{
    [self moveToPageAtIndex:_centerPageIndex animated:YES];
}

- (void)setPageContentSize {
    if ([self.pageDataSource respondsToSelector:@selector(numberOfPagesInPageView:)]){
         _totalPages = [self.pageDataSource numberOfPagesInPageView:self];
        //如果page数量为零，则默认为一页；
        if (_totalPages <= 0){
            _totalPages =1;
        }
    }else{
        _totalPages = 1;
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width * _totalPages,self.frame.size.height);
}

- (void)moveToPageAtIndex:(NSUInteger)pageIndex animated:(BOOL)animated{
    _totalPages = [self.pageDataSource numberOfPagesInPageView:self];
    //pageIndex从0开始
    if (pageIndex < _totalPages){
        
        //在滑动前通知委托
        if ([self.pageDelegate respondsToSelector:@selector(pageView:willMoveToPage:)]){
            [self.pageDelegate pageView:self willMoveToPage:pageIndex];
        }
        
        if (_centerPageIndex == pageIndex) {
            [self setVisiblePagesAtCenterIndex:pageIndex];
            [self addSubview:_centerPage];
            if ([self.pageDelegate respondsToSelector:@selector(pageView:didMoveToPage:)]){
                [self.pageDelegate pageView:self didMoveToPage:pageIndex];
            }
        }else {
            [self setVisiblePagesAtCenterIndex:pageIndex];
            [self addSubview:_centerPage];
            [self scrollRectToVisible:_centerPage.frame animated:animated];
        }
    }else {
        GJTLog(@"指定页面%lu无效！",(unsigned long)pageIndex);
    }
}

- (UIView*)pageAtIndex:(NSUInteger)pageIndex{
    if ([self.pageDataSource respondsToSelector:@selector(contentViewInPageView:atPageIndex:)]){
        return [self.pageDataSource contentViewInPageView:self atPageIndex:pageIndex];
    }else{
        return nil;
    }
}

- (void)setVisiblePagesAtCenterIndex:(NSUInteger)centerIndex{
    CGSize pageSize;
    //如果委托实现了pagesize，则使用委托的size，如果没有则用scrollview本身的宽和高
    if ([self.pageDataSource respondsToSelector:@selector(sizeForPage:InPageView:)]){
        pageSize = [self.pageDataSource sizeForPage:centerIndex InPageView:self];
    }else{
        pageSize = CGSizeMake(self.width, self.height);
    }
    
    [self setPageContentSize];/* 重新计算scrollView的contentSize */
    CGRect centerPageFrame = CGRectMake(self.frame.size.width*centerIndex, 0, pageSize.width, pageSize.height);
    
    _centerPageIndex = centerIndex;
    _centerPage = [self pageAtIndex:centerIndex];
    [_centerPage setFrame:centerPageFrame];
    [self addSubview:_centerPage];
    
    _nextPage = [self pageAtIndex:centerIndex+1];
    
    _forwordPage = [self pageAtIndex:centerIndex-1];
    
    if (_nextPage){
        _nextPage.frame = CGRectMake(self.frame.size.width*(centerIndex+1), 0, centerPageFrame.size.width, centerPageFrame.size.height);
        [self addSubview:_nextPage];
    }
    if (_forwordPage){
        _forwordPage.frame = CGRectMake(self.frame.size.width*(centerIndex-1), 0, centerPageFrame.size.width, centerPageFrame.size.height);
        [self addSubview:_forwordPage];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    dragingSet.fromDraging = YES;
    dragingSet.offsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageView:didScrollPageOffset:)]) {
        [self.pageDelegate pageView:self didScrollPageOffset:CGPointMake(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds), 0)];
    }
    CGFloat contentX = scrollView.contentOffset.x;
    NSInteger rest = (long long)contentX % ((long long)scrollView.width);
    NSInteger index = (long long)contentX / ((long long)scrollView.width);
    
    //边缘回调触发
    if (self.bounces) {//bounecs 为YES是边缘出发在 scrollViewDidScroll: 里
        NSUInteger pageCount = [self.pageDataSource numberOfPagesInPageView:self];
        if (index == pageCount -1 && rest >= 100) {
            [self performRightEdgeSelector];
        }else if (index == 0 && rest <= -100){
            [self performRightEdgeSelector];
        }
    }
    
    //滚动到对应页面触发
    //分离出浮点的小数和整数部分
    struct floatValueParts parts = floatPart(contentX);
    if (rest == 0&&parts.floatPart==0.0f) {
        [self scrolledToPageAtIndex:index];
    }
}

- (void)scrolledToPageAtIndex:(NSInteger)index{
    [self setVisiblePagesAtCenterIndex:index];
    if ([self.pageDelegate respondsToSelector:@selector(pageView:didMoveToPage:)]){
        [self.pageDelegate pageView:self didMoveToPage:index];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (!self.bounces) {//bounecs 为NO是边缘出发在 scrollViewWillEndDragging:withVelocity:targetContentOffset: 里
        NSUInteger pageCount = [self.pageDataSource numberOfPagesInPageView:self];
        if (velocity.x > 0 && self.centerPageIndex == (pageCount -1)) {//大于0表示向右滑 小于0向左滑
            if (targetContentOffset->x == CGRectGetWidth(self.bounds)*(pageCount - 1)) {
                [self performRightEdgeSelector];
            }
        }else if (velocity.x < 0 && self.centerPageIndex == 0){
            if (targetContentOffset->x == 0) {
                [self performLeftEdgeSelector];
            }
        }
    }
}

- (void)performLeftEdgeSelector{
    if (((self.enableEdge | NOEESVHPageViewEdgeSideLeft) == NOEESVHPageViewEdgeSideLeft) && self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageView:edgeSidePulled:)]) {
        [self.pageDelegate pageView:self edgeSidePulled:NOEESVHPageViewEdgeSideLeft];
    }
}

- (void)performRightEdgeSelector{
    if (((self.enableEdge | NOEESVHPageViewEdgeSideRight) == NOEESVHPageViewEdgeSideRight) &&  self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageView:edgeSidePulled:)]) {
        [self.pageDelegate pageView:self edgeSidePulled:NOEESVHPageViewEdgeSideRight];
    }
}

- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    [self sendSubviewToBack:view];
}

@end
