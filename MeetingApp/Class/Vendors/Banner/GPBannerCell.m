//
//  GPBannerCell.m
//  Banner
//
//  Created by ggt on 2017/2/28.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "GPBannerCell.h"

@interface GPBannerCell ()

@property (nonatomic, weak) UIImageView *imageView; /**< 图片 */
@property (nonatomic, weak) UIImageView *newsTitleBackgroundImageView; /**< 新闻标题背景图片 */
@property (nonatomic, weak) UILabel *newsTitleLabel; /**< 新闻标题 */

@end

@implementation GPBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
    // 1.图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.cornerRadius = 6;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
}

- (void)setImageName:(NSString *)imageName {
    
    //判断网络图片 还是本地图片
    _imageName = imageName;
    
    if([imageName hasPrefix:@"http"]){
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@""]];
        
    }else{
        
        self.imageView.image = [UIImage imageNamed:imageName];

    }
    
}

@end
