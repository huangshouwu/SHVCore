//
//  GJTBaseTableViewController.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseTableViewController.h"

@interface GJTBaseTableViewController (){
    UITableViewStyle _tableViewStyle;
}

@end

@implementation GJTBaseTableViewController

- (void)dealloc{
    _tableView.delegate = nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableViewStyle = UITableViewStyleGrouped;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (GJTBaseTableView*)tableView{
    if (!_tableView) {
        _tableView = [[GJTBaseTableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle showDragView:YES];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    [super keyboardWillShow:notification];
    UIEdgeInsets inset = self.tableView.tableView.contentInset;
    inset.bottom = CGRectGetHeight(_keyboardBounds) + 5;
    __weak typeof(self) block_self = self;
    [UIView animateWithDuration:_keybardAnmiatedTimeinterval animations:^(void){
        block_self.tableView.tableView.contentInset = inset;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [super keyboardWillHide:notification];
    UIEdgeInsets inset = self.tableView.tableView.contentInset;
    inset.bottom = 0;
    __weak typeof(self) block_self = self;
    [UIView animateWithDuration:_keybardAnmiatedTimeinterval animations:^(void){
        block_self.tableView.tableView.contentInset = inset;
    }];
}

@end
