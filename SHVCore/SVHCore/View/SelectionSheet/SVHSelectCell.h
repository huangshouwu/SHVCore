//
//  GJTSelectCell.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "GJTBaseCell.h"

@interface GJTSelectCell : GJTBaseCell

@end

@interface GJTSelectCellItem : GJTBaseCellItem

+ (instancetype)itemWithTitle:(NSString*)title;
+ (instancetype)itemWithTitle:(NSString*)title contentInsets:(UIEdgeInsets)contentInsets;
+ (instancetype)itemWithTitle:(NSString*)title defaultImage:(UIImage*)defaultImage selectedImage:(UIImage*)selectedImage selected:(BOOL)selected contentInsets:(UIEdgeInsets)contentInsets;

@property (nonatomic,copy)NSString* title;
@property (nonatomic,strong)UIImage* defaultImage;
@property (nonatomic,strong)UIImage* selectedImage;
@property (nonatomic,strong)UIImage* leftImage;
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)UIEdgeInsets contentInsets;
@property (nonatomic,strong)id userInfo;
@property (nonatomic,strong)UIColor* titleColor;
@property (nonatomic,strong)UIFont* titleFont;
@property (nonatomic,assign)CGSize rightImageSize;
@property (nonatomic,assign)CGFloat cellHeight;

@end
