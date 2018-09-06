//
//  calendarClassTableVC.m
//  new_YundiPiano_teacher
//
//  Created by Apple on 2018/6/1.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "calendarClassTableVC.h"

#import "FSCalendar.h"
#import "BasePullTableView.h"
#import "HomeCell.h"
#import "shopClassTableViewCell.h"


@interface calendarClassTableVC ()<FSCalendarDataSource, FSCalendarDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>
{
    void * _KVOContext;
}


@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;


@property (nonatomic,strong) BasePullTableView *tableview;

@end

@implementation calendarClassTableVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"全部课程";
    title.font = [UIFont systemFontOfSize:21];
    
    [self.view addSubview:title];
    title.frame = CGRectMake(15, 20, 100, 25);
    
    
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        self.calendar.height = 400;
    }
    
    [self.view addSubview:self.calendar];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
    // While the scope gesture begin, the pan gesture of tableView should cancel.
    [self.tableview.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    
    self.calendar.scope = FSCalendarScopeMonth;
    
    
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.calendar.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view).offset(0);
        
    }];
    
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>   下部滚动设置  待写

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableview.contentOffset.y <= -self.tableview.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}


#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //    NSLog(@"%@",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"));
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    [self.view layoutIfNeeded];
    
#pragma mark - shezh
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID];
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
    
}


- (void)pullTableViewDidTriggerRefresh:(BasePullTableView *)pullTableView{
    
    
    
}




- (FSCalendar *)calendar {
    
    if (!_calendar) {
        
        // 400 for iPad and 300 for iPhone
        CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 400 : 300;
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(10, -30, CGRectGetWidth(self.view.frame)-20, height)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        //设置翻页方式为水平
        _calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
        //设置是否用户多选
        _calendar.allowsMultipleSelection = NO;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesDefaultCase;
        //        这个属性控制"上个月"和"下个月"标签在静止时刻的透明度
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.backgroundColor = [UIColor whiteColor];
        //设置周字体颜色
        _calendar.appearance.weekdayTextColor = [UIColor blackColor];
        //设置头字体颜色
        _calendar.appearance.headerTitleColor = [UIColor whiteColor];
        
        
        //设置当天的字体颜色
        _calendar.appearance.todayColor = [UIColor redColor];
    }
    return _calendar;
}

- (NSDateFormatter *)dateFormatter{
    
    if (!_dateFormatter) {
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BasePullTableView *)tableview{
    
    if (!_tableview) {
        
        _tableview = [[BasePullTableView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.pullDelegate = self;
        _tableview.mj_footer == nil;
        [_tableview registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:HomeCellID];
        [_tableview registerNib:[UINib nibWithNibName:@"shopClassTableViewCell" bundle:nil] forCellReuseIdentifier:shopClassTableViewCellID];

        
    }
    return  _tableview;
}

@end
