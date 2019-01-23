//
//  SVHSelectCell.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHSelectCell.h"

@interface SVHSelectCell(){
    GJTBaseImageView* _rightImage;
    GJTBaseImageView* _leftImage;
}
@end

@implementation SVHSelectCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForItem:(GJTBaseCellItem *)item{
    SVHSelectCellItem* sItem = (SVHSelectCellItem*)item;
    if (sItem.cellHeight > 0) {
        return sItem.cellHeight;
    }
    return 40.0f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:14.0f];
        self.textLabel.textColor = UIColor.darkTextColor;
        
        _rightImage = [[GJTBaseImageView alloc] initWithFrame:CGRectZero];
        _rightImage.backgroundColor = UIColor.clearColor;
        
        _leftImage = [[GJTBaseImageView alloc] initWithFrame:CGRectZero];
        _leftImage.backgroundColor = UIColor.clearColor;
        
        [self.contentView addSubview:_rightImage];
        [self.contentView addSubview:_leftImage];
    }
    return self;
}

- (void)setItem:(GJTBaseCellItem *)item{
//    if ([item valueChangedToItem:_item]) {
        [super setItem:item];
        SVHSelectCellItem* sItem = (SVHSelectCellItem*)item;
        self.textLabel.text = sItem.title;
    self.textLabel.textColor = sItem.titleColor;
    self.textLabel.font = sItem.titleFont;
    _leftImage.image = sItem.leftImage;
        _rightImage.image = sItem.selected?sItem.selectedImage:sItem.defaultImage;
//    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize imageSize = CGSizeMake(25, 25);//_rightImage.image.size.width;
    SVHSelectCellItem* item = (SVHSelectCellItem*)_item;
    if (item.rightImageSize.width >0 && item.rightImageSize.height > 0) {
        imageSize = item.rightImageSize;
    }
    
    CGFloat textLabelLeft = item.contentInsets.left;
    if (_leftImage.image) {
        _leftImage.frame = CGRectMake(textLabelLeft, 0, 20, 20);
        textLabelLeft = _leftImage.right + 10;
    }
    self.textLabel.frame = CGRectMake(textLabelLeft, 0,self.contentView.width - 10 - imageSize.width - item.contentInsets.right - textLabelLeft,self.textLabel.font.lineHeight);
    _rightImage.frame = CGRectMake(self.contentView.width - item.contentInsets.right - imageSize.width, 0, imageSize.width, imageSize.height);
    _leftImage.centerY = self.textLabel.centerY = _rightImage.centerY = self.contentView.height/2;
}

@end

@implementation SVHSelectCellItem

+ (instancetype)itemWithTitle:(NSString*)title{
    return [SVHSelectCellItem itemWithTitle:title defaultImage:nil selectedImage:nil selected:NO contentInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}

+ (instancetype)itemWithTitle:(NSString*)title contentInsets:(UIEdgeInsets)contentInsets{
    return [SVHSelectCellItem itemWithTitle:title defaultImage:nil selectedImage:nil selected:NO contentInsets:contentInsets];
}

+ (instancetype)itemWithTitle:(NSString*)title defaultImage:(UIImage*)defaultImage selectedImage:(UIImage*)selectedImage selected:(BOOL)selected contentInsets:(UIEdgeInsets)contentInsets{
    SVHSelectCellItem* item = [[SVHSelectCellItem alloc] init];
    item.title = title;
    item.defaultImage = defaultImage;
    item.selected = selected;
    if (selectedImage) {
        item.selectedImage = selectedImage;
    }
    if (!UIEdgeInsetsEqualToEdgeInsets(contentInsets, UIEdgeInsetsZero) ) {
        item.contentInsets = contentInsets;
    }
    return item;
}

- (instancetype)init{
    if (self = [super init]) {
        self.contentInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        self.selectedImage = [UIImage imageNamed:@"ProjectSettingSelection_YES"];
        self.titleColor = UIColor.darkTextColor;
        self.titleFont = [UIFont systemFontOfSize:14.0f];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (Class)cellClass{
    return [SVHSelectCell class];
}

- (BOOL)valueChangedToItem:(GJTBaseCellItem*)item{
    SVHSelectCellItem* object = (SVHSelectCellItem*)item;
    if (self.title != object.title) {
        return YES;
    }
    if (self.selected != object.selected) {
        return YES;
    }
    if (self.defaultImage != object.defaultImage) {
        return YES;
    }
    if (self.selectedImage != object.selectedImage) {
        return YES;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(self.contentInsets, object.contentInsets)) {
        return YES;
    }
    return NO;
}

@end
