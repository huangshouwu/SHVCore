//
//  SVHBaseCellItem.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "SVHBaseItem.h"
#import <UIKit/UIKit.h>

@class SVHBaseCell;

@interface SVHBaseCellItem : SVHBaseItem<NSCopying>

/** item对应的cell类 */
- (Class)cellClass;

/** 值是否改变 */
- (BOOL)valueChangedToItem:(SVHBaseCellItem*)item;

@property (nonatomic)UITableViewCellAccessoryType accessoryType;
@property (nonatomic)UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic,strong)NSIndexPath* indexPath;

@end
