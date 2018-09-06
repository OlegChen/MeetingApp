//
//  TweetSendTextCell.m
//  YunDi_Student
//
//  Created by Chen on 16/10/4.
//  Copyright © 2016年 Fengyun Diyin Technologies (Beijing) Co., Ltd. All rights reserved.
//

#import "TweetSendTextCell.h"

@interface TweetSendTextCell ()<UITextViewDelegate>

@property (nonatomic ,weak) UILabel *TextNo;


@end

@implementation TweetSendTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        if (!_tweetContentView) {
            _tweetContentView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(7, 7, SCREEN_WIDTH-7*2, [TweetSendTextCell cellHeight]-10 - 20)];
            _tweetContentView.backgroundColor = [UIColor clearColor];
            _tweetContentView.font = normalContentFont;
            _tweetContentView.delegate = self;
            _tweetContentView.placeholder = @"请输入建议或投诉说明";
            _tweetContentView.returnKeyType = UIReturnKeyDefault;
            [self.contentView addSubview:_tweetContentView];
        }
        
        UIView  *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor myColorWithHexString:@"#999999"];
        line.alpha = 0.5;
        line.frame = CGRectMake(15, [TweetSendTextCell cellHeight] - 30, SCREEN_WIDTH - 30, 1 / [UIScreen mainScreen].scale);
        
        
        UILabel *NoLable = [[UILabel alloc]init];
        [self.contentView addSubview:NoLable];
        NoLable.textColor = [UIColor myColorWithHexString:@"#888888"];
        NoLable.text = @"0/200";
        NoLable.font = [UIFont systemFontOfSize:14];
        NoLable.textAlignment = NSTextAlignmentRight;
        self.TextNo = NoLable;
        
        
           }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.TextNo.frame = CGRectMake(SCREEN_WIDTH - 15 - 60, [TweetSendTextCell cellHeight] - 20, 60, 20);
}

- (void)dealloc{

}

#pragma mark TextView Delegate
- (void)textViewDidChange:(UITextView *)textView{
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(textView.text);
    }
    
    self.TextNo.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (CGFloat)cellHeight{
    CGFloat cellHeight;
    if (IS_IPHONE_5){
        cellHeight = 150;
    }else if (IS_IPHONE_6) {
        cellHeight = 150;
    }else if (IS_IPHONE_6_PLUS){
        cellHeight = 150;
    }else{
        cellHeight = 95;
    }
    return cellHeight + 30 /*字数说明*/;
}

@end
