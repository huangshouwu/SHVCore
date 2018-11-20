//
//  GJTBaseCell.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJTBaseCellItem;

@interface GJTBaseCell : UITableViewCell{
    @public
    GJTBaseCellItem* _item;
}

@property (nonatomic ,strong)GJTBaseCellItem* item;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(GJTBaseCellItem*)item;

@end
