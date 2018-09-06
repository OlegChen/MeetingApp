//
//  MoneyVC.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/28.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "MoneyVC.h"

@interface MoneyVC ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *payBtn;



@end

@implementation MoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.bottomView.layer.shadowRadius = 5;
    self.bottomView.layer.shadowOpacity = 0.5;
    self.bottomView.layer.shadowOffset = CGSizeMake(0, -2);
    

    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 128, 45) cornerRadius:4];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor myColorWithHexString:@"#e71f33"].CGColor;
    [self.payBtn.layer addSublayer:layer];
    
    
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payBtn.cornerRadius = 4;
    
    self.payBtn.layer.shadowColor = [UIColor myColorWithHexString:@"#e71f33"].CGColor;
    self.payBtn.layer.shadowRadius = 4;
    self.payBtn.layer.shadowOpacity = 0.4;
    self.payBtn.layer.shadowOffset = CGSizeMake(0, 2);
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
