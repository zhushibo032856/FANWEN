//
//  ZZTitleEditVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/17.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZTitleEditVC.h"
#import "ZZEditCollectionViewCell.h"

@interface ZZTitleEditVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelBT;
@property (nonatomic, strong) UIButton *completBT;

@property (nonatomic, strong) UICollectionView *collectionView;
/// 是否移动
@property (nonatomic, assign) BOOL isBeganMove;


@end

@implementation ZZTitleEditVC

- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColor(60, 60, 67);
    self.view.alpha = 0.8;

    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.messageLabel];
    [self.backView addSubview:self.cancelBT];
    [self.backView addSubview:self.completBT];
    [self.backView addSubview:self.collectionView];
}

#pragma mark 懒加载控件
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight - 150)];
        _backView.backgroundColor = [UIColor whiteColor];
        [ZZCommenTools drawTopCornerions:10 with:self.backView with:0];
    }
    return _backView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 80, 20)];
        _titleLabel.text = @"栏目设置";
    }
    return _titleLabel;
}
- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 200, 20)];
        _messageLabel.text = @"长按拖动栏目位置，改变先后顺序";
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = kColor(153, 153, 153);
    }
    return _messageLabel;
}
- (UIButton *)cancelBT{
    if (!_cancelBT) {
        _cancelBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBT.frame = CGRectMake(kScreenWidth - 50, 10, 25, 25);
        [_cancelBT setImage:[UIImage imageNamed:@"Recommended-1"] forState:UIControlStateNormal];
        [_cancelBT addTarget:self action:@selector(cancelBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBT setBackgroundColor:[UIColor whiteColor]];
    }
    return _cancelBT;
}
//取消事件
- (void)cancelBtAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIButton *)completBT{
    if (!_completBT) {
        _completBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _completBT.frame = CGRectMake(kScreenWidth - 60, 45, 50, 25);
        [_completBT setTitle:@"完成" forState:UIControlStateNormal];
        _completBT.titleLabel.font = [UIFont systemFontOfSize:14];
        [_completBT setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_completBT addTarget:self action:@selector(completBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [_completBT setBackgroundColor:[UIColor whiteColor]];
    }
    return _completBT;
}
//完成事件
- (void)completBtAction:(UIButton *)sender{
    
    [kUserDefaults setValue:self.titleArr forKey:@"TITLEARR"];
    [kUserDefaults synchronize];

    _block(self.lastIndex);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 25, 10, 25);
        layout.itemSize = CGSizeMake((kScreenWidth - 100) / 3, 40);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, self.backView.height - 80) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZZEditCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZZEditCollectionViewCell"];
    }
    
    return _collectionView;
}


#pragma mark - 手势事件
-(void)moveCollectionViewCell:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            if (!self.isBeganMove) {
                self.isBeganMove = YES;
                //获取点击的cell的indexPath
                NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
                
                //开始移动对应的cell
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            //移动cell
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            self.isBeganMove = false;
            //结束移动
            [self.collectionView endInteractiveMovement];
            break;
        }
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - UICollectionViewDataSource/UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZZEditCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZEditCollectionViewCell" forIndexPath:indexPath];
    
    cell.nameLabel.backgroundColor = kColor(245, 245, 245);
    cell.nameLabel.layer.masksToBounds = YES;
    cell.nameLabel.layer.cornerRadius = 5;
    cell.nameLabel.text = self.titleArr[indexPath.item];
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveCollectionViewCell:)];
    [cell addGestureRecognizer:longPress];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //处理数据（删除之前的位置数据，插入到新的位置）
    NSString *str = self.titleArr[sourceIndexPath.item];
    [self.titleArr removeObjectAtIndex:sourceIndexPath.item];
    [self.titleArr insertObject:str atIndex:destinationIndexPath.item];
    self.lastIndex = destinationIndexPath.item;
    NSLog(@"%ld",self.lastIndex);
    //此处可以根据需要，上传给后台目前数据的顺序
}

@end
