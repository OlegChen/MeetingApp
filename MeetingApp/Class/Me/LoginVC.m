//
//  LoginVC.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/25.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "LoginVC.h"
#import "LoginContainerView.h"

@interface LoginVC ()

@property (nonatomic,weak) LoginContainerView *container;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"containerView"])  {
        
        self.container = segue.destinationViewController;
    }

    
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
