//
//  GJTToolBar.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "GJTBaseView.h"
#import "GJTBaseButton.h"

@interface GJTToolBar : GJTBaseView

+ (CGFloat)viewHeight;

@property (nonatomic,strong)GJTBaseButton* button1;
@property (nonatomic,strong)GJTBaseButton* button2;
@property (nonatomic,strong)UILabel* titleLabel;

@end
