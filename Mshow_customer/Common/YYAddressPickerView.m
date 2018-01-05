//
//  YYAddressPickerView.m
//  DDFood
//
//  Created by YZ Y on 16/7/12.
//  Copyright © 2016年 YZ Y. All rights reserved.
//

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

#import "YYAddressPickerView.h"

@interface YYAddressPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, weak) UIView *functionView;
@property(nonatomic, assign) CGFloat showOriginY;
@property(nonatomic, assign) CGFloat showHeight;
@property(nonatomic, copy) NSString  *sShowString;
@property(nonatomic, copy) NSString  *sCityString;
@end

@implementation YYAddressPickerView

{
    NSDictionary *areaDic;
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    NSString *selectedProvince;
    NSString *selectedCity;
    NSString *selectedDistrict;
    
    NSMutableArray *sProvince;
    NSMutableArray *sCity;
    NSMutableArray *sDistrict;
    
    NSInteger defaultIndex;

}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, RELATIVE_WIDTH(80), WIN_WIDTH, self.mj_h - RELATIVE_WIDTH(80))];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}

- (UIView *)functionView {
    if (!_functionView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, RELATIVE_WIDTH(100))];
        
        view.backgroundColor = mRGBToColor(0xf9f9f9);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        //mRGBToColor(0x0777ff)
        [button setTitleColor:YYGlobalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-RELATIVE_WIDTH(24));
            make.centerY.equalTo(view);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
    
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(34)];
        [cancelButton setTitleColor:YYGrayTextColor forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancelButton];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(RELATIVE_WIDTH(24));
            make.centerY.equalTo(view);
            make.width.greaterThanOrEqualTo(@0);
            make.height.mas_equalTo(RELATIVE_WIDTH(44));
        }];
        
        _functionView = view;
        [self addSubview:view];
    }
    return _functionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self getPickerData];
        self.backgroundColor = [UIColor whiteColor];
        self.showOriginY = self.mj_origin.y;
        self.showHeight  = self.mj_h;
        CGRect frame = self.frame;
        frame.origin.y = mScreenHeight;
        self.frame = frame;
        sProvince = [NSMutableArray array];
        sCity = [NSMutableArray array];
        sDistrict = [NSMutableArray array];
        self.pickerView.userInteractionEnabled = YES;
        self.functionView.userInteractionEnabled = YES;
        WS(ws);
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws).offset(-iPhone_MARGIN_BOTTOM);
            make.left.right.equalTo(ws);
            make.top.equalTo(ws).offset(RELATIVE_WIDTH(100));
        }];
    }
    return self;
}

#pragma mark - UIPicker Delegate
#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [provinceArr count];
    }
    else if (component == CITY_COMPONENT) {
        return [cityArr count];
    }
    else {
        return [districtArr count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT && provinceArr.count - 1 > row) {
        return [provinceArr objectAtIndex:row];
    }
    else if (component == CITY_COMPONENT && cityArr.count - 1 > row) {
        return [cityArr objectAtIndex:row];
    }
    else {
        if (districtArr.count - 1 > row) {
            return [districtArr objectAtIndex:row];
        }
    }
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        selectedProvince = [provinceArr objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", defaultIndex > 0 ? defaultIndex : (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int  i= 0; i < [sortedArray count]; i ++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        [sProvince removeAllObjects];
        [sProvince addObjectsFromArray:provinceArr];
        
//        cityArr = [[NSArray alloc] initWithArray: array];
        for (NSString *cityIndex in cityArray) {
            NSDictionary *cityDict = [dic objectForKey:cityIndex];
            NSArray *cityKeys = [cityDict allKeys];
            for (NSString *cityName in cityKeys) {
                if ([cityName isEqualToString:@"南京市"]) {
                    cityArr = [[NSArray alloc] initWithArray: [cityDict allKeys]];
                    break;
                }
            }
        }
        [sCity removeAllObjects];
        [sCity addObjectsFromArray:cityArr];
        
        
        selectedCity = [cityArr firstObject];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        districtArr = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityArr objectAtIndex: 0]]];
        [sDistrict removeAllObjects];
        [sDistrict addObjectsFromArray:districtArr];
        
        selectedDistrict = [districtArr firstObject];
        
        [_pickerView selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [_pickerView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [_pickerView reloadComponent: CITY_COMPONENT];
        [_pickerView reloadComponent: DISTRICT_COMPONENT];
        [self didSelectProvince:(int)row city:0 district:0 scroll:NO];
    }
    else if (component == CITY_COMPONENT) {
        selectedCity = [cityArr objectAtIndex:row];
//        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (unsigned long)[provinceArr indexOfObject: selectedProvince]];
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (unsigned long)defaultIndex];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        [sCity removeAllObjects];
        [sCity addObjectsFromArray:cityArr];
        districtArr = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [sDistrict removeAllObjects];
        [sDistrict addObjectsFromArray:districtArr];
        selectedDistrict = [districtArr firstObject];
        
        [_pickerView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [_pickerView reloadComponent: DISTRICT_COMPONENT];
        [self didSelectProvince:[provinceIndex intValue] city:(int)row district:0 scroll:NO];
    }
    else {
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (unsigned long)[provinceArr indexOfObject: selectedProvince]];
        NSString *cityIndex     = [NSString stringWithFormat: @"%ld", (unsigned long)[cityArr indexOfObject: selectedCity]];
        selectedDistrict = [districtArr objectAtIndex:row];
        [sProvince removeAllObjects];
        [sProvince addObjectsFromArray:provinceArr];
        [sCity removeAllObjects];
        [sCity addObjectsFromArray:cityArr];
        [sDistrict removeAllObjects];
        [sDistrict addObjectsFromArray:districtArr];
        [self didSelectProvince:[provinceIndex intValue] city:[cityIndex intValue] district:(int)row scroll:NO];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 100;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 100;
    }
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
    
    UILabel *myView = nil;
    if (component == PROVINCE_COMPONENT && provinceArr.count - 1 >= row) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [provinceArr objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:17];
        myView.backgroundColor = [UIColor whiteColor];
    }
    else if (component == CITY_COMPONENT && cityArr.count - 1 >= row) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [cityArr objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:17];
        myView.backgroundColor = [UIColor whiteColor];
    }
    else {
        if (districtArr.count - 1 >= row) {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
            myView.textAlignment = NSTextAlignmentCenter;
            myView.text = [districtArr objectAtIndex:row];
            myView.font = [UIFont systemFontOfSize:17];
            myView.backgroundColor = [UIColor whiteColor];
        }
        
    }
    return myView;
}

- (void)didSelectProvince:(int)row0 city:(int)row1 district:(int)row2 scroll:(BOOL)scroll
{
    if (sProvince.count == 0 || sCity.count == 0 || sDistrict.count == 0) {
        return;
    }
    if (sProvince.count < row0 || sCity.count < row1 || sDistrict.count < row2) {
        return;
    }
    [self.pickerView reloadAllComponents];
    if (scroll)
    {
        [self.pickerView selectRow:row0 inComponent:0 animated:YES];
        [self.pickerView selectRow:row1 inComponent:1 animated:YES];
        [self.pickerView selectRow:row2 inComponent:2 animated:YES];
    }
    NSString *_province = [NSString isNull:[sProvince objectAtIndex:row0]];
    NSString *_city     = [NSString isNull:[sCity objectAtIndex:row1]];
    NSString *_district = [NSString isNull:[sDistrict objectAtIndex:row2]];
    
    NSString *cityString = nil;
    NSString *showString = nil;
    if ([_province isEqualToString:_city]) {
        cityString = AppendString(_city, _district);
        showString = AppendString(_city, _district);
    } else {
        cityString = [NSString stringWithFormat:@"%@%@%@", _province, _city, _district];
        showString = [NSString stringWithFormat:@"%@-%@-%@", _province, _city, _district];
    }
   
    
    self.sShowString = showString;
    self.sCityString = cityString;
    
    if (_delegate && [_delegate respondsToSelector:@selector(getCity: showString:)]) {
        [_delegate getCity:cityString showString:showString];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(getProvince:city:district:)]) {
        if (self.sCityString == nil && self.sShowString == nil) {
            [_delegate getProvince:@"江苏省" city:@"南京市" district:@"玄武区"];
        } else {
            [_delegate getProvince:selectedProvince city:selectedCity district:selectedDistrict];
        }
    }
}

- (void)scrollSelectRow
{
    NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (long)[self isContainObj:sProvince obj:selectedProvince]];
    NSString *cityIndex     = [NSString stringWithFormat: @"%ld", (long)[self isContainObj:sCity obj:selectedCity]];
    NSString *districtIndex = [NSString stringWithFormat: @"%ld", (long)[self isContainObj:sDistrict obj:selectedDistrict]];
    [self didSelectProvince:[provinceIndex intValue] city:[cityIndex intValue] district:[districtIndex intValue] scroll:YES];
}

- (NSInteger)isContainObj:(NSArray*)contain obj:(NSString*)obj
{
    if ([contain containsObject: obj]) {
        return [[NSString stringWithFormat: @"%ld", (unsigned long)[contain indexOfObject:obj]] integerValue];
    }
    return 0;
}

- (void)showPicker
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HPSetTableFrame" object:@"1"];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self setFrame:CGRectMake(0, self.showOriginY, mScreenWidth, self.showHeight)];
    }];
}

- (void)hidePicker
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HPSetTableFrame" object:@"0"];
    [UIView animateWithDuration:0.25 animations:^{
        [self setFrame:CGRectMake(0, mScreenHeight, mScreenWidth, self.showHeight)];
    }];
}

- (void)cityStringHaveNoDataHideView {
    [self hidePicker];
    if (self.sCityString == nil && self.sShowString ==nil) {
        if (_delegate && [_delegate respondsToSelector:@selector(getCity: showString:)]) {
            [_delegate getCity:@"江苏省南京市玄武区" showString:@"江苏省-南京市-玄武区"];
        }
    }
    
}

- (void)getPickerData {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i = 0; i < [sortedArray count]; i ++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    NSMutableArray *defaultProvinces = [NSMutableArray array];
    defaultIndex = 0;
    for (NSString *province in provinceTmp) {
        if ([province isEqualToString:@"江苏省"]) {
            [defaultProvinces addObject:province];
            defaultIndex = [provinceTmp indexOfObject:province];
            break;
        }
    }
    
//    provinceArr = [[NSArray alloc] initWithArray:provinceTmp];
    provinceArr = [NSArray arrayWithArray:defaultProvinces];
    [sProvince removeAllObjects];
    [sProvince addObjectsFromArray:provinceArr];
    
    
//    NSString *index = [sortedArray objectAtIndex:0];
    NSString *index = [sortedArray objectAtIndex:defaultIndex];
    NSString *selected = [provinceArr objectAtIndex:0];
//    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
//    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
//    cityArr = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    NSLog(@"asadasd%@",cityArr);
    
    NSDictionary *defaultCityDic = nil;
    for (NSString *cityIndex in cityArray) {
        NSDictionary *cityDict = [dic objectForKey:cityIndex];
        NSArray *cityKeys = [cityDict allKeys];
        for (NSString *cityName in cityKeys) {
            if ([cityName isEqualToString:@"南京市"]) {
                defaultCityDic = cityDict;
                cityArr = [[NSArray alloc] initWithArray: [cityDict allKeys]];
                break;
            }
        }
    }
    
    
    selectedCity = [cityArr objectAtIndex: 0];
//    districtArr = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    districtArr = [[NSArray alloc] initWithArray: [defaultCityDic objectForKey: selectedCity]];
    selectedProvince = [provinceArr objectAtIndex: 0];
}


#pragma mark - ButtonAction
- (void)sureButtonAction
{
    [self hidePicker];
    if (_delegate && [_delegate respondsToSelector:@selector(clickSureButtonShowProvince:city:district:)]) {
        if (self.sCityString == nil && self.sShowString == nil) {
//            [_delegate clickSureButton:@"江苏省南京市玄武区" showString:@"江苏省-南京市-玄武区"];
            [_delegate clickSureButtonShowProvince:@"江苏省" city:@"南京市" district:@"玄武区"];
        } else {
            [_delegate clickSureButtonShowProvince:selectedProvince city:selectedCity district:selectedDistrict];
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(getProvince:city:district:)]) {
        if (self.sCityString == nil && self.sShowString ==nil) {
            [_delegate getProvince:@"江苏省" city:@"南京市" district:@"玄武区"];
        } else {
            [_delegate getProvince:selectedProvince city:selectedCity district:selectedDistrict];
        }
    }
}

- (void)cancelAction
{
    [self hidePicker];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HPSetTableFrame" object:nil];
    
}

@end
