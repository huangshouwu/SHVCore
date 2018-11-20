//
//  GJTBaseTableView.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJTRefreshTableView.h"
#import "GJTBaseCellItem.h"

@class GJTBaseTableView;

@protocol GJTBaseTableViewDelegate <NSObject>
@optional
- (void)tableView:(GJTBaseTableView*)tableView didSelectObject:(GJTBaseCellItem*)object atIndexPath:(NSIndexPath*)indexPath;

- (void)tableViewWillStartDragRefresh:(GJTBaseTableView *)tableView;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (CGFloat)tableView:(GJTBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didEndDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GJTBaseTableView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) GJTRefreshTableView *tableView;
@property (nonatomic ,strong) NSMutableArray *items;
@property (nonatomic ,strong) NSMutableArray<NSString *> *sections;
@property (nonatomic ,weak)   id<GJTBaseTableViewDelegate> delegate;

@property (nonatomic,weak) UIView *gapViewSuperView;  // 默认tableView

/** 自动下拉刷新 */
- (void)autoLoadingWithAnimation;

//结束下拉刷新，success为YES则显示“刷新成功”，NO显示“刷新失败”
- (void)endRefreshSuccess:(BOOL)success;

/** 指定初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style showDragView:(BOOL)showDragView;

/** 返回对应indexPath位置的item*/
- (GJTBaseCellItem*)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)reloadData;

/** 清空列表 */
- (void)clearAllData;

@end
