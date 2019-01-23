//
//  THDatePickerView.m
//  rongyp-company
//
//  Created by Apple on 2016/11/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SVHDatePicker.h"

static CGFloat SVHDatePickerToolBarHeight = 40;

@interface SVHDatePicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UILabel *titleLbl; // 标题

@property (strong, nonatomic) NSMutableArray *dataArray; // 数据源
@property (copy, nonatomic) NSString *selectStr; // 选中的时间


@property (strong, nonatomic) NSMutableArray *yearArr; // 年数组
@property (strong, nonatomic) NSMutableArray *monthArr; // 月数组
@property (strong, nonatomic) NSMutableArray *dayArr; // 日数组
@property (strong, nonatomic) NSMutableArray *hourArr; // 时数组
@property (strong, nonatomic) NSMutableArray *minuteArr; // 分数组
@property (strong, nonatomic) NSArray *timeArr; // 当前时间数组

@end

#define THColorRGB(rgb)    [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1.0]

@implementation SVHDatePicker

+ (SVHDatePicker*)showInView:(UIView*)view
                           title:(NSString*)title
                           style:(SVHDatePickerComponentStyle)style
                           block:(SVHDatePickerFinishedBlock)finishedBlock{
    return [SVHDatePicker showInView:view title:title style:style year:nil month:nil day:nil hour:nil minute:nil block:finishedBlock];
}

+ (SVHDatePicker*)showInView:(UIView*)view
                           title:(NSString*)title
                           style:(SVHDatePickerComponentStyle)style
                            year:(NSString*)year
                           month:(NSString*)month
                             day:(NSString*)day
                            hour:(NSString*)hour
                          minute:(NSString*)minute
                           block:(SVHDatePickerFinishedBlock)finishedBlock{
    SVHDatePicker* picker = [[SVHDatePicker alloc] initWithFrame:CGRectMake(0, view.bottom, view.width, 250)];
    picker.finishedBlock = finishedBlock;
    picker.title = title;
    picker.style = style;
    picker.year = year;
    picker.month = month;
    picker.day = day;
    picker.hour = hour;
    picker.minute = minute;
    [picker show];
    [view showViewWithBackView:picker alpha:0.3 target:picker touchAction:@selector(hide) animation:^{
        picker.top = view.height - picker.height;
    } timeInterval:0.3 fininshed:nil];
    return picker;
}

- (void)hide{
    if (self.superview) {
        [self.superview hideBackViewForView:self animation:^{
            self.top = self.superview.height;
        } timeInterval:0.3 fininshed:nil];
    }
}

#pragma mark - init
/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataArray = [NSMutableArray array];
        
        [self configToolView];
        [self configPickerView];
    }
    return self;
}
#pragma mark - 配置界面
/// 配置工具条
- (void)configToolView {
    self.toolView = [[GJTBaseView alloc] init];
    self.toolView.frame = CGRectMake(0, 0, self.frame.size.width, SVHDatePickerToolBarHeight);
    self.toolView.backgroundColor = [UIColor whiteColor];
    self.toolView.borderLineStyle = GJTBorder_Line_Top;
    self.toolView.borderColor = UIColor.lightGrayColor;
    self.toolView.borderWidth = 1.0f/GJTScreenScale();
    [self addSubview:self.toolView];
    
    UIButton *saveBtn = [[UIButton alloc] init];
    saveBtn.frame = CGRectMake(self.frame.size.width - 50, 2, 40, 40);
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:saveBtn];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(10, 2, 40, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    [self.toolView addSubview:cancelBtn];
    
    self.titleLbl = [[UILabel alloc] init];
    self.titleLbl.frame = CGRectMake(60, 2, self.frame.size.width - 120, 40);
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    self.titleLbl.textColor = THColorRGB(34);
    [self.toolView addSubview:self.titleLbl];
}

/// 配置UIPickerView
- (void)configPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolView.frame), self.frame.size.width, self.frame.size.height - SVHDatePickerToolBarHeight)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self addSubview:self.pickerView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLbl.text = title;
}

- (void)setStyle:(SVHDatePickerComponentStyle)style{
    _style = style;
    [self.dataArray removeAllObjects];
    if ((_style &SVHDatePickerComponentStyleYear) ==SVHDatePickerComponentStyleYear) {
        [self.dataArray addObject:self.yearArr];
    }
    if ((_style &SVHDatePickerComponentStyleMonth) ==SVHDatePickerComponentStyleMonth) {
        [self.dataArray addObject:self.monthArr];
    }
    if ((_style &SVHDatePickerComponentStyleDay) ==SVHDatePickerComponentStyleDay) {
        [self.dataArray addObject:self.dayArr];
    }
    if ((_style &SVHDatePickerComponentStyleHour) ==SVHDatePickerComponentStyleHour) {
        [self.dataArray addObject:self.hourArr];
    }
    if ((_style &SVHDatePickerComponentStyleMinute) ==SVHDatePickerComponentStyleMinute) {
        [self.dataArray addObject:self.minuteArr];
    }
}

- (NSInteger)componentIndexWithStyle:(SVHDatePickerComponentStyle)componetStyle{
    NSInteger index = 0;
    switch (componetStyle) {
        caseSVHDatePickerComponentStyleYear:
            index = [self.dataArray safeIndexOfObject:self.yearArr];
            break;
        caseSVHDatePickerComponentStyleMonth:
            index = [self.dataArray safeIndexOfObject:self.monthArr];
            break;
        caseSVHDatePickerComponentStyleDay:
            index = [self.dataArray safeIndexOfObject:self.dayArr];
            break;
        caseSVHDatePickerComponentStyleHour:
            index = [self.dataArray safeIndexOfObject:self.hourArr];
            break;
        caseSVHDatePickerComponentStyleMinute:
            index = [self.dataArray safeIndexOfObject:self.minuteArr];
            break;
        default:
            break;
    }
    return index;
}

- (SVHDatePickerComponentStyle)styleWithComponentIndex:(NSInteger)component{
   SVHDatePickerComponentStyle compontStyle =SVHDatePickerComponentStyleYear;
    NSArray* currentArr = [self.dataArray safeObjectAtIndex:component];
    if (self.yearArr == currentArr) {
        compontStyle =SVHDatePickerComponentStyleYear;
    }else if (self.monthArr == currentArr){
        compontStyle =SVHDatePickerComponentStyleMonth;
    }else if (self.dayArr == currentArr){
        compontStyle =SVHDatePickerComponentStyleDay;
    }else if (self.hourArr == currentArr){
        compontStyle =SVHDatePickerComponentStyleHour;
    }else if (self.minuteArr == currentArr){
        compontStyle =SVHDatePickerComponentStyleMinute;
    }
    return compontStyle;
}

- (void)clear{
    self.year = nil;
    self.month = nil;
    self.day = nil;
    self.hour = nil;
    self.minute = nil;
}

- (void)show {
    if (!self.year.length) {
        self.year = self.timeArr[0];
    }
    if (!self.month.length) {
        self.month = self.timeArr[1];// [NSString stringWithFormat:@"%ld月", [self.timeArr[1] integerValue]];
    }
    if (!self.day.length) {
        self.day = self.timeArr[2];//[NSString stringWithFormat:@"%ld日", [self.timeArr[2] integerValue]];
    }
    if (!self.hour.length) {
        self.hour = self.timeArr[3];//[NSString stringWithFormat:@"%ld时", [self.timeArr[3] integerValue]];
    }
    if (!self.minute.length) {
        self.minute = self.timeArr[4];//self.minuteArr[self.minuteArr.count / 2];
    }
    
    NSInteger componentIndex = 0;
    
    if ((_style &SVHDatePickerComponentStyleYear) ==SVHDatePickerComponentStyleYear) {
        NSInteger componentIndex = [self componentIndexWithStyle:SVHDatePickerComponentStyleYear];
        [self resetDateSelectedWithLimit:self.year originRow:0 style:SVHDatePickerComponentStyleYear component:componentIndex];
    }
    if ((_style &SVHDatePickerComponentStyleMonth) ==SVHDatePickerComponentStyleMonth) {
        NSInteger componentIndex = [self componentIndexWithStyle:SVHDatePickerComponentStyleMonth];
        [self resetDateSelectedWithLimit:self.month originRow:0 style:SVHDatePickerComponentStyleMonth component:componentIndex];
    }
    if ((_style &SVHDatePickerComponentStyleDay) ==SVHDatePickerComponentStyleDay) {
        NSInteger componentIndex = [self componentIndexWithStyle:SVHDatePickerComponentStyleDay];
        [self resetDateSelectedWithLimit:self.day originRow:0 style:SVHDatePickerComponentStyleDay component:componentIndex];
    }
    if ((_style &SVHDatePickerComponentStyleHour) ==SVHDatePickerComponentStyleHour) {
        NSInteger componentIndex = [self componentIndexWithStyle:SVHDatePickerComponentStyleHour];
        [self resetDateSelectedWithLimit:self.hour originRow:0 style:SVHDatePickerComponentStyleHour component:componentIndex];
    }
    if ((_style &SVHDatePickerComponentStyleMinute) ==SVHDatePickerComponentStyleMinute) {
        NSInteger componentIndex = [self componentIndexWithStyle:SVHDatePickerComponentStyleMinute];
        [self resetDateSelectedWithLimit:self.minute originRow:0 style:SVHDatePickerComponentStyleMinute component:componentIndex];
    }
}

#pragma mark - 点击方法

- (NSString*)getSelectedTimeString{
    NSString *month = [NSString stringWithFormat:@"%.2i",self.month.intValue];
    NSString *day = [NSString stringWithFormat:@"%.2i",self.day.intValue];
    NSString *hour = [NSString stringWithFormat:@"%.2i",self.hour.intValue];
    NSString *minute = [NSString stringWithFormat:@"%.2i",self.minute.intValue];
    
    NSMutableString *selectedDateString = [NSMutableString stringWithCapacity:0];
    if ((_style &SVHDatePickerComponentStyleYear) ==SVHDatePickerComponentStyleYear) {
        [selectedDateString appendString:[NSString stringWithFormat:@"%ld", [self.year integerValue]]];
    }
    if ((_style &SVHDatePickerComponentStyleMonth) ==SVHDatePickerComponentStyleMonth) {
        if (selectedDateString.length) {
            [selectedDateString appendString:@"-"];
        }
        [selectedDateString appendString:month];
    }
    if ((_style &SVHDatePickerComponentStyleDay) ==SVHDatePickerComponentStyleDay) {
        if (selectedDateString.length) {
            [selectedDateString appendString:@"-"];
        }
        [selectedDateString appendString:day];
    }
    if ((_style &SVHDatePickerComponentStyleHour) ==SVHDatePickerComponentStyleHour) {
        if (selectedDateString.length) {
            [selectedDateString appendString:@" "];
        }
        [selectedDateString appendString:hour];
    }
    if ((_style &SVHDatePickerComponentStyleMinute) ==SVHDatePickerComponentStyleMinute) {
        if (selectedDateString.length) {
            [selectedDateString appendString:@":"];
        }
        [selectedDateString appendString:minute];
    }
    return selectedDateString;
}

/// 保存按钮点击方法
- (void)saveBtnClick {
    NSLog(@"点击了保存");
    self.selectStr = [self getSelectedTimeString];
    if ([self.delegate respondsToSelector:@selector(datePickerView:saveBtnClickDelegate:)]) {
        [self.delegate datePickerView:self saveBtnClickDelegate:self.selectStr];
    }
    [self hide];
    if (self.finishedBlock) {
        self.finishedBlock(self, self.selectStr);
    }
}
/// 取消按钮点击方法
- (void)cancelBtnClick {
    NSLog(@"点击了取消");
    if ([self.delegate respondsToSelector:@selector(datePickerViewCancelBtnClickDelegate:)]) {
        [self.delegate datePickerViewCancelBtnClickDelegate:self];
    }
    [self hide];
}
#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource
/// UIPickerView返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

/// UIPickerView返回每组多少条数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [self.dataArray[component] count] * 200;
}

/// UIPickerView选择哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
   SVHDatePickerComponentStyle cStyle = [self styleWithComponentIndex:component];
    
    switch (cStyle) {
        caseSVHDatePickerComponentStyleYear: { // 年
            NSInteger year_integerValue = [self.yearArr[row%[self.dataArray[component] count]] integerValue];
            [self resetDateSelectedWithLimit:[@(year_integerValue) stringValue] originRow:row style:cStyle component:component];
        } break;
        caseSVHDatePickerComponentStyleMonth: { // 月
            NSInteger month_value = [self.monthArr[row%[self.dataArray[component] count]] integerValue];
            [self resetDateSelectedWithLimit:[@(month_value) stringValue] originRow:row style:cStyle component:component];
            [self refreshDay];
        } break;
        caseSVHDatePickerComponentStyleDay: { // 日
            NSInteger day_value = [self.dayArr[row%[self.dataArray[component] count]] integerValue];
            [self resetDateSelectedWithLimit:[@(day_value) stringValue] originRow:row style:cStyle component:component];
        } break;
        caseSVHDatePickerComponentStyleHour: { // 时
            NSInteger hour_value = [self.hourArr[row%[self.dataArray[component] count]] integerValue];
            [self resetDateSelectedWithLimit:[@(hour_value) stringValue] originRow:row style:cStyle component:component];
        } break;
        caseSVHDatePickerComponentStyleMinute: { // 分
            NSInteger minute_value = [self.minuteArr[row%[self.dataArray[component] count]] integerValue];
            [self resetDateSelectedWithLimit:[@(minute_value) stringValue] originRow:row style:cStyle component:component];
        } break;
        default: break;
    }
}

- (NSString*)unitForStyle:(SVHDatePickerComponentStyle)style{
    NSString* unit = @"";
    switch (style) {
        caseSVHDatePickerComponentStyleYear:
            unit = @"年";
            break;
        caseSVHDatePickerComponentStyleMonth:
            unit = @"月";
            break;
        caseSVHDatePickerComponentStyleDay:
            unit = @"日";
            break;
        caseSVHDatePickerComponentStyleHour:
            unit = @"时";
            break;
        caseSVHDatePickerComponentStyleMinute:
            unit = @"分";
            break;
            
        default:
            break;
    }
    return unit;
}

- (NSArray*)componentArrForStyle:(SVHDatePickerComponentStyle)style{
    NSArray* componentArr = nil;
    switch (style) {
        caseSVHDatePickerComponentStyleYear:
            componentArr = self.yearArr;
            break;
        caseSVHDatePickerComponentStyleMonth:
            componentArr = self.monthArr;
            break;
        caseSVHDatePickerComponentStyleDay:
            componentArr = self.dayArr;
            break;
        caseSVHDatePickerComponentStyleHour:
            componentArr = self.hourArr;
            break;
        caseSVHDatePickerComponentStyleMinute:
            componentArr = self.minuteArr;
            break;
            
        default:
            break;
    }
    return componentArr;
}

- (void)setComponentValue:(NSString*)componentValue forStyle:(SVHDatePickerComponentStyle)style{
    switch (style) {
        caseSVHDatePickerComponentStyleYear:
            self.year = componentValue;
            break;
        caseSVHDatePickerComponentStyleMonth:
            self.month = componentValue;
            break;
        caseSVHDatePickerComponentStyleDay:
            self.day = componentValue;
            break;
        caseSVHDatePickerComponentStyleHour:
             self.hour = componentValue;
            break;
        caseSVHDatePickerComponentStyleMinute:
             self.minute = componentValue;
            break;
        default:
            break;
    }
}

- (NSInteger)maxLimitForStyle:(SVHDatePickerComponentStyle)style{
    if (!self.maxComponents) {
        return 9999;
    }
    NSInteger maxLimit = 0;
    switch (style) {
        caseSVHDatePickerComponentStyleYear:
            maxLimit = self.maxComponents.year;
            break;
        caseSVHDatePickerComponentStyleMonth:
            maxLimit = self.maxComponents.month;
            break;
        caseSVHDatePickerComponentStyleDay:
            maxLimit = self.maxComponents.day;
            break;
        caseSVHDatePickerComponentStyleHour:
            maxLimit = self.maxComponents.hour;
            break;
        caseSVHDatePickerComponentStyleMinute:
            maxLimit = self.maxComponents.minute;
            break;
        default:
            break;
    }
    return maxLimit;
}

- (NSInteger)minLimitForStyle:(SVHDatePickerComponentStyle)style{
    if (!self.minComponents) {
        return 0;
    }
    NSInteger minLimit = 0;
    switch (style) {
        caseSVHDatePickerComponentStyleYear:
            minLimit = self.minComponents.year;
            break;
        caseSVHDatePickerComponentStyleMonth:
            minLimit = self.minComponents.month;
            break;
        caseSVHDatePickerComponentStyleDay:
            minLimit = self.minComponents.day;
            break;
        caseSVHDatePickerComponentStyleHour:
            minLimit = self.minComponents.hour;
            break;
        caseSVHDatePickerComponentStyleMinute:
            minLimit = self.minComponents.minute;
            break;
        default:
            break;
    }
    return minLimit;
}

- (void)resetDateSelectedWithLimit:(NSString*)selectedValue originRow:(NSInteger)originRow style:(SVHDatePickerComponentStyle)style component:(NSInteger)component{
    
    //先假设满足限制条件
    [self setSelectedValue:selectedValue originRow:originRow forStyle:style];
    
    //再判断是否合理
    
    if (self.maxComponents) {
        [self setMaxLimitWithOriginRow:originRow startStyle:style selectedStyle:style];
    }
    if (self.minComponents){
        [self setMinLimitWithOriginRow:originRow startStyle:style selectedStyle:style];
    }
}

- (void)setMaxLimitWithOriginRow:(NSInteger)originRow startStyle:(SVHDatePickerComponentStyle)startStyle selectedStyle:(SVHDatePickerComponentStyle)selectedStyle{
    
    if (!self.maxComponents || startStyle ==SVHDatePickerComponentStyleNone) {
        return;
    }
    
    NSInteger maxLimit = [self maxLimitForStyle:startStyle];
    if (selectedStyle == startStyle) {
        if ([self isSelectedTimeMoreThanMaxLimitTime]) {
            [self setSelectedValue:[@(maxLimit) stringValue] originRow:originRow forStyle:selectedStyle];
        }
    }else if ((startStyle & self.style) > 0) {
        [self setSelectedValue:[@(maxLimit) stringValue] originRow:originRow forStyle:startStyle];
    }

    if ([self isSelectedTimeMoreThanMaxLimitTime]){
        [self setMaxLimitWithOriginRow:0 startStyle:[self nextStyle:startStyle] selectedStyle:selectedStyle];
    }
}

- (BOOL)isSelectedTimeLessThanMinLimitTime{
    NSString* selectedDataString = [self getSelectedTimeString];
    NSString* timeFormat = @"yyyy-MM-dd HH:mm";
    NSTimeInterval currentTimeInterval = [GJTDateTool timeIntervalString:selectedDataString format:timeFormat];
    NSTimeInterval minTimeInterval = [GJTDateTool timeIntervalComponents:self.minComponents format:timeFormat];
    if (self.minComponents && (currentTimeInterval < minTimeInterval)) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)isSelectedTimeMoreThanMaxLimitTime{
    NSString* selectedDataString = [self getSelectedTimeString];
    NSString* timeFormat = @"yyyy-MM-dd HH:mm";
    NSTimeInterval currentTimeInterval = [GJTDateTool timeIntervalString:selectedDataString format:timeFormat];
    NSTimeInterval maxTimeInterval = [GJTDateTool timeIntervalComponents:self.maxComponents format:timeFormat];
    if (self.maxComponents && (currentTimeInterval > maxTimeInterval)){
        return YES;
    }else {
        return NO;
    }
}

- (void)setMinLimitWithOriginRow:(NSInteger)originRow startStyle:(SVHDatePickerComponentStyle)startStyle selectedStyle:(SVHDatePickerComponentStyle)selectedStyle{
    
    if (!self.minComponents || startStyle ==SVHDatePickerComponentStyleNone) {
        return;
    }
    
    NSInteger minLimit = [self minLimitForStyle:startStyle];
    if (selectedStyle == startStyle) {
        if ([self isSelectedTimeLessThanMinLimitTime]) {
            [self setSelectedValue:[@(minLimit) stringValue] originRow:originRow forStyle:selectedStyle];
        }
    }else if ((startStyle & self.style) > 0) {
        [self setSelectedValue:[@(minLimit) stringValue] originRow:originRow forStyle:startStyle];
    }
    
    if ([self isSelectedTimeLessThanMinLimitTime]){
        [self setMinLimitWithOriginRow:0 startStyle:[self nextStyle:startStyle] selectedStyle:selectedStyle];
    }
}

- (SVHDatePickerComponentStyle)nextStyle:(SVHDatePickerComponentStyle)currentStyle{
    if (currentStyle ==SVHDatePickerComponentStyleYear) {
        returnSVHDatePickerComponentStyleMonth;
    }else if (currentStyle ==SVHDatePickerComponentStyleMonth) {
        returnSVHDatePickerComponentStyleDay;
    }else if (currentStyle ==SVHDatePickerComponentStyleDay) {
        returnSVHDatePickerComponentStyleHour;
    }else if (currentStyle ==SVHDatePickerComponentStyleHour) {
        returnSVHDatePickerComponentStyleMinute;
    }else
        returnSVHDatePickerComponentStyleNone;
}

- (void)setSelectedValue:(NSString*)value originRow:(NSInteger)originRow forStyle:(SVHDatePickerComponentStyle)style{
    NSInteger componentIndex = [self componentIndexWithStyle:style];
    NSArray* componentArr = [self componentArrForStyle:style];
    NSInteger newRow = 0;
    for (NSString* rowValue in componentArr) {
        if ([rowValue integerValue] == [value integerValue]) {
            newRow = [componentArr safeIndexOfObject:rowValue];
        }
    }
    if (originRow !=0 && (originRow%componentArr.count == newRow)) {
        newRow = originRow;
    }
    [self.pickerView selectRow:newRow inComponent:componentIndex animated:YES];
    [self setComponentValue:value forStyle:style];
}

/// UIPickerView返回每一行数据
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [self.dataArray[component] safeObjectAtIndex:row%[self.dataArray[component] count]];
}
/// UIPickerView返回每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
/// UIPickerView返回每一行的View
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSLog(@"%@", view);
        
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 44)];
    titleLbl.font = [UIFont systemFontOfSize:15];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = [self.dataArray[component] safeObjectAtIndex:row%[self.dataArray[component] count]];

    return titleLbl;
}


- (void)pickerViewLoaded:(NSInteger)component row:(NSInteger)row{
    NSUInteger max = 16384;
    NSUInteger base10 = (max/2)-(max/2)%row;
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % row + base10 inComponent:component animated:NO];
}


/// 获取年份
- (NSMutableArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
        for (int i = 1970; i < 2099; i ++) {
            [_yearArr addObject:[NSString stringWithFormat:@"%d%@", i,[self unitForStyle:SVHDatePickerComponentStyleYear]]];
        }
    }
    return _yearArr;
}

/// 获取月份
- (NSMutableArray *)monthArr {
    if (!_monthArr) {
        _monthArr = [NSMutableArray array];
        for (int i = 1; i <= 12; i ++) {
            [_monthArr addObject:[NSString stringWithFormat:@"%d%@", i,[self unitForStyle:SVHDatePickerComponentStyleMonth]]];
        }
    }
    return _monthArr;
}

/// 获取当前月的天数
- (NSMutableArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSMutableArray array];
        NSString* year = self.year?self.year:self.timeArr[0];
        NSString* month = self.month?self.month:self.timeArr[1];
        for (int i = 1; i < [self getDayNumber:year.integerValue month:month.integerValue].integerValue + 1; i ++) {
            [_dayArr addObject:[NSString stringWithFormat:@"%d%@", i,[self unitForStyle:SVHDatePickerComponentStyleDay]]];
        }
    }
    return _dayArr;
}

/// 获取小时
- (NSMutableArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSMutableArray array];
        for (int i = 0; i < 24; i ++) {
            [_hourArr addObject:[NSString stringWithFormat:@"%d%@", i,[self unitForStyle:SVHDatePickerComponentStyleHour]]];
        }
    }
    return _hourArr;
}

/// 获取分钟
- (NSMutableArray *)minuteArr {
    if (!_minuteArr) {
        _minuteArr = [NSMutableArray array];
        for (int i = 0; i <= 59; i ++) {
//            if (i % 5 == 0) {
                [_minuteArr addObject:[NSString stringWithFormat:@"%d%@", i,[self unitForStyle:SVHDatePickerComponentStyleMinute]]];
                continue;
//            }
        }
    }
    return _minuteArr;
}

// 获取当前的年月日时
- (NSArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [NSArray array];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy,MM,dd,HH,mm"];
        NSDate *date = [NSDate date];
        NSString *time = [formatter stringFromDate:date];
        _timeArr = [time componentsSeparatedByString:@","];
    }
    return _timeArr;
}

- (void)refreshDay {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < [self getDayNumber:self.year.integerValue month:self.month.integerValue].integerValue + 1; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d%@", i,[self unitForStyle:SVHDatePickerComponentStyleDay]]];
    }

    NSInteger component = [self componentIndexWithStyle:SVHDatePickerComponentStyleDay];
    self.dayArr = arr;
    [self.dataArray replaceObjectAtIndex:component withObject:arr];
    [self.pickerView reloadComponent:component];
}

- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        return @"29";
    }
    return days[month - 1];
}


@end
