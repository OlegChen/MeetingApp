//
//  ChangeClassVC.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/30.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "ChangeClassVC.h"
#import "changeClassCell.h"
#import "FSCalendar.h"


@interface ChangeClassVC ()<FSCalendarDataSource, FSCalendarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;


@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (weak, nonatomic) UILabel *timeL;


@end

@implementation ChangeClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"全部课程";
    title.font = [UIFont systemFontOfSize:21];
    
    [self.view addSubview:title];
    title.frame = CGRectMake(15, 20, 100, 25);
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"changeClassCell" bundle:nil] forCellReuseIdentifier:changeClassCellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(title.mas_bottom).offset(10);
    }];
    
    
    self.tableView.tableHeaderView = ({
        
       UIView *view = [[UIView alloc]init];
        view.height = 50;
        view.backgroundColor = [UIColor myColorWithHexString:@"ffe7e7"];
        
        UILabel *tip = [[UILabel alloc]init];
        tip.text = @"您还有4次调课机会";
        tip.font = [UIFont boldSystemFontOfSize:16];
        tip.textColor = [UIColor myColorWithHexString:@"#404040"];
        [view addSubview:tip];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view).offset(0);
        }];
        
        
        view;
    });
    
    self.tableView.tableFooterView = ({
        
       UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor myColorWithHexString:@"#fbfbfb"];
        view.clipsToBounds = YES;
        [view addSubview:self.calendar];
        
        view.height = 450;
        
        
        UIView *selectView = [[UIView alloc]init];
        [view addSubview:selectView];
        [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view).offset(0);
            make.top.equalTo(self.calendar.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        UILabel *tip = [[UILabel alloc]init];
        tip.text = @"希望本节课上课时间";
        tip.font = [UIFont systemFontOfSize:16];
        tip.textColor = [UIColor myColorWithHexString:@"#404040"];
        [selectView addSubview:tip];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(selectView).offset(15);
            make.centerY.equalTo(selectView).offset(0);
        }];
        
        UIImageView *img = [[UIImageView alloc]init];
        [selectView addSubview:img];
        img.image = [UIImage imageNamed:@"nextArrow"];
        img.contentMode = UIViewContentModeCenter;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(selectView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.centerY.equalTo(selectView).offset(0);
        }];
        
        
        UILabel *timeL = [[UILabel alloc]init];
        self.timeL = timeL;
        timeL.textAlignment = NSTextAlignmentRight;
        timeL.text = @"请选择";
        timeL.font = [UIFont systemFontOfSize:16];
        timeL.textColor = [UIColor myColorWithHexString:@"#666666"];
        [selectView addSubview:timeL];
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(img.mas_left).offset(-10);
            make.centerY.equalTo(selectView).offset(0);
        }];
        
        
        
        UIButton *selectBtn = [[UIButton alloc]init];
        selectView.backgroundColor = [UIColor whiteColor];
        [selectView addSubview:selectBtn];
        [selectBtn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(selectView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
        UIButton *sureBtn = [[UIButton alloc]init];
        CAShapeLayer *layer  = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, SCREEN_WIDTH - 30, 45) cornerRadius:4];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor myColorWithHexString:@"d63135"].CGColor;
        [sureBtn.layer addSublayer:layer];
        
        [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [view addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selectView.mas_bottom).offset(26);
            make.left.equalTo(view).offset(15);
            make.right.equalTo(view).offset(-15);
            make.height.mas_equalTo(45);
        }];
        
        sureBtn.layer.shadowColor = [UIColor myColorWithHexString:@"d63135"].CGColor;
        sureBtn.layer.shadowOffset = CGSizeMake(0, 2);
        sureBtn.layer.shadowRadius = 4;
        sureBtn.layer.shadowOpacity = 0.5;
        
        
        view;
    });
    
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        self.calendar.height = 400;
    }
    
}

- (void)selectTime{
    
    
    
}

- (void)sureBtnClick{
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    changeClassCell *cell = [tableView dequeueReusableCellWithIdentifier:changeClassCellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 155;
    
}

- (FSCalendar *)calendar {
    
    if (!_calendar) {
        
        // 400 for iPad and 300 for iPhone
        CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 400 : 300;
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(10, -30, CGRectGetWidth(self.view.frame) - 20, height)];
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
        _calendar.appearance.selectionColor = [UIColor myColorWithHexString:@"#404040"];
        
        //设置当天的字体颜色
        _calendar.appearance.todayColor = [UIColor redColor];
    }
    return _calendar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
