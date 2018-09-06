//
//  TweetSendTextCell.h
//  YunDi_Student
//
//  Created by Chen on 16/10/4.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"


#define kCCellIdentifier_TweetSendText @"TweetSendImageCCell"


@interface TweetSendTextCell : UITableViewCell

@property (strong, nonatomic) UIPlaceHolderTextView *tweetContentView;


@property (nonatomic ,copy) void (^textValueChangedBlock) (NSString *changeValue);


+ (CGFloat)cellHeight;

@end
