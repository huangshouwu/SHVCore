//
//  GJTSearchBar.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/8/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "GJTSearchBar.h"
#import "GJTUIViewAdditions.h"
#import "GJTCommonTool.h"

@interface GJTSearchBar ()<UITextFieldDelegate>
@end

@implementation GJTSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.textField];
    }
    return self;
}

- (UITextField*)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.background = GJTResourceImageWithName(@"SearchBarBackgroundImage");
        _textField.placeholder = @"请输入内容";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius = 5;
        _textField.font = [UIFont systemFontOfSize:15.0f];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = [self createTextFieldLeftViewWithImage:GJTResourceImageWithName(@"SearchBarScopeImage") height:30];
    }
    return _textField;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(20, 10, self.width - 40, 30);
}

- (UIView*)createTextFieldLeftViewWithImage:(UIImage*)image height:(CGFloat)height{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, height)];
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, height)];
    view.backgroundColor = [UIColor clearColor];
    contentView.backgroundColor = [UIColor clearColor];
    UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(contentView.frame) - image.size.width)/2, (CGRectGetHeight(contentView.frame) - image.size.height)/2, image.size.width, image.size.height)];
    imageview.image = image;
    [contentView addSubview:imageview];
    [view addSubview:contentView];
    return view;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* newText = [NSMutableString stringWithCapacity:0];
    if (textField.text) {
        [newText appendString:textField.text];
        [newText replaceCharactersInRange:range withString:string];
    }else {
        [newText appendString:string];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:newText];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:@""];
    }
    
    return YES;
}

@end
