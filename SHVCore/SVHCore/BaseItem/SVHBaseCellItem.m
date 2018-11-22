//
//  SVHBaseCellItem.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "SVHBaseCellItem.h"
#import "SVHBaseCell.h"

@implementation SVHBaseCellItem

- (instancetype)init{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

/** item对应的cell */
- (Class)cellClass{
    return [SVHBaseCell class];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    SVHBaseCellItem *item = [[SVHBaseCellItem allocWithZone:zone] init];
    item.selectionStyle = self.selectionStyle;
    item.accessoryType = self.accessoryType;
    item.indexPath = self.indexPath;
    return (item);
}

/** 值是否改变 */
- (BOOL)valueChangedToItem:(SVHBaseCellItem*)item{
    if (self != item) {
        return YES;
    }
    if (self.accessoryType != item.accessoryType) {
        return YES;
    }
    return NO;
}

@end
