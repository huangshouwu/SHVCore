//
//  GJTBaseTableViewController.h
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseViewController.h"
#import "GJTBaseTableView.h"

@interface GJTBaseTableViewController : GJTBaseViewController <GJTBaseTableViewDelegate>

@property (nonatomic,strong)GJTBaseTableView* tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
