//
//  ZZCycleScrollview.m
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZCycleScrollview.h"
#import "ZZPageControl.h"
#import "ZZCycleCollectionViewCell.h"

#define kCycleScrollViewInitialPageControlDotSize CGSizeMake(10, 10)

NSString * const ID = @"cycleCell";

@interface ZZCycleScrollview ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) UIControl *pageControl;

@property (nonatomic, strong) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图

@property (nonatomic, assign) NSInteger networkFailedRetryCount;

@end

@implementation ZZCycleScrollview

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (void)initialization
{
    _pageControlAliment = ZZCycleScrollViewPageContolAlimentCenter;
    _autoScrollTimeInterval = 2.0;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _showPageControl = YES;
    _pageControlDotSize = kCycleScrollViewInitialPageControlDotSize;
    _hidesForSinglePage = YES;
    _currentPageDotColor = [UIColor whiteColor];
    _pageDotColor = [UIColor lightGrayColor];
    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
    _pageControlStyle = ZZCycleScrollViewPageContolStyleAnimated;
    _indicatorMargin = 10.0;
    _indicatorDiameter = 6.0;
    _normalDiameter = 6.0;
    _pageMaginType = ZZPageControlMaginTypeCircleType;
    self.backgroundColor = [UIColor lightGrayColor];
    
}

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<ZZCycleScrollViewDegelate>)delegate placeholderImage:(UIImage *)placeholderImage{
    ZZCycleScrollview *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.placeholderImage = placeholderImage;
    
    return cycleScrollView;
}

#pragma mark --- 设置显示图片的collectionView
-(void)setupMainView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[ZZCycleCollectionViewCell class] forCellWithReuseIdentifier:ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    _mainView = mainView;
    
}

#pragma mark --- 属性的 set 方法
/** 占位图，用于网络未加载到图片时 */
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:self.mainView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}

/** 分页控件小圆标大小 */
-(void)setPageControlDotSize:(CGSize)pageControlDotSize{
    _pageControlDotSize = pageControlDotSize;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageContol = (ZZPageControl *)_pageControl;
        pageContol.indicatorDiameter = 5;
    }
}

/** */
-(void)setPageMaginType:(ZZPageControlMaginType)pageMaginType{
    _pageMaginType = pageMaginType;
    [self setupPageControl];
}
/** 分页控件选中直径*/
- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter
{
    _indicatorDiameter = indicatorDiameter;
    [self setupPageControl];
}

/** 分页控件间距*/
-(void)setIndicatorMargin:(CGFloat)indicatorMargin{
    _indicatorMargin = indicatorMargin;
    [self setupPageControl];
}
/** 分页控件 非选中直径宽度*/
-(void)setNormalDiameter:(CGFloat)normalDiameter{
    _normalDiameter = normalDiameter;
    [self setupPageControl];
}

/** 是否显示分页控件 */
- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    _pageControl.hidden = !showPageControl;
}

/** 当前分页控件小圆标颜色 */
- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
{
    _currentPageDotColor = currentPageDotColor;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageControl = (ZZPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = currentPageDotColor;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = currentPageDotColor;
    }
    
}

/** 其他分页控件小圆标颜色 */
- (void)setPageDotColor:(UIColor *)pageDotColor
{
    _pageDotColor = pageDotColor;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageControl = (ZZPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = _pageDotColor;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = _pageDotColor;
    }
}



/** 当前分页控件小圆标图片 */
- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage
{
    _currentPageDotImage = currentPageDotImage;
    if (self.pageControlStyle != ZZCycleScrollViewPageContolStyleAnimated) {
        self.pageControlStyle = ZZCycleScrollViewPageContolStyleAnimated;
    }
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}

/** 其他分页控件小圆标图片 */
- (void)setPageDotImage:(UIImage *)pageDotImage
{
    _pageDotImage = pageDotImage;
    if (self.pageControlStyle != ZZCycleScrollViewPageContolStyleAnimated) {
        self.pageControlStyle = ZZCycleScrollViewPageContolStyleAnimated;
    }
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}

/** 设置分页控件图片 */
- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot
{
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageControl = (ZZPageControl *)_pageControl;
        if (isCurrentPageDot) {
            pageControl.currentPageIndicatorImage = image;
        } else {
            pageControl.pageIndicatorImage = image;
        }
    }
}

/** 是否无限循环,默认Yes */
- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (self.imagePathsGroup.count) {
        self.imagePathsGroup = self.imagePathsGroup;
    }
}

/** 是否自动滚动,默认Yes */
-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

/** 图片滚动方向，默认为水平滚动 */
-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    _flowLayout.scrollDirection = scrollDirection;
}

/** 自动滚动间隔时间,默认2s */
-(void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

-(void)setPageControlStyle:(ZZCycleScrollViewPageContolStyle)pageControlStyle{
    _pageControlStyle = pageControlStyle;
    [self setupPageControl];
}
/** 图片数组 */
- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    if (imagePathsGroup.count < _imagePathsGroup.count) {
        [_mainView setContentOffset:CGPointZero animated:NO];
    }
    
    _imagePathsGroup = imagePathsGroup;
    
    _totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
    
    if (imagePathsGroup.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        [self invalidateTimer];
        self.mainView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [self.mainView reloadData];
    
    if (imagePathsGroup.count) {
        [self.backgroundImageView removeFromSuperview];
    } else {
        if (self.backgroundImageView && !self.backgroundImageView.superview) {
            [self insertSubview:self.backgroundImageView belowSubview:self.mainView];
        }
    }
}

/** 网络图片 url string 数组 */
- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    NSMutableArray *temp = [NSMutableArray new];
    [_imageURLStringsGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
}

/** 本地图片数组 */
- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup
{
    _localizationImageNamesGroup = localizationImageNamesGroup;
    self.imagePathsGroup = [localizationImageNamesGroup copy];
}

#pragma mark - actions

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark --- 分页控件
- (void)setupPageControl{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    
    if (self.imagePathsGroup.count == 0) return;
    
    if ((self.imagePathsGroup.count == 1) && self.hidesForSinglePage) return;
    
    int indexOnPageControl = [self currentIndex] % self.imagePathsGroup.count;
    
    switch (self.pageControlStyle) {
        case ZZCycleScrollViewPageContolStyleAnimated:
        {
            ZZPageControl *pageControl = [[ZZPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.normalDiameter = self.normalDiameter;
            pageControl.indicatorMargin = self.indicatorMargin;
            pageControl.indicatorDiameter = self.indicatorDiameter;
            pageControl.marginType = self.pageMaginType == ZZPageControlMaginTypeCircleType ? PageControlCircleType : PageControlOvalType;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        case ZZCycleScrollViewPageContolStyleClassic:
        {
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
            pageControl.pageIndicatorTintColor = self.pageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        default:
            break;
    }
    
    // 重设pagecontroldot图片
    if (self.currentPageDotImage) {
        self.currentPageDotImage = self.currentPageDotImage;
    }
    if (self.pageDotImage) {
        self.pageDotImage = self.pageDotImage;
    }
}

#pragma mark --- 自动滚动
- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    if (targetIndex >= _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
            [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark --- 计算当前页
- (int)currentIndex
{
    if (_mainView.width == 0 || _mainView.width == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageControl = (ZZPageControl *)_pageControl;
        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kCycleScrollViewInitialPageControlDotSize, self.pageControlDotSize))) {
            pageControl.normalDiameter = self.normalDiameter;
            pageControl.indicatorDiameter = self.indicatorDiameter;
        }
        size = [pageControl sizeForNumberOfPages:self.imagePathsGroup.count];
    } else {
        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.2, self.pageControlDotSize.height);
    }
    CGFloat x = (self.width - size.width) * 0.5;
    if (self.pageControlAliment == ZZCycleScrollViewPageContolAlimentRight) {
        x = self.mainView.width - size.width - 10;
    }
    CGFloat y = self.mainView.height - size.height - 10;
    
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageControl = (ZZPageControl *)_pageControl;
        [pageControl sizeToFit];
    }
    
    self.pageControl.frame = CGRectMake(x, y, size.width, size.height);
    self.pageControl.hidden = !_showPageControl;
    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
    
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}

#pragma mark - public actions

- (void)adjustWhenControllerViewWillAppera
{
    long targetIndex = [self currentIndex];
    if (targetIndex < _totalItemsCount) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZZCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.imagePathsGroup.count;
    
    NSString *imagePath = self.imagePathsGroup[itemIndex];
    
    if ([imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            // 加载网络图片
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
        } else {
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.imageView.image = image;
        }
    } else if ([imagePath isKindOfClass:[UIImage class]]) {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (!cell.hasConfigured) {
        cell.hasConfigured = YES;
        cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(zz_cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate zz_cycleScrollView:self didSelectItemAtIndex:indexPath.item % self.imagePathsGroup.count];
    }
    if (self.clickItemOperationBlock) {
        self.clickItemOperationBlock(indexPath.item % self.imagePathsGroup.count);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = itemIndex % self.imagePathsGroup.count;
    
    if ([self.pageControl isKindOfClass:[ZZPageControl class]]) {
        ZZPageControl *pageControl = (ZZPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.mainView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = itemIndex % self.imagePathsGroup.count;
    
    if ([self.delegate respondsToSelector:@selector(zz_cycleScrollView:didScrollToIndex:)]) {
        [self.delegate zz_cycleScrollView:self didScrollToIndex:indexOnPageControl];
    } else if (self.itemDidScrollOperationBlock) {
        self.itemDidScrollOperationBlock(indexOnPageControl);
    }
}

@end
