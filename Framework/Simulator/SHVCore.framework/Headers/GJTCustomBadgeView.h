//
//  CustomBadge.h
//  SUBTest
//
//  Created by chinaPnr on 13-11-8.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOE_DEF_BADGE_NUMBER_MAX    99
#define NOE_DEF_BADGE_SIZE          30.0f

typedef NS_OPTIONS(NSUInteger, CustomBadgeType) {
    CustomBadgeTypeUnknow,  //未知
    CustomBadgeTypePoint,   //点
    CustomBadgeTypeNumber   //数字
};


@interface GJTCustomBadgeView : UIView

@property (strong, nonatomic, readonly) UIImageView *backgroundImgView;
@property (strong, nonatomic, readonly) UILabel *badgeLabel;

@property (assign, nonatomic) CustomBadgeType type;

@end
