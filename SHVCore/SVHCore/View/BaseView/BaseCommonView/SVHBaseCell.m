//
//  SVHBaseCell.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "SVHBaseCell.h"
#import "UIView+SVHBorderProperty.h"
#import "SVHBaseCellItem.h"

@implementation SVHBaseCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(SVHBaseCellItem*)item{
    return 40;
}

- (void)setItem:(SVHBaseCellItem *)item{
    _item = item;
    self.selectionStyle = item.selectionStyle;
    self.accessoryType = item.accessoryType;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    SVHADDBorderLine(self, self.borderColor, self.borderStyle, self.borderWidth, self.corner,self.cornerSize);
}

@end
