//
//  SVHToolBar.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHBaseView.h"
#import "SVHBaseButton.h"

@interface SVHToolBar : SVHBaseView

+ (CGFloat)viewHeight;

@property (nonatomic,strong)SVHBaseButton* button1;
@property (nonatomic,strong)SVHBaseButton* button2;
@property (nonatomic,strong)UILabel* titleLabel;

@end
