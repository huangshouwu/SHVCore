//
//  GJTMutableLabel.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHBaseView.h"

@interface SVHMutableLabel : SVHBaseView

@property (nonatomic,strong)UIImageView* leftImageView;
@property (nonatomic,strong)UILabel* leftLabel;
@property (nonatomic,strong)UILabel* rightLabel;
@property (nonatomic,assign)BOOL supportMutableLines;

@property (nonatomic,assign)UIEdgeInsets contentEdgeInsets;
@property (nonatomic,assign)NSTextAlignment contentAlignment;

@property (nonatomic,assign)BOOL showLeftImageView;
@property (nonatomic,assign)BOOL leftImageViewShowCircleStyle;
@property (nonatomic,assign)CGFloat leftImageView_leftLabel_space;
@property (nonatomic,assign)CGFloat leftLabel_rightLabel_space;

- (void)setLeftLabelSize:(CGSize)leftLabelSize;
- (void)setRightLabelSize:(CGSize)rightLabelSize;
- (void)setLeftImageViewSize:(CGSize)leftImageViewSize;

@end
