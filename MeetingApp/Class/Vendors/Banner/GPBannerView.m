//
//  GPBannerView.m
//  Banner
//
//  Created by ggt on 2017/3/1.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "GPBannerView.h"
#import "GPBannerLayout.h"
#import "GPBannerCell.h"
#import "Masonry.h"

#define DRAG_DISPLACEMENT_THRESHOLD 20

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString *cellIdentifier = @"BannerViewIdentifier";

@interface GPBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView; /**< CollectionView */
@property (nonatomic, strong) GPBannerLayout *bannerLayout;  /**< 自定义布局 */
@property (nonatomic, assign) NSInteger totalImageCount; /**< Item 个数 */
@property (nonatomic, weak) NSTimer *timer; /**< 定时器 */
@property (nonatomic, assign) CGFloat pageWidth; /**< CollectionView PageWidth */
@property (nonatomic, assign) CGFloat pageHeight; /**< CollectionView PageHeight */
@property (nonatomic, assign) BOOL snapping;
@property (nonatomic, assign) CGPoint dragVelocity;
@property (nonatomic, assign) CGPoint dragDisplacement;
@property (nonatomic, assign) BOOL pageEnable;

@end

@implementation GPBannerView

#pragma mark - Lifecycle

+ (instancetype)bannerViewWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    
    GPBannerView *bannerView = [[self alloc] initWithFrame:frame];
    bannerView.dataSource = dataSource;
    
    return bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.time = 4;
        self.pageEnable = YES;
        self.widthHeightScale = 2.5;//5.0 / 3.0;
        self.designHeight = 130.0f;
        self.designWidth = 152.0f;
        self.maxWidth = (SCREEN_WIDTH - 40);
        [self setupUI];
        [self setupConstraints];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetContentOffset) name:@"ResetContentOffset" object:nil];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 在一开始的时候设置 CollectionView 的偏移位置
    [self resetContentOffset];
    [self timerStart];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    if (newSuperview == nil) {
        [self invalidateTimer];
    }
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - UI

- (void)setupUI {
    
    [self addSubview:self.collectionView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - Custom Accessors

/**
 传入数据源,设置数据源
 */
- (void)setDataSource:(NSArray *)dataSource {
    
    _dataSource = dataSource;
    self.totalImageCount = dataSource.count * 500;
    if (dataSource.count != 1) {
        self.collectionView.scrollEnabled = YES;
    } else {
        self.collectionView.scrollEnabled = NO;
    }
    
    [self.collectionView reloadData];
}


#pragma mark - IBActions


#pragma mark - Public

/**
 定时器开启
 */
- (void)timerStart {
    
    if (self.timer) {
        [self invalidateTimer];
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 关闭定时器
 */
- (void)invalidateTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark - Private

/**
 重置偏移量
 */
- (void)resetContentOffset {
    
    self.collectionView.contentOffset = CGPointMake(self.pageWidth * self.totalImageCount * 0.5, 0);
}

/**
 根据 Cell 的索引计算出页数
 
 @param index  Cell 索引
 @return 页数
 */
- (int)pageIndexWithCellIndex:(NSInteger)index {
    
    return (int)index % self.dataSource.count;
}

/**
 获取当前索引
 */
- (int)currentIndex {
    
    int index = self.collectionView.contentOffset.x / self.pageWidth;
    return MAX(0, index);
}

/**
 自动滚动(定时器方法)
 */
- (void)automaticScroll
{
    if (0 == self.totalImageCount) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

/**
 定时器根据索引滚动
 
 @param targetIndex 索引
 */
- (void)scrollToIndex:(int)targetIndex
{
    if (targetIndex >= self.totalImageCount - self.dataSource.count) {
        targetIndex = self.totalImageCount * 0.5;
        self.collectionView.contentOffset = CGPointMake(self.pageWidth * targetIndex, 0);
        
        return;
    }
    
    [self.collectionView setContentOffset:CGPointMake(self.pageWidth * targetIndex, 0) animated:YES];
}

/**
 滑动到下一页或者上一页
 */
- (void)snapToPage {
    CGPoint pageOffset;
    
    pageOffset.x = [self pageOffsetForComponent:YES];
    pageOffset.y = [self pageOffsetForComponent:NO];
    
    
    CGPoint currentOffset = self.collectionView.contentOffset;
    
    if (!CGPointEqualToPoint(pageOffset, currentOffset)) {
        _snapping = YES;
        
        [self.collectionView setContentOffset:pageOffset animated:YES];
    }
    
    _dragVelocity = CGPointZero;
    _dragDisplacement = CGPointZero;
}

/**
 计算下一页或者上一页的偏移量
 */
- (CGFloat)pageOffsetForComponent:(BOOL)isX {
    
    if (((isX ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds)) == 0) || ((isX ? self.collectionView.contentSize.width : self.collectionView.contentSize.height) == 0))
        return 0;
    CGFloat pageLength = isX ? _pageWidth : _pageHeight; // 每页的宽度/高度
    
    if (pageLength < FLT_EPSILON) {
        pageLength = isX ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    }
    
    pageLength *= self.collectionView.zoomScale; //
    
    CGFloat totalLength = isX ? self.collectionView.contentSize.width : self.collectionView.contentSize.height; // 可滚动范围
    CGFloat visibleLength = (isX ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds)) * self.collectionView.zoomScale; // 当前显示宽度
    CGFloat currentOffset = isX ? self.collectionView.contentOffset.x : self.collectionView.contentOffset.y; // 当前偏移量
    CGFloat dragVelocity = isX ? _dragVelocity.x : _dragVelocity.y;
    CGFloat dragDisplacement = isX ? _dragDisplacement.x : _dragDisplacement.y;
    CGFloat newOffset;
    CGFloat index = currentOffset / pageLength;
    CGFloat lowerIndex = floorf(index);
    CGFloat upperIndex = ceilf(index);
    
    if (ABS(dragDisplacement) < DRAG_DISPLACEMENT_THRESHOLD || dragDisplacement * dragVelocity < 0) {
        if (index - lowerIndex > upperIndex - index) {
            index = upperIndex;
        } else {
            index = lowerIndex;
        }
    } else {
        if (dragVelocity > 0) {
            // 向左滑，下一页
            index = upperIndex;
        } else {
            // 向右滑，上一页
            index = lowerIndex;
        }
    }
    
    newOffset = pageLength * index;
    
    // 判断有没有超出范围
    if (newOffset > totalLength - visibleLength) {
        
        newOffset = totalLength - visibleLength;
    }
    if (newOffset < 0) {
        
        newOffset = 0;
    }
    
    return newOffset;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.totalImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    int index = [self pageIndexWithCellIndex:indexPath.item];
    cell.imageName = self.dataSource[index];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectedAtIndex:)]) {
        [self.delegate bannerView:self didSelectedAtIndex:(indexPath.row % self.dataSource.count)];
    }
}


#pragma mark - UIScrollViewDelegate

/// 开始拖拽,关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self invalidateTimer];
    _dragDisplacement = scrollView.contentOffset;
}

/// 停止拖拽,开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self timerStart];
    if (!decelerate && self.pageEnable) {
        
        [self snapToPage];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (self.pageEnable) {
        *targetContentOffset = scrollView.contentOffset;
        _dragVelocity = velocity;
        _dragDisplacement = CGPointMake(scrollView.contentOffset.x - _dragDisplacement.x, scrollView.contentOffset.y - _dragDisplacement.y);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.pageEnable)
        [self snapToPage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (!_snapping && self.pageEnable) {
        [self snapToPage];
    } else {
        _snapping = NO;
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    if (self.pageEnable) {
        
        [self snapToPage];
    }
}


#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        self.bannerLayout = [[GPBannerLayout alloc] init];
        self.bannerLayout.maxWidth = self.maxWidth;
        self.bannerLayout.maxHeight = self.bannerLayout.maxWidth * 1 / self.widthHeightScale;
        self.bannerLayout.itemHeight = round(self.bannerLayout.maxHeight * self.designHeight / self.designWidth);
        self.bannerLayout.itemWidth = round(self.bannerLayout.itemHeight * self.widthHeightScale);
        self.bannerLayout.spacing = (self.bannerLayout.maxWidth - self.bannerLayout.itemWidth) * 0.5 + 4;
        
        self.pageWidth = self.bannerLayout.itemWidth + self.bannerLayout.spacing;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.bannerLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[GPBannerCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    
    return _collectionView;
}

@end
