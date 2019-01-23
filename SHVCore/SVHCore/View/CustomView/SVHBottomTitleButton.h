//
//  SVHBottomTitleButton.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHMutableLabel.h"

@interface SVHBottomTitleButton : SVHBaseButton

//- (CGFloat)viewHeight;

@property (nonatomic,strong)UIImageView* centerImageView;
@property (nonatomic,strong)UILabel* centerLabel;
@property (nonatomic,strong)UIImageView* contentView;
@property (nonatomic,strong)SVHMutableLabel* bottomLabel;
@property (nonatomic,assign)BOOL showBottomLeftDot;
@property (nonatomic,strong)UIView* bottomLeftDot;
@property (nonatomic,assign)CGFloat bottomLabelSpaceToContentView;/* 底部label与contentView 间距*/
@property (nonatomic,assign)CGFloat contentView_topInset;

/** 设置contentView的宽高 */
- (void)setContentViewSize:(CGSize)size;

@end
