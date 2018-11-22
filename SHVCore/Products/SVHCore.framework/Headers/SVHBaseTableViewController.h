//
//  SVHBaseTableViewController.h
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "SVHBaseViewController.h"
#import "SVHBaseTableView.h"

@interface SVHBaseTableViewController : SVHBaseViewController <SVHBaseTableViewDelegate>

@property (nonatomic,strong)SVHBaseTableView* tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
