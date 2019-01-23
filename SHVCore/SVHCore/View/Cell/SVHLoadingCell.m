//
//  SVHLoadingCell.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/20.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHLoadingCell.h"

@interface SVHLoadingCell (){
    UIActivityIndicatorView* _loadingView;
    GJTBaseButton* _reloadButton;
}
@end

@implementation SVHLoadingCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForItem:(SVHBaseCellItem *)item{
    return 40.0f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
        
        _reloadButton = [GJTBaseButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.backgroundColor = GJTColorForHex(@"#FFFAFA");
        _reloadButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _reloadButton.layer.borderWidth = 1.0f/GJTScreenScale();
        _reloadButton.layer.cornerRadius = 5.0f;
        _reloadButton.layer.masksToBounds = YES;
        [_reloadButton setTitle:@"加载失败，点击重试" forState:UIControlStateNormal];
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_reloadButton setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_loadingView];
        [self.contentView addSubview:_reloadButton];
    }
    return self;
}

- (void)setItem:(SVHBaseCellItem *)item{
    [super setItem:item];
    SVHLoadingCellItem* obj = (SVHLoadingCellItem*)item;
    if (obj.loadingState == SVHLoadingStateLoading) {
        [_loadingView startAnimating];
        _reloadButton.hidden = YES;
    }else if (obj.loadingState == SVHLoadingStateFail){
        _reloadButton.hidden = NO;
        _loadingView.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _loadingView.frame = CGRectMake(0, 0, 30, 30);
    _reloadButton.frame = CGRectMake(20, 0, self.contentView.width - 40, self.contentView.height - 10);
    _loadingView.center = _reloadButton.center = CGPointMake(self.contentView.width/2, self.contentView.height/2);

}

- (void)reloadButtonTaped{
    SVHLoadingCellItem* obj = (SVHLoadingCellItem*)_item;
    if (obj.reloadBlock) {
        obj.reloadBlock(self);
    }
}

@end

@implementation SVHLoadingCellItem

- (instancetype)init{
    if (self = [super init]) {
        self.loadingState = SVHLoadingStateLoading;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (Class)cellClass{
    return [SVHLoadingCell class];
}
@end
