//
//  YYSelectDateView.m
//  Mshow_customer
//
//  Created by YYZ on 2017/11/24.
//  Copyright © 2017年 YYZ. All rights reserved.
//

#import "YYSelectDateView.h"
#import "YYSelectDateViewCell.h"
#import "YYSelectDateViewFlowLayout.h"
#import "NSDate+YYExtension.h"

static NSString *const cellID = @"YYSelectDateViewCellID";

@interface YYSelectDateView() <UICollectionViewDelegate, UICollectionViewDataSource, YYSelectDateViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *infoLabel;
@property (nonatomic, weak) UIButton *previousButton;
@property (nonatomic, weak) UIButton *nextButton;

@end

@implementation YYSelectDateView

{
    NSArray *_weekDayArray;
    NSDate *_today;
    NSDate *_date;
    NSInteger _nextMonth;
    NSIndexPath *_lastIndexPath;
    NSInteger _dayForRecieve;
    NSInteger _currentYear;
    NSInteger _currentMonth;
    
    NSDate *_dateForRecieve;
    NSDate *_dateForReturn;
    
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UILabel *dateLabel = [UILabel new];
        dateLabel.backgroundColor = [UIColor whiteColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(30)];
        dateLabel.textColor = YYTextColor;
        [view addSubview:dateLabel];
        _dateLabel = dateLabel;
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(RELATIVE_WIDTH(32));
            make.width.greaterThanOrEqualTo(@0);
            make.centerX.equalTo(view);
            make.top.equalTo(view).offset(RELATIVE_WIDTH(20));
        }];
        
        UILabel *infoLabel = [UILabel new];
        infoLabel.backgroundColor = [UIColor whiteColor];
        infoLabel.textColor = YYGrayTextColor;
        infoLabel.font = [UIFont systemFontOfSize:RELATIVE_WIDTH(24)];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.text = @"点击日期设置收货和归还时间";
        [view addSubview:infoLabel];
        _infoLabel = infoLabel;
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(dateLabel.mas_bottom).offset(RELATIVE_WIDTH(8));
            make.centerX.equalTo(view);
            make.height.mas_equalTo(RELATIVE_WIDTH(26));
            make.width.greaterThanOrEqualTo(@0);
        }];
        
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [previousButton setImage:[UIImage imageNamed:@"img_arrow_left"] forState:UIControlStateNormal];
        [previousButton addTarget:self action:@selector(previousAction) forControlEvents:UIControlEventTouchUpInside];
        previousButton.hidden = YES;
        [view addSubview:previousButton];
        _previousButton = previousButton;
        _previousButton.hidden = YES;
        [previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(dateLabel.mas_left).offset(-RELATIVE_WIDTH(8));
            make.width.height.mas_equalTo(RELATIVE_WIDTH(28));
            make.centerY.equalTo(dateLabel);
        }];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"img_arrow_right"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:nextButton];
        _nextButton = nextButton;
        
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(dateLabel.mas_right).offset(RELATIVE_WIDTH(8));
            make.centerY.equalTo(dateLabel);
            make.width.height.mas_equalTo(RELATIVE_WIDTH(28));
        }];
        
        _headerView = view;
    }
    return _headerView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        YYSelectDateViewFlowLayout *flowLayout = [[YYSelectDateViewFlowLayout alloc] init];
        CGFloat itemWidth = self.mj_w / 7;
        flowLayout.itemSize = CGSizeMake(itemWidth, RELATIVE_WIDTH(86));
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        view.delegate = self;
        view.dataSource = self;
        view.scrollEnabled = NO;
        view.backgroundColor = [UIColor whiteColor];
        [view registerClass:[YYSelectDateViewCell class] forCellWithReuseIdentifier:cellID];
        
        UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction)];
        swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [view addGestureRecognizer:swipLeft];
        
        UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousAction)];
        swipRight.direction = UISwipeGestureRecognizerDirectionRight;
        [view addGestureRecognizer:swipRight];
        
        [self addSubview:view];
        _collectionView = view;
        
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _weekDayArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        _today = [NSDate date];
        _date = _today;
        _nextMonth = 0;
        _currentMonth = [NSDate month:_date];
        _currentYear = [NSDate year:_date];
        [self collectionView];
        [self headerView];
        self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月", @([NSDate year:_date]), @([NSDate month:_date])];
        WS(ws);
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(ws);
            make.height.mas_equalTo(RELATIVE_WIDTH(100));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(ws);
            make.top.equalTo(self.headerView.mas_bottom);
        }];
    }
    return self;
}

- (void)setDateForRecieve:(NSDate *)dateForRecieve
{
    if (dateForRecieve != nil) {
        _dateForRecieve = dateForRecieve;
        [self.collectionView reloadData];
    }
    
}

- (void)setDuration:(NSUInteger)duration
{
    _duration = duration;
    _dateForReturn = [NSDate computeDateWithDays:duration date:_dateForRecieve];
    [self.collectionView reloadData];
}

- (void)setHideInfoLabel:(BOOL)hideInfoLabel
{
    _hideInfoLabel = hideInfoLabel;
    self.infoLabel.hidden = hideInfoLabel;
}

- (void)reloadUI
{
    _currentYear = [NSDate year:_date];
    _currentMonth = [NSDate month:_date];
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月", @(_currentYear), @(_currentMonth)];
    [self.collectionView reloadData];
}

- (void)previousAction
{
    if (_nextMonth) {
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _date = [NSDate lastMonth:_date];
            [self reloadUI];
            _nextMonth --;
            self.previousButton.hidden = _nextMonth == 0;
        } completion:nil];
    }
}

- (void)nextAction
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) {
        _date = [NSDate nextMonth:_date];
        [self reloadUI];
        self.previousButton.hidden = NO;
        _nextMonth ++;
    } completion:nil];
}



#pragma mark - UICollectionViewDataSource/Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    }
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYSelectDateViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.type = YYSelectDateViewCellTypeWeakDay;
        cell.dateLabel.text = _weekDayArray[indexPath.item];
        cell.dateLabel.textColor = YYTextColor;
        cell.backgroundColor = YYSeparatorColor;
    } else {
        cell.type = YYSelectDateViewCellTypeDay;
        cell.backgroundColor = [UIColor whiteColor];
        NSInteger daysInThisMonth = [NSDate totaldaysInMonth:_date];
        NSInteger firstWeekday = [NSDate firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.item;
        
        if (i < firstWeekday || i > firstWeekday + daysInThisMonth - 1) {
            cell.dateLabel.text = @"";
        } else {
            NSUInteger todayNumber = [NSDate day:_date];
            day = i - firstWeekday + 1;
            cell.dateLabel.text = [NSString stringWithFormat:@"%@", @(day)];
            cell.dateLabel.textColor = YYDisableColor;
            //this month
            //[_today isEqualToDate:_date]
            if (_nextMonth == 0) {
                if (day == todayNumber) {
                    cell.type = YYSelectDateViewCellTypeToday;
                    cell.dateLabel.textColor = YYDisableColor;
                } else if (day > todayNumber) {
                    cell.dateLabel.textColor = YYTextColor;
                }
            } else if ([_today compare:_date] == NSOrderedAscending) {
                cell.dateLabel.textColor = YYTextColor;
            } else {
                cell.dateLabel.textColor = YYDisableColor;
            }
            
            if (_dayForRecieve > 0 || _dateForRecieve != nil) {
                NSString *dayStr = [NSString stringWithFormat:@"%@%02ld%02ld", @(_currentYear), (long)_currentMonth, (long)day];
                NSDate *dayDate = [NSDate dateFromString:dayStr dateFormate:@"yyyyMMdd"];
                
                if ([dayDate compare:_dateForRecieve] == NSOrderedSame) {
                    cell.type = YYSelectDateViewCellTypeDateForRecieve;
                    _lastIndexPath = indexPath;
                }
                if (_duration > 0) {
                    if ([dayDate compare:_dateForReturn] == NSOrderedSame) {
                        cell.type = YYSelectDateViewCellTypeDateForReturn;
                    } else if (([dayDate compare:_dateForRecieve] == NSOrderedDescending) && ([dayDate compare:_dateForReturn] == NSOrderedAscending)){
                        cell.type = YYSelectDateViewCellTypeDateInDuration;
                    }
                }
            }
            
        }
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hideInfoLabel) {
        if (indexPath.section == 1) {
            NSInteger daysInThisMonth = [NSDate totaldaysInMonth:_date];
            NSInteger firstWeekday = [NSDate firstWeekdayInThisMonth:_date];
            
            NSInteger day = 0;
            NSInteger i = indexPath.item;
            
            if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
                day = i - firstWeekday + 1;
                
                //this month
                if (_nextMonth == 0) {
                    if (day == [NSDate day:_date]) {
                        return YES;
                    } else if (day > [NSDate day:_date]) {
                        return YES;
                    }
                } else if ([_today compare:_date] == NSOrderedAscending) {
                    return YES;
                }
            }
        }
        return NO;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_lastIndexPath) {
        _lastIndexPath = indexPath;
    } else if (_lastIndexPath.item != indexPath.item) {
        YYSelectDateViewCell *cell = (YYSelectDateViewCell *)[collectionView cellForItemAtIndexPath:_lastIndexPath];
        cell.type = YYSelectDateViewCellTypeDay;
        
        _lastIndexPath = indexPath;
    }
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_date];
    NSInteger firstWeekday = [NSDate firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.item;
    day = i - firstWeekday + 1;
    //计算收货日期
    NSString *recieveDayStr = [NSString stringWithFormat:@"%@%02ld%02ld", @(_currentYear), (long)_currentMonth, (long)day];
    _dateForRecieve = [NSDate dateFromString:recieveDayStr dateFormate:@"yyyyMMdd"];
    _dayForRecieve = day;
    if (_dayForRecieve != day) {
        //计算归还日期
        if (_duration > 0) {
            _dateForReturn = [NSDate computeDateWithDays:_duration date:_dateForRecieve];
            [self.collectionView reloadData];
        }
    }
    YYSelectDateViewCell *cell = (YYSelectDateViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.type = YYSelectDateViewCellTypeDateForRecieve;
    
    if (_selectDateBlock) {
        _selectDateBlock(day, [comp month], [comp year]);
    }
    
}

#pragma mark - YYSelectDateViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section
{
    return [@[
              YYSeparatorColor,
              [UIColor whiteColor]
              ] objectAtIndex:section];
}



@end
