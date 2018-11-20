//
//  GJTBaseCellItem.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseItem.h"
#import <UIKit/UIKit.h>

@class GJTBaseCell;

@interface GJTBaseCellItem : GJTBaseItem<NSCopying>

/** item对应的cell类 */
- (Class)cellClass;

/** 值是否改变 */
- (BOOL)valueChangedToItem:(GJTBaseCellItem*)item;

@property (nonatomic)UITableViewCellAccessoryType accessoryType;
@property (nonatomic)UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic,strong)NSIndexPath* indexPath;

@end
