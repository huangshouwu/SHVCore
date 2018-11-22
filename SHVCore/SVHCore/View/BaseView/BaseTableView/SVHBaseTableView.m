//
//  SVHBaseTableView.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "SVHBaseTableView.h"
#import <objc/runtime.h>
#import "SVHBaseCellItem.h"
#import "SVHBaseCell.h"

@implementation SVHBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style showDragView:(BOOL)showDragView
{
    if (self = [super initWithFrame:frame]) {
        _items = [[NSMutableArray alloc] initWithCapacity:0];
        _sections = [[NSMutableArray alloc] initWithCapacity:0];
        
        _tableView = [[SVHRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:style];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showRefreshView = showDragView;
        __weak typeof(self) bself = self;
        if (_tableView.showRefreshView) {
            _tableView.startRefreshBlock = ^(SVHRefreshTableView *resreshTableView) {
                [bself willStartDragRefresh];
            };
        }
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        _tableView.isAdjustContentInset = NO;
        [self addSubview:_tableView];
        
        _gapViewSuperView = _tableView;
    }
    return self;
}

- (void)willStartDragRefresh{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewWillStartDragRefresh:)]) {
        [self.delegate tableViewWillStartDragRefresh:self];
    }
}

- (void)reloadData{
    [self.tableView reloadData];
}

/** 清空列表 */
- (void)clearAllData{
    [self.items removeAllObjects];
    [self.sections removeAllObjects];
    [self reloadData];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)autoLoadingWithAnimation{
    [self.tableView autoLoadingWithAnimation];
}

- (void)endRefreshSuccess:(BOOL)success{
    [self.tableView endRefreshSuccess:success];
}

#pragma mark - OutSide calls
- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.sections.count>0){
        if (indexPath.section<_sections.count){
            if (indexPath.row<[[_items objectAtIndex:indexPath.section] count]){
                return [[_items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            }else{
                return nil;
            }
        }else {
            return nil;
        }
    }else {
        if (indexPath.row < _items.count) {
            return [_items objectAtIndex:indexPath.row];
        } else {
            return nil;
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count>0?_sections.count:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sections.count>0?[[_items objectAtIndex:section] count]:_items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVHBaseCellItem* object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    if (!object ||![object isKindOfClass:[SVHBaseCellItem class]]){
//        NOEEDPRINT(@"item 已经不存在了!!");
        return nil;
    }
    [object setIndexPath:indexPath];
    
    Class cellClass = [object cellClass];
    const char* className = class_getName(cellClass);
    NSString* identifier = [[NSString alloc] initWithBytesNoCopy:(char*)className
                                                          length:strlen(className)
                                                        encoding:NSASCIIStringEncoding freeWhenDone:NO];
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:identifier];
    }
    if ([cell isKindOfClass:[SVHBaseCell class]]) {
        [(SVHBaseCell*)cell setItem:object];
    }
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_sections.count==0){
        return nil;
    }else{
        return [_sections objectAtIndex:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SVHBaseCellItem* object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [object cellClass];
    CGFloat rowHeight = [cellClass tableView:tableView rowHeightForItem:object];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        CGFloat height = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
        if (height > 0) {
            rowHeight = height;
        }
    }
    
    return rowHeight;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_sections.count > 0){
        if (indexPath.section<_sections.count){
            if (indexPath.row<[[_items objectAtIndex:indexPath.section] count]){
                [self tableView:tableView performActionAtIndexPath:indexPath];
            }
        }
    }else {
        if (indexPath.row<_items.count){
            [self tableView:tableView performActionAtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView performActionAtIndexPath:(NSIndexPath*)indexPath{
    SVHBaseCellItem* object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(didSelectObject:atIndexPath:)]){
        [self performSelector:@selector(didSelectObject:atIndexPath:) withObject:object withObject:indexPath];
    }
}

- (void)didSelectObject:(SVHBaseCellItem *)object atIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectObject:atIndexPath:)]) {
        [self.delegate tableView:self didSelectObject:object atIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    
    if (tableView.style == UITableViewStyleGrouped) {
        
        CGFloat footerHeight = 0;
        if (section !=0) {
            footerHeight = 5;
        }
        
        if (self.sections.count>0) {
            if ([self.sections[section] length]>0) {
                return 20-footerHeight;
            }else {
                return 10-footerHeight;
            }
        }else {
            return 10-footerHeight;
        }
        
    }else {
        if (self.sections.count>0) {
            if ([self.sections[section] length]>0) {
                return 20;
            }else {
                return 0;
            }
        }else {
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
       return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    
    if (tableView.style == UITableViewStyleGrouped) {
        return 5;
    }else {
        return 0;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didEndDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
#pragma mark -

@end
