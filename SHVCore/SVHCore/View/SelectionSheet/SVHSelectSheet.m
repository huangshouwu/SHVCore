//
//  GJTProjectSettingSelectAlert.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHSelectSheet.h"
#import "SVHBaseTableView.h"
#import "SVHUIViewAdditions.h"
#import "SVHCommonTool.h"

//CGFloat static SVHSelectSheetMaxHeight = 440;//最小1行
//CGFloat static SVHSelectSheetMinHeight = 80;//最大10行

@interface SVHSelectSheet ()<SVHBaseTableViewDelegate>{
    SVHBaseTableView* _tableView;
}

@end

@implementation SVHSelectSheet

+ (void)showInView:(UIView*)view
             title:(NSString*)title
           allList:(NSArray <SVHSelectCellItem *>*)allListArray
singleSelectionOnly:(BOOL)singleSelectionOnly
     finishedBlock:(SVHSelectSheetBlock)finishedBlock{
    if (allListArray.count>0) {
        SVHSelectSheet* sheet = [[SVHSelectSheet alloc] initWithFrame:CGRectMake(0, 0, view.width, [SVHSelectSheet cellHeightForItem:allListArray.firstObject])];
        sheet.listArray = allListArray;
        sheet.toolBar.titleLabel.text = title;
        sheet.singleSelectionOnly = singleSelectionOnly;
        sheet.finishedBlock = finishedBlock;
        [sheet showInView:view];
    }
}

+ (void)showInView:(UIView*)view
           allList:(NSArray <SVHSelectCellItem *>*)allListArray
     finishedBlock:(SVHSelectSheetBlock)finishedBlock{
    if (allListArray.count > 0) {
        SVHSelectSheet* sheet = [[SVHSelectSheet alloc] initWithFrame:CGRectMake(0, 0, view.width, [SVHSelectSheet cellHeightForItem:allListArray.firstObject])];
        sheet.listArray = allListArray;
        sheet.toolBar.titleLabel.text = nil;
        sheet.singleSelectionOnly = YES;
        sheet.showToolBar = NO;
        sheet.finishedBlock = finishedBlock;
        [sheet showInView:view];
    }
}

+ (CGFloat)cellHeightForItem:(SVHSelectCellItem*)item{
    return [SVHSelectCell tableView:nil rowHeightForItem:item];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _showToolBar = YES;
        _toolBar = [[SVHToolBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, [SVHToolBar viewHeight])];
        [_toolBar.button1 addTarget:self action:@selector(cancleButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar.button2 addTarget:self action:@selector(sureButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        _tableView = [[SVHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain showDragView:NO];
       SVHClearExtendCellLineForTableView(_tableView.tableView);
        _tableView.delegate = self;
        [self addSubview:_toolBar];
        [self addSubview:_tableView];
        self.backgroundColor = UIColor.whiteColor;
        
        _selectedArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)setShowToolBar:(BOOL)showToolBar{
    _showToolBar = showToolBar;
    self.toolBar.hidden = !_showToolBar;
    [self setNeedsLayout];
}

- (void)setListArray:(NSArray<SVHSelectCellItem *> *)listArray{
    if (listArray.count) {
        _listArray = listArray;
        [_tableView.items removeAllObjects];
        [_selectedArray removeAllObjects];
        [_tableView.items addObjectsFromArray:_listArray];
        [self setNeedsLayout];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setSubViewFrame];
}

- (void)removeCancelAction{
    [_toolBar.button1 removeTarget:self action:@selector(cancleButtonTaped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)removeSureAction{
    [_toolBar.button2 removeTarget:self action:@selector(sureButtonTaped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSingleSelectionOnly:(BOOL)singleSelectionOnly{
    _singleSelectionOnly = singleSelectionOnly;
    _toolBar.button1.hidden = singleSelectionOnly;
    _toolBar.button2.hidden = singleSelectionOnly;
}

- (void)setSubViewFrame{
    if (self.showToolBar) {
        _toolBar.frame = CGRectMake(0, 0, self.width, [SVHToolBar viewHeight]);
    }else {
        _toolBar.frame = CGRectZero;
    }
    _tableView.frame = CGRectMake(0, _toolBar.bottom, self.width, self.height - _toolBar.bottom - GJTBottomSafeMargin);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setSubViewFrame];
}

- (void)resetSelfHeight{
    CGFloat viewHeight = self.height;
    CGFloat oneCellHeight = [SVHSelectSheet cellHeightForItem:self.listArray.firstObject];
    
    CGFloat tableViewHegiht = oneCellHeight*self.listArray.count;
    CGFloat toolBarHeight = self.showToolBar?[SVHToolBar viewHeight]:0;
    
    CGFloat minHeight = oneCellHeight;
    CGFloat maxHeight = oneCellHeight*10;
    if (tableViewHegiht > maxHeight - toolBarHeight) {
        viewHeight = maxHeight;
    }else if (tableViewHegiht < minHeight - toolBarHeight) {
        viewHeight = minHeight;
    }else {
        viewHeight = tableViewHegiht + toolBarHeight;
    }
    viewHeight += GJTBottomSafeMargin;
    
    self.height = viewHeight;
}

- (void)showInView:(UIView*)view{
    
    if (self.listArray.count == 0) {
        GJTLog(@"list array is not be nil!");
        return;
    }
    
    self.top = view.bottom;
    [self resetSelfHeight];
    
    [_tableView reloadData];
    [view showViewWithBackView:self
                         alpha:0.3
                        target:self
                   touchAction:@selector(hide)
                     animation:^{
                         self.top = view.height - self.height;
    }
                  timeInterval:0.3
                     fininshed:nil];
}

- (void)hide{
    [self.superview hideBackViewForView:self animation:^{
        self.top = self.superview.bottom;
    } timeInterval:0.3 fininshed:^(BOOL complation){
        
    }];
}

- (void)tableView:(SVHBaseTableView *)tableView didSelectObject:(GJTBaseCellItem *)object atIndexPath:(NSIndexPath *)indexPath{
    if (self.singleSelectionOnly) {
        [self cancleAllSelected];
    }
    SVHSelectCellItem* item = (SVHSelectCellItem*)object;
    item.selected = !item.selected;
    [_selectedArray addObject:item];
    [tableView reloadData];
    if (self.singleSelectionOnly) {
        [self hide];
        if (self.finishedBlock) {
            self.finishedBlock(self, _selectedArray);
        }
    }
}

- (void)cancleAllSelected{
    for (SVHSelectCellItem* item in self.listArray) {
        item.selected = NO;
    }
    [_selectedArray removeAllObjects];
    [_tableView reloadData];
}

- (void)cancleButtonTaped{
    [self hide];
}

- (void)sureButtonTaped{
    if (self.finishedBlock) {
        [self reFillSelectedArray];
        self.finishedBlock(self, _selectedArray);
    }
    [self hide];
}

- (void)reFillSelectedArray{
    [_selectedArray removeAllObjects];
    for (SVHSelectCellItem* item in _listArray) {
        if (item.selected) {
            [_selectedArray addObject:item];
        }
    }
}

@end
