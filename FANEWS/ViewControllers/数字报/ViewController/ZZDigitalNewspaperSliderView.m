//
//  ZZDigitalNewspaperSliderView.m
//  FANEWS
//
//  Created by fanews on 2022/3/31.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDigitalNewspaperSliderView.h"
#import "XHPageControl.h"
#import "ZZDigitalNewspaperDetailVC.h"
#define number 15
@interface ZZDigitalNewspaperSliderView ()<UIScrollViewDelegate,XHPageControlDelegate>

@property (nonatomic, strong) UIScrollView *myScrollview;
@property (nonatomic, strong) XHPageControl *pageControl;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ZZDigitalNewspaperSliderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(245, 245, 245);
    
    
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.myScrollview];
    [self.view addSubview:self.pageControl];

    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.calendarStr];
}

#pragma mark lazy
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, kNavHeight + 20, kScreenWidth - 30, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = kColor(50, 50, 50);
    }
    return _timeLabel;
}

- (UIScrollView *)myScrollview{
    if (!_myScrollview) {
        _myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavHeight + 50, kScreenWidth, kScreenHeight - kNavHeight - 100)];
        _myScrollview.contentSize = CGSizeMake(kScreenWidth*number, 0);
        _myScrollview.delegate = self;
        _myScrollview.backgroundColor = kColor(245, 245, 245);
        _myScrollview.pagingEnabled = YES;
        _myScrollview.showsVerticalScrollIndicator = NO;
        _myScrollview.showsHorizontalScrollIndicator = NO;
        for (int i = 1; i <= number; i++) {
            [self.myScrollview addSubview:[self createImgView:i]];
        }
    }
    return _myScrollview;
}
- (XHPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40,kScreenWidth, 10)];
        _pageControl.numberOfPages = number;
        _pageControl.otherMultiple = 3;
        _pageControl.currentMultiple = 3;
        _pageControl.type = PageControlMiddle;
        _pageControl.otherColor = kColor(216, 216, 216);
        _pageControl.currentColor = kColor(86, 141, 229);
        _pageControl.delegate = self;
    }
    return _pageControl;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger currentPage = targetContentOffset->x / [UIScreen mainScreen].bounds.size.width;

    self.pageControl.currentPage = currentPage;
}

#pragma mark - 代理
- (void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex{

    NSLog(@"%ld",clickIndex);
    CGPoint position = CGPointMake([UIScreen mainScreen].bounds.size.width * clickIndex, 0);
    [_myScrollview setContentOffset:position animated:YES];
}

-(UIImageView *)createImgView:(int)index{
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.tag = 100 + index;
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushDetailWith:)];
    [imgV addGestureRecognizer:tap];
    [imgV sd_setImageWithURL:[NSURL URLWithString:@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg"]];
    imgV.frame = CGRectMake(kScreenWidth * (index-1) + 15, 0, kScreenWidth - 30, kScreenHeight - kNavHeight - 130);
    return imgV;
}

- (void)pushDetailWith:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag - 100;
    NSLog(@"%ld",index);
    
    ZZDigitalNewspaperDetailVC *vc = [ZZDigitalNewspaperDetailVC new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
