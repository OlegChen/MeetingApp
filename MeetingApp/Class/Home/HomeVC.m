//
//  HomeVC.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/10.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "HomeVC.h"
#import "HMSegmentedControl.h"
#import "BasePullTableView.h"
#import "HomeSectionHeaderView.h"
#import "GPBannerView.h"

#import "ChangeClassVC.h"

#import "HomeCell.h"
#import "shopClassTableViewCell.h"
#import "calendarClassTableVC.h"

@interface HomeVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;

@property (nonatomic, strong) BasePullTableView *todayClassTableview;
@property (nonatomic, strong) calendarClassTableVC *calenderClassTable;

@end

@implementation HomeVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //    self.fd_prefersNavigationBarHidden = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    
    // Tying up the segmented control to a scroll view
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(15,0, SCREEN_WIDTH, 50)];
    self.segmentedControl4.sectionTitles = @[@"当天课表", @"日历"];
    self.segmentedControl4.selectedSegmentIndex = 0;
    self.segmentedControl4.backgroundColor = [UIColor whiteColor];
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor] , NSFontAttributeName : [UIFont systemFontOfSize: 18]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
    self.segmentedControl4.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    self.segmentedControl4.tag = 3;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl4];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, self.view.height - 50)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 200);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, 200) animated:NO];
    [self.view addSubview:self.scrollView];
    
    
    _todayClassTableview = [[BasePullTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
    _todayClassTableview.delegate = self;
    _todayClassTableview.dataSource = self;
    _todayClassTableview.pullDelegate = self;
    
    [self.scrollView addSubview:_todayClassTableview];
    
    _calenderClassTable = [[calendarClassTableVC alloc]init];
    [self.scrollView addSubview:_calenderClassTable.view];
    _calenderClassTable.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);

    
    [_todayClassTableview registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:HomeCellID];
    [_todayClassTableview registerNib:[UINib nibWithNibName:@"shopClassTableViewCell" bundle:nil] forCellReuseIdentifier:shopClassTableViewCellID];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
