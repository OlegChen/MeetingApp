//
//  HomeSectionHeaderView.h
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/15.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^allDetail) (void);

static NSString * const HomeSectionHeaderViewId = @"HomeSectionHeaderView_id";

@interface HomeSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic,copy) allDetail block;

@end
