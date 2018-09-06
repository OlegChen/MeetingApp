//
//  HomeCell.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/15.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.contentView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentView.layer.shadowRadius = 3;
    self.contentView.layer.shadowOpacity = 0.2;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 2);
    
}

- (IBAction)connectEd:(UIButton *)sender {
}

- (IBAction)connectService:(UIButton *)sender {
}

- (IBAction)ChangeClass:(UIButton *)sender {
    
    
    
    if ([self.homeDelegate respondsToSelector:@selector(changeClass:)]) {
        
        [self.homeDelegate changeClass:@""];
        
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
