//
//  GJTBaseTextField.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseTextField.h"

@implementation GJTBaseTextField

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    GJTADDBorderLine(self, self.borderColor, self.borderStyle, self.borderWidth, self.corner,self.cornerSize);
}

@end
