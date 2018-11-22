//
//  SVHBaseTableView.h
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVHRefreshTableView.h"
#import "SVHBaseCellItem.h"

@class SVHBaseTableView;

@protocol SVHBaseTableViewDelegate <NSObject>
@optional
- (void)tableView:(SVHBaseTableView*)tableView didSelectObject:(SVHBaseCellItem*)object atIndexPath:(NSIndexPath*)indexPath;

- (void)tableViewWillStartDragRefresh:(SVHBaseTableView *)tableView;

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (CGFloat)tableView:(SVHBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didEndDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SVHBaseTableView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) SVHRefreshTableView *tableView;
@property (nonatomic ,strong) NSMutableArray *items;
@property (nonatomic ,strong) NSMutableArray<NSString *> *sections;
@property (nonatomic ,weak)   id<SVHBaseTableViewDelegate> delegate;

@property (nonatomic,weak) UIView *gapViewSuperView;  // 默认tableView

/** 自动下拉刷新 */
- (void)autoLoadingWithAnimation;

//结束下拉刷新，success为YES则显示“刷新成功”，NO显示“刷新失败”
- (void)endRefreshSuccess:(BOOL)success;

/** 指定初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style showDragView:(BOOL)showDragView;

/** 返回对应indexPath位置的item*/
- (SVHBaseCellItem*)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)reloadData;

/** 清空列表 */
- (void)clearAllData;

@end
