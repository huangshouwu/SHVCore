//
//  SVHRefreshTableView.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRRefreshView.h"

@class SVHRefreshTableView;
typedef void (^RefreshTableViewDidStartRefreshBlock)(SVHRefreshTableView *resreshTableView);

@interface SVHRefreshTableView : UITableView

@property (strong, nonatomic, readonly) SRRefreshView *refreshView;
@property (strong, nonatomic) RefreshTableViewDidStartRefreshBlock startRefreshBlock;
@property (nonatomic) BOOL showRefreshView;

/** 是否自动调整ContentInset (默认YES) */
@property (nonatomic, assign) BOOL isAdjustContentInset;

/** 自动下拉刷新 */
- (void)autoLoadingWithAnimation;

//结束下拉刷新，success为YES则显示“刷新成功”，NO显示“刷新失败”
- (void)endRefreshSuccess:(BOOL)success;

@end
