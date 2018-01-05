//
//  YYDatePickerView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/12/4.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYDatePickerView.h"
#import "NSDate+YYExtension.h"

#define DateComponent 0
#define TimeDuratioComponent 1

#define YearComponent 0
#define MonthComponent 1
#define DayComponent 2

@interface YYDatePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *timeDurationArray;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@property (nonatomic, weak) UIPickerView *pickerView;

@end

@implementation YYDatePickerView
{
    YYDatePickerViewType _type;
    NSString *_date;
    NSString *_time;
    NSString *_year;
    NSString *_month;
    NSString *_day;
}

- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (NSMutableArray *)timeDurationArray {
    if (!_timeDurationArray) {
        _timeDurationArray = [NSMutableArray array];
    }
    return _timeDurationArray;
}

- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}


- (UIPickerView *)pickerView {
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, self.mj_h)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}

- (void)setType:(YYDatePickerViewType)type
{
    _type = type;
    switch (_type) {
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
            [self fetchDateAndTimeData];
            break;
        case YYDatePickerViewTypeBirthDay:
            [self fetchYearMonthDayData];
            break;
        case YYDatePickerViewTypeReturnDate:
            [self fetchReturnDateAndTime];
            break;
    }
    [self pickerView];
    WS(ws);
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
}

- (void)selectDefaultDate
{
    if (_didSelectDateAndTimeBlock) {
        _didSelectDateAndTimeBlock(_date, _time);
    }
}

- (void)fetchDateAndTimeData
{
    [self.dateArray removeAllObjects];
    NSDate *date = [NSDate date];
    NSInteger year = [NSDate year:date];
    NSInteger thisMonth = [NSDate month:date];
    NSInteger days = [NSDate totaldaysInThisMonth:date];
    NSInteger dayInThisMonth = [NSDate day:date];
    for (NSInteger i = dayInThisMonth; i <= days; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02ld-%02ld-%02ld", (long)year, (long)thisMonth, (long)i];
        [self.dateArray addObject:str];
    }
    
    NSDate *nextDate = [NSDate nextMonth:date];
    
    year = [NSDate year:nextDate];
    NSInteger nextMonth = [NSDate month:nextDate];
    days = [NSDate totaldaysInThisMonth:nextDate];
    
    for (NSInteger i = 1; i <= days; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02ld-%02ld-%02ld", (long)year, (long)nextMonth, (long)i];
        [self.dateArray addObject:str];
    }
    
    for (int i = 6; i <= 22; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02d:00~%02d:00", i, i + 1];
        i ++;
        [self.timeDurationArray addObject:str];
    }
    _date = _dateArray[0];
    _time = _timeDurationArray[0];
}

- (void)fetchYearMonthDayData
{
    NSDate *date = [NSDate date];
    NSInteger lastAdultYear = [NSDate year:date] - 16;
    
    for (NSInteger i = lastAdultYear - 60; i < lastAdultYear; i ++) {
        NSString *str = [NSString stringWithFormat:@"%@", @(i)];
        [self.yearArray addObject:str];
    }
    
    for (int i = 1; i <= 12; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02d", i];
        [self.monthArray addObject:str];
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *monthDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@%@01", self.yearArray[0], self.monthArray[0]]];
    NSInteger days = [NSDate totaldaysInMonth:monthDate];
    for (NSInteger i = 1; i < days; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02ld", (long)i];
        [self.dayArray addObject:str];
    }
    _year = self.yearArray[0];
    _month = self.monthArray[0];
    _day = self.dayArray[0];
}

- (void)fetchReturnDateAndTime
{
    [self.dateArray removeAllObjects];
    NSDate *date = [NSDate date];
    NSInteger year = [NSDate year:date];
    NSInteger thisMonth = [NSDate month:date];
    NSInteger days = [NSDate totaldaysInThisMonth:date];
    NSInteger dayInThisMonth = [NSDate day:date];
    
    for (NSInteger i = dayInThisMonth; i <= days; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02ld-%02ld-%02ld", year, (long)thisMonth, (long)i];
        [self.dateArray addObject:str];
        if ((i - dayInThisMonth) == 2) {
            break;
        }
    }
    NSInteger hour = [NSDate hour:date];
    NSInteger minute = [NSDate minute:date];
    hour = minute > 50 ? hour + 1 : hour;
    for (int i = hour; i <= 22; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02d:00~%02d:00", i, i + 1];
        i ++;
        [self.timeDurationArray addObject:str];
    }
    _date = self.dateArray[0];
    _time = self.timeDurationArray[0];
}

- (void)updateDaysInMonth:(NSString *)year month:(NSString *)month
{
    [self.dayArray removeAllObjects];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *monthDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@%@01", year, month]];
    NSInteger days = [NSDate totaldaysInMonth:monthDate];
    for (NSInteger i = 1; i < days; i ++) {
        NSString *str = [NSString stringWithFormat:@"%02ld", (long)i];
        [self.dayArray addObject:str];
    }
    [self.pickerView reloadComponent:DayComponent];
    [self.pickerView selectRow:0 inComponent:DayComponent animated:YES];
}

#pragma mark - UIPicker Delegate
#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (_type) {
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
        case YYDatePickerViewTypeReturnDate:
            return 2;
            break;
        case YYDatePickerViewTypeBirthDay:
            return 3;
            break;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (_type) {
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
        case YYDatePickerViewTypeReturnDate:
            switch (component) {
                case DateComponent:
                    return self.dateArray.count;
                    break;
                case TimeDuratioComponent:
                    return self.timeDurationArray.count;
                    break;
            }
            break;
        case YYDatePickerViewTypeBirthDay:
            switch (component) {
                case YearComponent:
                    return self.yearArray.count;
                    break;
                case MonthComponent:
                    return self.monthArray.count;
                    break;
                case DayComponent:
                    return self.dayArray.count;
                    break;
            }
            break;
    }
    
    return 0;
}

#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (_type) {
        case YYDatePickerViewTypeBirthDay:
            switch (component) {
                case YearComponent:
                    return self.yearArray[row];
                    break;
                case MonthComponent:
                    return self.monthArray[row];
                    break;
                case DayComponent:
                    return self.dayArray[row];
                    break;
            }
            break;
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
        case YYDatePickerViewTypeReturnDate:
            switch (component) {
                case DateComponent:
                    return self.dateArray[row];
                    break;
                case TimeDuratioComponent:
                    return self.timeDurationArray[row];
                    break;
            }
            break;
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (_type) {
        case YYDatePickerViewTypeBirthDay:
            switch (component) {
                case YearComponent:
                    _year = self.yearArray[row];
                    [self updateDaysInMonth:_year month:_month];
                    break;
                case MonthComponent:
                    _month = self.monthArray[row];
                    [self updateDaysInMonth:_year month:_month];
                    break;
                case DayComponent:
                    _day = self.dayArray[row];
                    break;
            }
            if (_didSelectBirthDayBlock) {
                _didSelectBirthDayBlock([NSString stringWithFormat:@"%@-%@-%@", _year, _month, _day]);
            }
            break;
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
        case YYDatePickerViewTypeReturnDate:
            switch (component) {
                case DateComponent:
                    _date = _dateArray[row];
                    break;
                case TimeDuratioComponent:
                    _time = _timeDurationArray[row];
                    break;
            }
            if (_didSelectDateAndTimeBlock) {
                _didSelectDateAndTimeBlock(_date, _time);
            }
            break;
    }
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (_type) {
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
        case YYDatePickerViewTypeReturnDate:
            return (WIN_WIDTH - RELATIVE_WIDTH(52)) / 2;
            break;
        case YYDatePickerViewTypeBirthDay:
            return (WIN_WIDTH - RELATIVE_WIDTH(72)) / 3;
            break;
    }
    return (WIN_WIDTH - RELATIVE_WIDTH(52)) / 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return RELATIVE_WIDTH(100);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = YYSeparatorColor;
        }
    }
    view.backgroundColor = [UIColor whiteColor];
    UILabel * myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
    myView.textColor = YYTextColor;
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
    myView.backgroundColor = [UIColor whiteColor];
    switch (_type) {
        case YYDatePickerViewTypeBirthDay:
            switch (component) {
                case YearComponent:
                    myView.text = self.yearArray[row];
                    break;
                case MonthComponent:
                    myView.text = self.monthArray[row];
                    break;
                case DayComponent:
                    myView.text = self.dayArray[row];
                    break;
            }
            break;
        case YYDatePickerViewTypeYearMonthDayTimeDuration:
        case YYDatePickerViewTypeReturnDate:
            switch (component) {
                case DateComponent:
                    myView.text = self.dateArray[row];
                    break;
                case TimeDuratioComponent:
                    myView.text = self.timeDurationArray[row];
                    break;
            }
            break;
    }
    
    return myView;
}




@end
