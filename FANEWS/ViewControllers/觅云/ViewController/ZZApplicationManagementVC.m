//
//  ZZApplicationManagementVC.m
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZApplicationManagementVC.h"
#import "ZZEditCollectionVIew.h"
#import "ZZEditCell.h"
#import "DataManager.h"
#import "ZZEditCellModel.h"
#import "ZZEditCollectionReusableViewHeadView.h"
#import "ZZEditCollectionReusableViewFootView.h"

@interface ZZApplicationManagementVC ()<ZZEditCellCollectionViewDelegate, EditCellCollectionViewDataSource>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) ZZEditCollectionVIew *mainView;
@property (nonatomic, strong) DataManager *sourceManager;
@property (nonatomic, strong) UIButton * rightBtn;

@end

@implementation ZZApplicationManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(245, 245, 245);
    self.title = @"应用管理";
   
    [self setRightBt];
    
    [self initContentView];
}

- (void)initContentView{
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(10, kNavHeight + 15, kScreenWidth - 20, 20)];
    message.textColor = kColor(103, 103, 103);
    message.font = KUIFont(12);
    message.text = @"长按拖动可调整应用位置";
    message.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:message];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];

    float cellWidth = floor((self.view.bounds.size.width - 60)/5.0);
    layout.itemSize = CGSizeMake(cellWidth, cellWidth * 1.4);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    ZZEditCollectionVIew *mainView = [[ZZEditCollectionVIew alloc] initWithFrame:CGRectMake(0, kNavHeight + 50, kScreenWidth, kScreenHeight - kNavHeight - 50) collectionViewLayout:layout];

    _mainView = mainView;
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView registerNib:[UINib nibWithNibName:@"ZZEditCell" bundle:nil] forCellWithReuseIdentifier:@"ZZEditCell"];
    [mainView registerClass:[ZZEditCollectionReusableViewHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [mainView registerClass:[ZZEditCollectionReusableViewFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

    
    self.sourceManager = [DataManager shareDataManager];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationRightEvent:) name:KCellBeganEditing object:nil];
}

- (void)setRightBt{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 40, 25);
    [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightBtn setTitle:@"保存" forState:UIControlStateSelected];
    [_rightBtn setTitleColor:kColor(86, 141, 229) forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(navigationRightEvent:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:_rightBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}

- (void)navigationRightEvent:(id)sender{
    if ([sender isKindOfClass:[UIButton class]]) {
        _mainView.beginEditing = !_mainView.beginEditing;
    }
    if (_mainView.beginEditing) {
        _rightBtn.selected = YES;
    }else {
        _rightBtn.selected = NO;
    }
}

#pragma mark - <DragCellCollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sourceManager.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.sourceManager.dataArray[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZEditCell" forIndexPath:indexPath];
    [cell resetModel:self.sourceManager.dataArray[indexPath.section][indexPath.item] :indexPath];
   
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(ZZEditCollectionVIew *)collectionView{
    return self.sourceManager.dataArray;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size= CGSizeMake(kScreenWidth, 25);
    
    return size;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size= CGSizeMake(kScreenWidth, 15);
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        ZZEditCollectionReusableViewHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headView.title = [DataManager shareDataManager].titleArray[indexPath.section];
        if (indexPath.section == 0) {
            headView.messageLabel.text = @"最多设置5个应用";
        }else{
            headView.messageLabel.text = @"";
        }
        reusableView = headView;
    }else if (kind == UICollectionElementKindSectionFooter){
        ZZEditCollectionReusableViewFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        if (indexPath.section == 2) {
            footerView.backgroundColor = [UIColor whiteColor];
        }else{
            footerView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        }
        
        reusableView = footerView;
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(ZZEditCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    if (cell.data.isNewAdd &&indexPath.section == 0) {
        cell.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [UIView animateWithDuration:0.2 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            cell.data.isNewAdd = NO;
        }];
    }
}

#pragma mark - <DragCellCollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)dragCellCollectionView:(ZZEditCollectionVIew *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    self.sourceManager.dataArray = newDataArray.mutableCopy;
}

- (void)dragCellCollectionView:(ZZEditCollectionVIew *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    //拖动时候最后禁用掉编辑按钮的点击
    _rightBtn.enabled = NO;
}

- (void)dragCellCollectionViewCellEndMoving:(ZZEditCollectionVIew *)collectionView{
    _rightBtn.enabled = YES;
}



@end
