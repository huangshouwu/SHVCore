//
//  THDatePickerView.h
//  rongyp-company
//
//  Created by Apple on 2016/11/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVHBaseView.h"

@class SVHDatePicker;

typedef void(^SVHDatePickerFinishedBlock)(SVHDatePicker* picker,NSString* time);

typedef enum {
   SVHDatePickerComponentStyleNone = -1,
   SVHDatePickerComponentStyleYear = 1UL << 0,
   SVHDatePickerComponentStyleMonth = 1UL << 1,
   SVHDatePickerComponentStyleDay = 1UL << 2,
   SVHDatePickerComponentStyleHour = 1UL << 3,
   SVHDatePickerComponentStyleMinute = 1UL << 4,
    
   SVHDatePickerComponentStyleYear_Month_Day =SVHDatePickerComponentStyleYear |SVHDatePickerComponentStyleMonth |SVHDatePickerComponentStyleDay,
    
   SVHDatePickerComponentStyleAll =SVHDatePickerComponentStyleYear |SVHDatePickerComponentStyleMonth |SVHDatePickerComponentStyleDay |SVHDatePickerComponentStyleHour |SVHDatePickerComponentStyleMinute,
}SVHDatePickerComponentStyle;

@protocol SVHDatePickerDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
@optional;
- (void)datePickerView:(SVHDatePicker*)picker saveBtnClickDelegate:(NSString *)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate:(SVHDatePicker*)picker;

@end

@interface SVHDatePicker : UIView

+ (SVHDatePicker*)showInView:(UIView*)view
                           title:(NSString*)title
                           style:(SVHDatePickerComponentStyle)style
                           block:(SVHDatePickerFinishedBlock)finishedBlock;

+ (SVHDatePicker*)showInView:(UIView*)view
                           title:(NSString*)title
                           style:(SVHDatePickerComponentStyle)style
                            year:(NSString*)year
                           month:(NSString*)month
                             day:(NSString*)day
                            hour:(NSString*)hour
                          minute:(NSString*)minute
                           block:(SVHDatePickerFinishedBlock)finishedBlock;

@property (strong, nonatomic) UIPickerView *pickerView; // 选择器
@property (strong, nonatomic) SVHBaseView *toolView; // 工具条

@property (nonatomic,strong)NSDateComponents* maxComponents;
@property (nonatomic,strong)NSDateComponents* minComponents;

@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) id <SVHDatePickerDelegate> delegate;
@property (nonatomic,assign)SVHDatePickerComponentStyle style;

@property (copy, nonatomic) NSString *year; // 选中年
@property (copy, nonatomic) NSString *month; //选中月
@property (copy, nonatomic) NSString *day; //选中日
@property (copy, nonatomic) NSString *hour; //选中时
@property (copy, nonatomic) NSString *minute; //选中分
@property (copy, nonatomic)SVHDatePickerFinishedBlock finishedBlock;

/// 显示
- (void)show;

- (void)clear;

@end
