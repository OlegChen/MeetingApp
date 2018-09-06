//
//  TweetSendImagesCell.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-9-9.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#define kCCellIdentifier_TweetSendImage @"TweetSendImageCCell"
#import "TweetSendImagesCell.h"
#import "TweetSendImageCCell.h"
#import "UICustomCollectionView.h"
#import "MJPhotoBrowser.h"

@interface TweetSendImagesCell ()
@property (strong, nonatomic) UICustomCollectionView *mediaView;
@property (strong, nonatomic) NSMutableDictionary *imageViewsDict;

@property (nonatomic ,weak) UILabel *tip;

@end

@implementation TweetSendImagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.backgroundColor = [UIColor grayColor];
        
        //title
        UILabel *title = [[UILabel alloc]init];
        [self.contentView addSubview:title];
        title.text = @"上传图片";
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = [UIColor myColorWithHexString:@"#555555"];
        title.frame = CGRectMake(15, 0, SCREEN_WIDTH, 20);
        
        
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.mediaView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 2* 10, 80) collectionViewLayout:layout];
            self.mediaView.scrollEnabled = NO;
            [self.mediaView setBackgroundView:nil];
            [self.mediaView setBackgroundColor:[UIColor clearColor]];
            [self.mediaView registerClass:[TweetSendImageCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetSendImage];
            self.mediaView.dataSource = self;
            self.mediaView.delegate = self;
            [self.contentView addSubview:self.mediaView];
        }
        if (!_imageViewsDict) {
            _imageViewsDict = [[NSMutableDictionary alloc] init];
        }
        
        //tip  Label
        UILabel *tip = [[UILabel alloc]init];
        [self.contentView addSubview:tip];
        self.tip = tip;
        tip.textColor = [UIColor myColorWithHexString:@"#888888"];
        tip.font = [UIFont systemFontOfSize:14];
        tip.text = @"还可以上传6张图片";
        
    }
    return self;
}
- (void)setCurTweet:(NSArray *)curTweet{
    if (_curTweet != curTweet) {
        _curTweet = curTweet;
    }
    [self.mediaView setHeight:[TweetSendImagesCell cellHeightWithObj:_curTweet.count]];
    self.tip.text = [NSString stringWithFormat:@"还可以上传%lu张图片",(6 - curTweet.count)];
    [_mediaView reloadData];
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
//- (void)setCurTweet:(Tweet *)curTweet{
//    if (_curTweet != curTweet) {
//        _curTweet = curTweet;
//    }
//    [self.mediaView setHeight:[TweetSendImagesCell cellHeightWithObj:_curTweet]];
//    [_mediaView reloadData];
//}
+ (CGFloat)cellHeightWithObj:(NSInteger)obj{
    CGFloat cellHeight = 0;
//    if (obj > 0) {
        NSInteger row;
        if (obj <= 0) {
            row = 1;
        }else{
            row = ceilf((float)(obj +1)/4.0);
        }
        cellHeight = ([TweetSendImageCCell ccellSize].height +10) *row;
//    }
    return cellHeight + 30 /* 底部提示 */ + 20 /*顶部 title*/;
}

#pragma mark Collection M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = _curTweet.count;
    return num < 6? num+ 1: num;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    
    TweetSendImageCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_TweetSendImage forIndexPath:indexPath];
    if (indexPath.row < _curTweet.count) {
    
        ccell.curTweetImg = _curTweet[indexPath.row];
    }else{
        ccell.curTweetImg = nil;
    }
    ccell.deleteTweetImageBlock = ^(UIImage *toDelete){
        if (weakSelf.deleteTweetImageBlock) {
            weakSelf.deleteTweetImageBlock(indexPath.row);
        }
    };
    [_imageViewsDict setObject:ccell.imgView forKey:indexPath];
    return ccell;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.tip.frame = CGRectMake(15, self.height - 30, SCREEN_WIDTH - 15, 30);
    

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [TweetSendImageCCell ccellSize];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _curTweet.count) {
        if (_addPicturesBlock) {
            _addPicturesBlock();
        }
    }else{
//        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:_curTweet.count];
//        for (int i = 0; i < _curTweet.count; i++) {
//            UIImage *imageItem = _curTweet[i];
//            MJPhoto *photo = [[MJPhoto alloc] init];
//            photo.srcImageView = [_imageViewsDict objectForKey:indexPath]; // 来源于哪个UIImageView
//            photo.image = imageItem; // 图片路径
//            [photos addObject:photo];
//        }
//        // 2.显示相册
//        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//        browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
//        browser.photos = photos; // 设置所有的图片
//        browser.showSaveBtn = NO;
//        [browser show];
        
        
        
        //        显示大图
        int count = (int)_curTweet.count;
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i<count; i++) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:_curTweet[i]]; // 图片路径
            [photos addObject:photo];
        }
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
        [browser show];

        
    }
}


@end
