//
//  ZZBaseTableView.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZBaseTableView.h"

@implementation ZZBaseTableView

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
//        self.noDataHeight = 20;
//        [self drawView];
//        [self initFBKVO];
        self.backgroundColor = kColor(245, 245, 245);
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
//        self.noDataHeight = 20;
//        [self drawView];
//        [self initFBKVO];
        self.backgroundColor = kColor(245, 245, 245);
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
//        self.noDataHeight = 20;
//        [self drawView];
//        [self initFBKVO];
        self.backgroundColor = kColor(245, 245, 245);
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

//可以自定义的view,可以添加图片按钮等
- (void)drawView{
    _stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    _stringLabel.center = self.center;
    _stringLabel.text = @"空空如也~~";
    _stringLabel.hidden = YES;
    _stringLabel.font = [UIFont systemFontOfSize:15];
    _stringLabel.textAlignment = NSTextAlignmentCenter;
    _stringLabel.textColor = [UIColor blackColor];
    [self addSubview:_stringLabel];
}

//关键代码
- (void)initFBKVO{
    
    //KVO
    __weak typeof (self) weakSelf = self;
    self.kvoController = [FBKVOController controllerWithObserver:self];
    [self.kvoController observe:self keyPath:@"contentSize" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
       // contentSize有了变化即会走这里
        CGFloat height =  weakSelf.contentSize.height;
     //如果高度大于我们规定的无数据时的高度则隐藏无数据界面，否则展示
        if ( height > weakSelf.noDataHeight){
            weakSelf.stringLabel.hidden = YES;
        }else {
            weakSelf.stringLabel.hidden = NO;
        }
    }];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:self.imageName];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{

    NSString *title = @"空空如也~~";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f],
                                     NSForegroundColorAttributeName:kColor(26, 26, 26)
                                     };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];

}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return NO;
}

@end
