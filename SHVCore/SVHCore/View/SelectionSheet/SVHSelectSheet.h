//
//  GJTProjectSettingSelectAlert.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/5.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHBaseView.h"
#import "SVHSelectCell.h"
#import "SVHToolBar.h"

@class SVHSelectSheet;

typedef void(^SVHSelectSheetBlock)(SVHSelectSheet* sheet,NSArray* selectedArray);

@interface SVHSelectSheet : SVHBaseView

@property (nonatomic,assign)BOOL showToolBar;
@property (nonatomic,strong)SVHToolBar* toolBar;
@property (nonatomic,strong)NSArray <SVHSelectCellItem *>* listArray;
@property (nonatomic,strong)NSMutableArray <SVHSelectCellItem *>* selectedArray;

@property (nonatomic,assign)BOOL singleSelectionOnly;/** 只支持单选 单选模式不会显示toolbar*/
@property (nonatomic,copy)SVHSelectSheetBlock finishedBlock;

+ (void)showInView:(UIView*)view
             title:(NSString*)title
           allList:(NSArray <SVHSelectCellItem *>*)allListArray
singleSelectionOnly:(BOOL)singleSelectionOnly
     finishedBlock:(SVHSelectSheetBlock)finishedBlock;

/** 不显示顶部toolBar */
+ (void)showInView:(UIView*)view
           allList:(NSArray <SVHSelectCellItem *>*)allListArray
     finishedBlock:(SVHSelectSheetBlock)finishedBlock;

- (void)showInView:(UIView*)view;
- (void)hide;

- (void)removeCancelAction;
- (void)removeSureAction;

@end
