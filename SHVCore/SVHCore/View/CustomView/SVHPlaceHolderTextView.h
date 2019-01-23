//
//  SVHPlaceHolderTextView.h
//  reduceWeight
//
//  Created by  on 11-11-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVHPlaceHolderTextView : UITextView

{
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic ,strong) void(^textDidChangeBlock)(NSString *text);
@property (nonatomic ,strong) UIColor *originalTintColor;

-(void)textChanged:(NSNotification*)notification;
- (void)drawBoundLine:(CGRect)rect;
@end
