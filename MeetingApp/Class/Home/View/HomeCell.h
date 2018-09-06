//
//  HomeCell.h
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/15.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const HomeCellID = @"HomeCell_id";


@protocol HomeCellDelegate <NSObject>

- (void)changeClass:(NSString *)ClassId;

@end


@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UILabel *classTitleL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *classTypeL;


@property (nonatomic,weak) id <HomeCellDelegate> homeDelegate;

@end
