//
//  SVHBaseTextField.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "SVHBaseTextField.h"

@implementation SVHBaseTextField

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    SVHADDBorderLine(self, self.borderColor, self.borderStyle, self.borderWidth, self.corner,self.cornerSize);
}

@end
