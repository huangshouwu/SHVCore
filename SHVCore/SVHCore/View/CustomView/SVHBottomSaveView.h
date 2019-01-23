//
//  GJTBottomSaveView.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/4.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHBaseView.h"

@interface SVHBottomSaveView : SVHBaseView

+ (CGFloat)viewHeight;

@property (nonatomic,strong)SVHBaseButton* button1;
@property (nonatomic,strong)SVHBaseButton* button2;
@property (nonatomic,assign)BOOL showTwoButton;

@end
