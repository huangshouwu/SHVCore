//
//  SVHSearchBar.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/8/29.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVHSearchBar;

@protocol SVHSearchBarDelegate <NSObject>

@optional
- (void)searchBar:(SVHSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface SVHSearchBar : UIView

@property (nonatomic,strong)UITextField* textField;
@property (nonatomic,weak)id<SVHSearchBarDelegate> delegate;

@end
