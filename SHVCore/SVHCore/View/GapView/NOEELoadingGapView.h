//
//  NOEELoadingGapView.h
//  Lottery
//
//  Created by hsw on 15/12/16.
//  Copyright © 2015年 9188-MacPro1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOEELoadingFailView;

typedef NS_ENUM(NSInteger, NOEELoadingGapViewStyle){
    NOEELoadingGapViewStyleNoData,
    NOEELoadingGapViewStyleNoDataNoImage,
    NOEELoadingGapViewStyleLoadFail,
    NOEELoadingGapViewStyleLoadFailNoImage,
    NOEELoadingGapViewStyleLoading,
    NOEELoadingGapViewStyleNotConnectedToInternet,
    NOEELoadingGapViewStyleNotConnectedToInternetNoImage
};

@interface NOEELoadingGapView : UIControl

typedef void(^NOEELoadingGapViewReloadBlock)(void);

@property (nonatomic)NOEELoadingGapViewStyle style;
@property (nonatomic,copy)NOEELoadingGapViewReloadBlock reloadBlock;
@property (nonatomic)CGFloat contentViewCenterY;
@property (nonatomic,strong,readonly)UIActivityIndicatorView* loadingView;
@property (nonatomic,readonly)NOEELoadingFailView* contentView;

@end

@interface NOEELoadingFailView : UIView

- (CGFloat)viewHeightForShowReloadButton:(BOOL)showReloadButton;

@property (nonatomic)BOOL                         needShowReloadButton;/* 是否需要显示重新加载按钮 */
@property (nonatomic,strong,readonly)UIButton     *reloadButton;
@property (nonatomic,strong,readonly)UIImageView  *imageView;
@property (nonatomic,strong,readonly)UILabel      *textLabel;

@end
