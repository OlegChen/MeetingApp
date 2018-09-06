//
//  HomeSectionHeaderView.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/15.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@implementation HomeSectionHeaderView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
}


- (IBAction)all:(id)sender {
    
    if (self.block) {
        
        self.block();
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
