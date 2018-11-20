//
//  GJTBaseButton.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseButton.h"

@implementation GJTBaseButton

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    GJTADDBorderLine(self, self.borderColor, self.borderStyle, self.borderWidth, self.corner,self.cornerSize);
}

@end
