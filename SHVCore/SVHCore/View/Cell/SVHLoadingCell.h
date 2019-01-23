//
//  SVHLoadingCell.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/20.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHBaseCell.h"
@class SVHLoadingCell;

typedef void(^SVHLoadingCellReloadBlock)(SVHLoadingCell* cell);

typedef enum {
    SVHLoadingStateNone,
    SVHLoadingStateLoading,
    SVHLoadingStateFail
}SVHLoadingState;

@interface SVHLoadingCell : SVHBaseCell

@end

@interface SVHLoadingCellItem : SVHBaseCellItem

@property (nonatomic,assign)SVHLoadingState loadingState;
@property (nonatomic,copy)SVHLoadingCellReloadBlock reloadBlock;

@end
