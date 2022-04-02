//
//  ZZDitigalSettingPopVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/31.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDitigalSettingPopVC.h"
#import "ZZPopSettingCell.h"
#import "ZZSetFontPopVC.h"

@interface ZZDitigalSettingPopVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UICollectionView *popCollectionView;

@property (nonatomic, strong) NSArray<NSString *> *nameArr;
@property (nonatomic, strong) NSArray<NSString *> *imageArr;

@end

@implementation ZZDitigalSettingPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initContentView];
    
    self.nameArr = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"钉钉",@"收藏",@"字号",@"投诉建议",@"刷新",@"复制链接"];
    self.imageArr = @[@"digital-7",@"digital-8",@"digital-9",@"digital-10",@"digital-11",@"digital-12",@"digital-13",@"digital-14",@"digital-15",@"digital-16"];
}

- (void)initContentView{
    [ZZCommenTools drawTopCornerions:12 with:self.backView with:0];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 15;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    _popCollectionView.collectionViewLayout = layout;
    _popCollectionView.alwaysBounceVertical = YES;
    _popCollectionView.delegate = self;
    _popCollectionView.dataSource = self;
    [_popCollectionView registerNib:[UINib nibWithNibName:@"ZZPopSettingCell" bundle:nil] forCellWithReuseIdentifier:@"ZZPopSettingCell"];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(floor((kScreenWidth - 120)/5), floor((kScreenWidth - 120)/5) * 1.1);
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ZZPopSettingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZPopSettingCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.nameArr[indexPath.item];
    cell.typeImage.image = [UIImage imageNamed:self.imageArr[indexPath.item]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.item) {
        case 0://微信
        
            break;
        case 1://朋友圈
            
            break;
        case 2://QQ
            
            break;
        case 3://QQ空间
            
            break;
        case 4://钉钉
            
            break;
        case 5://收藏
            
            break;
        case 6://字号
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SETTINGDISMISS" object:nil];
        }
            break;
        case 7://投诉建议
            
            break;
        case 8://刷新
            
            break;
        case 9://复制链接
            
            break;
            
        default:
            break;
    }
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
