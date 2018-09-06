//
//  myStudentCell.m
//  new_YundiPiano_teacher
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "myStudentCell.h"

@interface myStudentCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *weekView;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *classType;
@property (weak, nonatomic) IBOutlet UILabel *classTimeL;


@end

@implementation myStudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 2);
    self.bgView.layer.shadowRadius = 4;
    self.bgView.layer.shadowOpacity = 0.5;
    
    
}

- (void)setClassWeekTimeArr:(NSArray *)arr{
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
