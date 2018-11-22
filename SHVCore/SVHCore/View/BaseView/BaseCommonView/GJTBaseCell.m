//
//  GJTBaseCell.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseCell.h"
#import "UIView+GJTBorderProperty.h"
#import "GJTBaseCellItem.h"

@implementation GJTBaseCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(GJTBaseCellItem*)item{
    return 40;
}

- (void)setItem:(GJTBaseCellItem *)item{
    _item = item;
    self.selectionStyle = item.selectionStyle;
    self.accessoryType = item.accessoryType;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    GJTADDBorderLine(self, self.borderColor, self.borderStyle, self.borderWidth, self.corner,self.cornerSize);
}

@end
