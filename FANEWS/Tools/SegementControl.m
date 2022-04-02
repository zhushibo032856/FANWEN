//
//  SegementControl.m
//  Aetos
//
//  Created by 朱世博 on 2021/6/3.
//

#import "SegementControl.h"

static NSInteger const kTag = 0321;
static NSTimeInterval const kTimeInterval = 0.3f;

@interface SegementControl ()
{
    CGRect _frame;
}

// separatorLine
@property (nonatomic, weak) UIView *separatorLine;

// itemsTitleArray
@property (nonatomic, strong) NSMutableArray *itemsContain;

// itemsArray
@property (nonatomic, strong) NSMutableArray *itemsArray;


@end

@implementation SegementControl

- (NSMutableArray *)itemsArray {
    
    if (!_itemsArray) {
        self.itemsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemsArray;
}


#pragma mark -
#pragma mark --- Public Method ---

- (void)segementControllShow {
    
    [self _setupItems];
}


- (void)setItems:(NSArray<NSString *> *)items {
    
    assert(items != nil);
    if (!_itemsContain) {
        self.itemsContain = [NSMutableArray array];
    }
    for (NSString *item  in items) {
        if (![_itemsContain containsObject:item]) {
            [self.itemsContain addObject:item];
        }
    }
}


/** 滑动scrollview的时候调用，更新记录的item下标 */
- (void)slideChangeSeleted:(NSInteger)newSeleted {
    
    [self _selectBtn:newSeleted];
}


/** 滑动的时候改变下面的view横线 */
- (void)scrollViewDidScrollChangeSeparatorLine:(CGFloat)x {
    
    [self _afreshLineScrollViewDidScroll:x];
}


#pragma mark -
#pragma mark --- Private Method ---

- (void)_defaultInit {
    
    _edge = UIEdgeInsetsMake(12.5 * ScaleNumberHeight, 25 * ScaleNumberWidth, 12.5 * ScaleNumberHeight, 25  * ScaleNumberWidth);
    _itemWidth = 100 * ScaleNumberWidth;
    _itemHeight = 25 * ScaleNumberHeight;
    _defaultColor = UIColorFromRGB(0x161616);
    _selectColor = UIColorFromRGB(0x1616161);
    _selectedIndex = 0;
    _separatorLineColor = UIColorFromRGB(0x171717);
    _fontSize = 17;
}


- (void)_setupItems {
    
    for (int i = 0; i < _itemsContain.count; i++) {
        
        UIButton *item = [UIButton buttonWithType:(UIButtonTypeSystem)];
        item.tag = kTag + i;
   
        [item setTitle:_itemsContain[i] forState:(UIControlStateNormal)];
        [item setTitleColor:_defaultColor forState:(UIControlStateNormal)];
        [item setTitleColor:_selectColor forState:(UIControlStateSelected)];
        item.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        [item setTintColor:[UIColor clearColor]];
        [item addTarget:self action:@selector(_selectedChange:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.itemsArray addObject:item];
        [self addSubview:item];
        if (i == _selectedIndex) {
            item.selected = YES;
            item.titleLabel.font = [UIFont boldSystemFontOfSize:_boldfontSize];
        }
    }
    
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = _separatorLineColor;
    _separatorLine = separatorLine;
    [self addSubview:separatorLine];
}


- (void)_selectedChange:(UIButton *)sender {
    
    [self _selectBtn:sender.tag - kTag];
}


- (void)_selectBtn:(NSInteger)newIndex{
    
    if (self.selectedIndex == newIndex) return;
    
    UIButton *lastBtn = (UIButton *)self.itemsArray[self.selectedIndex];
    lastBtn.selected = NO;
    lastBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
    UIButton *newBtn = (UIButton *)self.itemsArray[newIndex];
    newBtn.selected = YES;
    newBtn.titleLabel.font = [UIFont systemFontOfSize:_boldfontSize];
    self.selectedIndex = newIndex;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segementControllerSelectedIndex:)]) {
        [self.delegate segementControllerSelectedIndex:self.selectedIndex];
    }
}

- (void)_afreshLineScrollViewDidScroll:(CGFloat)x {
    
    CGRect lineFrame = self.separatorLine.frame;
    CGFloat space = (_frame.size.width - _edge.left - _edge.right - _itemWidth * _itemsContain.count) / (_itemsContain.count - 1);
    CGFloat scale = x / kScreenWidth;
    CGFloat pointX = scale * (space + _itemWidth);
    [UIView animateWithDuration:kTimeInterval animations:^{
        self.separatorLine.frame = CGRectMake(self->_edge.left + pointX + self->_itemWidth * 0.2, lineFrame.origin.y , lineFrame.size.width, lineFrame.size.height);
    }];
}


- (void)_afreshView {
    
    CGFloat space = (_frame.size.width - _edge.left - _edge.right - _itemWidth * _itemsContain.count) / (_itemsContain.count - 1);
    CGRect itemFrame;
    for (id subView in self.subviews) {
        if ([[subView class] isSubclassOfClass:[UIButton class]]) {
            UIButton *item = (UIButton *)subView;
            NSInteger i = item.tag - kTag;
            item.frame = CGRectMake(_edge.left + i * (_itemWidth + space), _edge.top, _itemWidth, _itemHeight);
            if (i == _selectedIndex) itemFrame = item.frame;
        } else if ([[subView class] isSubclassOfClass:[UIView class]]) {
            UIView *lineView = (UIView *)subView;
            lineView.frame =  CGRectMake(itemFrame.origin.x + _itemWidth * 0.2, _frame.size.height - 2, _itemWidth * 0.6, 2);
        }
    }
}


#pragma mark -
#pragma mark --- System Method ---

- (void)layoutSubviews {
    
    [self _afreshView];
}


#pragma mark -
#pragma mark --- Init Method ---


/**
 factory method

 @param frame frame
 @return segement
 */
+ (instancetype)YYSegementControllerWithFrame:(CGRect)frame {
    
    SegementControl *YYSegementC = [[SegementControl alloc] initSegementControllerWithFrame:frame];
    return YYSegementC;
}


/**
 init method

 @param frame frame
 @return segement
 */
- (instancetype)initSegementControllerWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        [self _defaultInit];
    }
    return self;
}


@end
