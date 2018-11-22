//
//  UIViewController+BackButtonItem.m
//  Lottery
//
//  Created by huangshouwu on 14-7-14.
//  Copyright (c) 2014年 9188-MacPro1. All rights reserved.
//

#import "UIViewController+BackButtonItem.h"
#import "SVHUIViewAdditions.h"
#import "SVHBaseMacros.h"
#import "SVHCommonTool.h"

static CGRect const NOEEBackButtonFrame = {0,0,40,35};

@implementation UIViewController (BackButtonItem)

// 将文字和图片拼接成图片
+ (UIImage *)backButtonImageWithImage:(UIImage *)image text:(NSString*)text textColor:(UIColor *)color
{
    UIColor *textColor = color ? :[UIColor whiteColor];
    
    //设置字体样式
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:textColor};
    CGSize textSize = [text sizeWithAttributes: dict];
    
    //绘制上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width + textSize.width + 4, image.size.height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    CGRect textRect = {CGPointMake(image.size.width + 4, (image.size.height - textSize.height) / 2), textSize};
    [text drawInRect:textRect withAttributes:dict];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)showBackItem{
    [self showBackItemWithAction:@selector(backButtonItemAction)];
}

- (void)showBackItemWithAction:(SEL)action{
    if (self.navigationController.viewControllers.count > 1) {
        [self forceShowBackItemWithAction:action];
    }
}

- (void)forceShowBackItem{
    [self forceShowBackItemWithAction:@selector(backButtonItemAction)];
}

- (void)forceShowBackItemWithAction:(SEL)action{
    [self forceShowBackItemWithAction:action frame:NOEEBackButtonFrame];
}

- (void)forceShowBackItemWithImage:(UIImage *)image {
    [self forceShowBackItemWithImage:image title:nil action:@selector(backButtonItemAction) frame:NOEEBackButtonFrame];
}

- (void)forceShowBackItemWithAction:(SEL)action frame:(CGRect)frame{
    [self forceShowBackItemWithImage:SVHResourceImageWithName(@"GJTNavgationBackButton") title:nil action:action frame:frame];
}

- (void)forceShowBackItemWithImage:(UIImage *)image
                             title:(NSString*)title
                            action:(SEL)action
                             frame:(CGRect)frame{
    self.navigationItem.leftBarButtonItem = nil;
 
    UIBarButtonItem * leftItem = nil;
    if (image) {
        if (title.length) {
            image = [UIViewController backButtonImageWithImage:image text:title textColor:self.navigationController.navigationBar.tintColor];
        }
        leftItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
        leftItem.imageInsets = UIEdgeInsetsMake(0, -3, 0, 0);
    } else {
        frame.size.width = 55;
        UIControl* control = [[UIControl alloc] initWithFrame:frame];
        control.backgroundColor = [UIColor clearColor];
        [control addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [imageView setContentMode:UIViewContentModeLeft];
        imageView.image = image;
        CGRect imageFrame = CGRectMake(0, 0, 44, 44);
        if (title.length) {
            imageFrame = CGRectMake(-1, 0, 44, 44);
            UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.frame = CGRectMake(CGRectGetMinX(imageFrame) + 15, (CGRectGetHeight(imageFrame) - [titleLabel.font lineHeight])/2 + 1.2, CGRectGetWidth(imageFrame)- 10, [titleLabel.font lineHeight]);
            titleLabel.textColor = self.navigationController.navigationBar.tintColor;
            titleLabel.text = title;
            [imageView addSubview:titleLabel];
        }
        imageView.frame = imageFrame;
        imageView.centerY = control.height/2;
        [control addSubview:imageView];
        
        leftItem = [[UIBarButtonItem alloc] initWithCustomView:control];
        leftItem.title = @"";
    }
    
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)backButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton*)createRightButtonWithImage:(UIImage*)image target:(id)target selector:(SEL)selector {
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 22.0f, 22.0f);
    [rightButton setImage:image forState:UIControlStateNormal];
    rightButton.adjustsImageWhenDisabled = NO;
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return rightButton;
}

@end
