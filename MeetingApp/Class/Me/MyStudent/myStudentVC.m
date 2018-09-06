//
//  myStudentVC.m
//  new_YundiPiano_teacher
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "myStudentVC.h"
#import "BasePullTableView.h"
#import "myStudentCell.h"


@interface myStudentVC ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>

@property (nonatomic, strong) BasePullTableView *studentTableview;


@end

@implementation myStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleL  = [[UILabel alloc]init];
    [self.view addSubview:titleL];
    titleL.font = [UIFont systemFontOfSize:21];
    titleL.textColor = [UIColor blackColor];
    titleL.text = @"我的学生";
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    
    _studentTableview = [[BasePullTableView alloc] init];
    _studentTableview.delegate = self;
    _studentTableview.dataSource = self;
    _studentTableview.pullDelegate = self;
    [self.view addSubview:_studentTableview];
    [_studentTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleL.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);\
        make.height.mas_equalTo(SCREEN_HEIGHT - NavHight - 40);
    }];
    
    [_studentTableview registerNib:[UINib nibWithNibName:@"myStudentCell" bundle:nil] forCellReuseIdentifier:myStudentCellID];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:myStudentCellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
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
