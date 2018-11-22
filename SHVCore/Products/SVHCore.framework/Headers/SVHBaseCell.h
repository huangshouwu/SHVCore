//
//  SVHBaseCell.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVHBaseCellItem;

@interface SVHBaseCell : UITableViewCell{
    @public
    SVHBaseCellItem* _item;
}

@property (nonatomic ,strong)SVHBaseCellItem* item;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(SVHBaseCellItem*)item;

@end
