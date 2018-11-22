//
//  SVHLoadingGapView.h
//  Lottery
//
//  Created by hsw on 15/12/16.
//  Copyright © 2015年 9188-MacPro1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVHLoadingFailView;

typedef NS_ENUM(NSInteger, SVHLoadingGapViewStyle){
    SVHLoadingGapViewStyleNoData,
    SVHLoadingGapViewStyleNoDataNoImage,
    SVHLoadingGapViewStyleLoadFail,
    SVHLoadingGapViewStyleLoadFailNoImage,
    SVHLoadingGapViewStyleLoading,
    SVHLoadingGapViewStyleNotConnectedToInternet,
    SVHLoadingGapViewStyleNotConnectedToInternetNoImage
};

@interface SVHLoadingGapView : UIControl

typedef void(^SVHLoadingGapViewReloadBlock)(void);

@property (nonatomic)SVHLoadingGapViewStyle style;
@property (nonatomic,copy)SVHLoadingGapViewReloadBlock reloadBlock;
@property (nonatomic)CGFloat contentViewCenterY;
@property (nonatomic,strong,readonly)UIActivityIndicatorView* loadingView;
@property (nonatomic,readonly)SVHLoadingFailView* contentView;

@end

@interface SVHLoadingFailView : UIView

- (CGFloat)viewHeightForShowReloadButton:(BOOL)showReloadButton;

@property (nonatomic)BOOL                         needShowReloadButton;/* 是否需要显示重新加载按钮 */
@property (nonatomic,strong,readonly)UIButton     *reloadButton;
@property (nonatomic,strong,readonly)UIImageView  *imageView;
@property (nonatomic,strong,readonly)UILabel      *textLabel;

@end
