//
//  NOEELoadingGapView.m
//  Lottery
//
//  Created by hsw on 15/12/16.
//  Copyright © 2015年 MacPro1. All rights reserved.
//

#import "NOEELoadingGapView.h"
#import "GJTCommonTool.h"
#import "GJTUIViewAdditions.h"

@interface NOEELoadingGapView (){
    NOEELoadingFailView* _contentView;
}

@property (nonatomic,strong,readwrite)UIActivityIndicatorView* loadingView;

@end

@implementation NOEELoadingGapView

- (void)dealloc{
    [_contentView removeFromSuperview];
    [_loadingView removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView = [[NOEELoadingFailView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView.reloadButton addTarget:self action:@selector(failViewButtonTaped) forControlEvents:UIControlEventTouchUpInside];
//        _contentView.layer.borderWidth = 1.0f;
//        _contentView.layer.borderColor = UIColor.blueColor.CGColor;
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        _loadingView.hidesWhenStopped = YES;
        _loadingView.color = [UIColor orangeColor];
        
        [self addSubview:_contentView];
        [self addSubview:_loadingView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.contentViewCenterY = CGRectGetHeight(self.bounds)/2;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.contentViewCenterY == 0) {
        self.contentViewCenterY = CGRectGetHeight(self.bounds)/2;
    }
    
    if (self.style == NOEELoadingGapViewStyleLoading) {
        _loadingView.hidden = NO;
        _contentView.hidden = YES;
        
        /** 如果外部不指定loadingView的frame 则自动调整到剧中 */
//        if (CGRectEqualToRect(_loadingView.frame, CGRectZero)) {
            _loadingView.frame = CGRectMake(0, 0, 30, 30);
            _loadingView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        [_loadingView startAnimating];
//        }
    }else {
        [_loadingView stopAnimating];
        _loadingView.hidden = YES;
        _contentView.hidden = NO;
        
//        CGFloat failViewHeight = [_contentView viewHeightForShowReloadButton:(self.style == NOEELoadingGapViewStyleLoadFail || self.style == NOEELoadingGapViewStyleLoadFailNoImage)?YES:NO];
        _contentView.frame = self.bounds;//CGRectMake(0, self.contentViewCenterY - failViewHeight/2, CGRectGetWidth(self.bounds), failViewHeight);
//        _loadingView.centerY = 
    }
}

- (void)failViewButtonTaped{
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

- (void)failViewTaped{
    NSLog(@"failViewTaped!");
}

- (void)setStyle:(NOEELoadingGapViewStyle)style{
    _style = style;
    switch (style) {
        case NOEELoadingGapViewStyleLoadFail:
            _contentView.needShowReloadButton = YES;
            _contentView.imageView.image = GJTResourceImageWithName(@"NOEELoadLQView");
            _contentView.textLabel.text  = @"网络环境不佳，请稍候重试";
            break;
            break;
        case NOEELoadingGapViewStyleLoadFailNoImage:
            _contentView.needShowReloadButton = YES;
            _contentView.imageView.image = nil;
            _contentView.textLabel.text  = @"网络环境不佳，请稍候重试";
            break;
        case NOEELoadingGapViewStyleLoading:
            break;
        case NOEELoadingGapViewStyleNoData:
            _contentView.needShowReloadButton = self.reloadBlock?YES:NO;
            _contentView.imageView.image = GJTResourceImageWithName(@"NOEENoUpDate");
            _contentView.textLabel.text  = @"暂无数据哟～";
            break;
        case NOEELoadingGapViewStyleNoDataNoImage:
            _contentView.needShowReloadButton = self.reloadBlock?YES:NO;
            _contentView.imageView.image = nil;
            _contentView.textLabel.text  = @"暂无数据哟～";
            break;
        case NOEELoadingGapViewStyleNotConnectedToInternet:
            _contentView.needShowReloadButton = NO;
            _contentView.imageView.image = GJTResourceImageWithName(@"NOEENotConnectedToInternet");
            _contentView.textLabel.text  = @"当前网络不可用，请检查网络连接～";
            break;
        case NOEELoadingGapViewStyleNotConnectedToInternetNoImage:
            _contentView.needShowReloadButton = NO;
            _contentView.imageView.image = nil;
            _contentView.textLabel.text  = @"当前网络不可用，请检查网络连接～";
            break;
        default:
            break;
    }
    [self setNeedsLayout];
}

- (void)setContentViewCenterY:(CGFloat)contentViewCenterY{
    _contentViewCenterY = contentViewCenterY;
//    [self setNeedsLayout];
}

@end

//static CGFloat const NOEELoadingFailView_imageViewHeight            = 85;
static CGFloat const NOEELoadingFailView_textlabelHeight            = 15;
static CGFloat const NOEELoadingFailView_imageView_textLabel_gap    = 15;
static CGFloat const NOEELoadingFailView_textLabel_reloadButton_gap = 25;
static CGSize  const NOEELoadingFailView_reloadButtonSize           = {145.0f,37.0f};

@implementation NOEELoadingFailView

- (CGFloat)viewHeightForShowReloadButton:(BOOL)showReloadButton{
    CGFloat viewHeight = _imageView.image.size.height + NOEELoadingFailView_imageView_textLabel_gap + NOEELoadingFailView_textlabelHeight;
    if (showReloadButton) {
        viewHeight += NOEELoadingFailView_textLabel_reloadButton_gap + NOEELoadingFailView_reloadButtonSize.height;
    }
    return viewHeight;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor* colorForView = GJTColorForHex(@"#9d9d9d");
        _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _reloadButton.backgroundColor = [UIColor clearColor];
        _reloadButton.layer.borderColor = [colorForView CGColor];
        _reloadButton.layer.borderWidth = 1.0f;
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:colorForView forState:UIControlStateNormal];
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _reloadButton.layer.cornerRadius = 4.0f;
        [_reloadButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.numberOfLines = 0;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont systemFontOfSize:15];
        UIColor* textColor = [UIColor darkGrayColor];//[UIColor colorWithRed:207/255.0f green:207/255.0f blue:207/255.0f alpha:1];
        _textLabel.textColor = textColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_reloadButton];
        [self addSubview:_imageView];
        [self addSubview:_textLabel];
        
        if (CGRectEqualToRect(frame, CGRectZero)) {
            [self setFrame:frame];
        }
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - _imageView.image.size.width)/2, 0, _imageView.image.size.width, _imageView.image.size.height);
    if (_imageView.image) {
        _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame) + NOEELoadingFailView_imageView_textLabel_gap, CGRectGetWidth(self.bounds), NOEELoadingFailView_textlabelHeight * 2);
    }else {
        _textLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), NOEELoadingFailView_textlabelHeight * 2);
    }
    
    [_textLabel sizeToFit];
    _reloadButton.hidden = !self.needShowReloadButton;
    if (self.needShowReloadButton) {
        _reloadButton.frame = CGRectMake((CGRectGetWidth(self.bounds) - NOEELoadingFailView_reloadButtonSize.width)/2, CGRectGetMaxY(_textLabel.frame) + NOEELoadingFailView_textLabel_reloadButton_gap, NOEELoadingFailView_reloadButtonSize.width, NOEELoadingFailView_reloadButtonSize.height);
    }else {
        _reloadButton.frame = CGRectZero;
    }
    
    
    /////////调整控件位置////////
    CGFloat contentHeight = 0;
    if (_imageView.image) {
        contentHeight += _imageView.image.size.height + NOEELoadingFailView_imageView_textLabel_gap;
    }
    contentHeight += _textLabel.height;
    if (self.needShowReloadButton) {
        contentHeight += NOEELoadingFailView_reloadButtonSize.height + NOEELoadingFailView_textLabel_reloadButton_gap;
    }
    
    if (_imageView.image) {
        _imageView.top = (self.height - contentHeight)/2;
        _textLabel.top = _imageView.bottom + NOEELoadingFailView_imageView_textLabel_gap;
    }else {
        _textLabel.top = (self.height - contentHeight)/2;
    }
    if (self.needShowReloadButton){
        _reloadButton.top = _textLabel.bottom + NOEELoadingFailView_textLabel_reloadButton_gap;
    }
    
    _textLabel.center = CGPointMake((CGRectGetWidth(self.bounds)) / 2, _textLabel.center.y);
}

@end
