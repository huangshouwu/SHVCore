//
//  GJTSearchBar.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/8/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJTSearchBar;

@protocol GJTSearchBarDelegate <NSObject>

@optional
- (void)searchBar:(GJTSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface GJTSearchBar : UIView

@property (nonatomic,strong)UITextField* textField;
@property (nonatomic,weak)id<GJTSearchBarDelegate> delegate;

@end
