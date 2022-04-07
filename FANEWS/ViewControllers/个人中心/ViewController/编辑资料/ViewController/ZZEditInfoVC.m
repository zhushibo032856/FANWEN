//
//  ZZEditInfoVC.m
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZEditInfoVC.h"
#import "ZZEditInfoCell.h"
#import "ZZGenderSelectPickerVC.h"
#import "ZZDateSelectPickerVC.h"
#import "ZZAreaSelectPickerVC.h"


@interface ZZEditInfoVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

/**
 头部部分
 */
@property (nonatomic, strong) UIImageView *userImage;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UIImage *selectImage;//选中的照片

@property (nonatomic, strong) ZZBaseTableView *tableView;

@end

@implementation ZZEditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.userImage];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.tableView];
    
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(kNavHeight + 40);
        make.width.height.mas_equalTo(64);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.userImage.mas_bottom).offset(13);
        make.height.mas_equalTo(15);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(self.view).offset(168 + kNavHeight);
        make.height.mas_equalTo(20);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.infoLabel.mas_bottom).offset(10);
    }];
}

#pragma mark 重写返回时候，保存编辑信息时间
- (void)navigationLeftEvent{
    [super navigationLeftEvent];
    
    NSLog(@"1222");
}
#pragma mark 头部懒加载
- (UIImageView *)userImage{
    if (!_userImage) {
        _userImage = [[UIImageView alloc]init];
        _userImage.layer.masksToBounds = YES;
        _userImage.layer.cornerRadius = 16;
        [_userImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _userImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAlbumOrCammer)];
        [_userImage addGestureRecognizer:tap];
    }
    return _userImage;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = @"点击更换头像";
        _messageLabel.textColor = kColor(153, 153, 153);
        _messageLabel.font = KUIFont(14);
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.text = @"基本资料";
        _infoLabel.font = FontType_Bold(17);
        _infoLabel.textColor = kColor(0, 0, 0);
    }
    return _infoLabel;
}

#pragma mark tableview 加载和代理
- (ZZBaseTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[ZZBaseTableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[ZZEditInfoCell class] forCellReuseIdentifier:@"ZZEditInfoCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZEditInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZZEditInfoCell" forIndexPath:indexPath];
    NSArray *titleArr = @[@"用户名",@"性别",@"生日",@"地区"];
    cell.titleLabel.text = titleArr[indexPath.row];
    [cell initCellWith];
    if (indexPath.row == 0) {
        cell.infoTF.delegate = nil;
    }else{
        
        cell.infoTF.delegate = self;
    }
    
    cell.infoTF.tag = 200 + indexPath.row;

    return cell;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

//写你要实现的：页面跳转的相关代码
    NSInteger tag = textField.tag - 200;
    switch (tag) {
        case 1:
        {
            ZZGenderSelectPickerVC *vc = [ZZGenderSelectPickerVC new];
            vc.block = ^(NSString * _Nonnull type) {
                textField.text = type;
            };
            ZZBPPopViewController *popvc = [ZZBPPopViewController initVC:vc];
            [self presentViewController:popvc animated:YES completion:nil];
        }
            break;
        case 2:
        {
            ZZDateSelectPickerVC *vc = [ZZDateSelectPickerVC new];
            vc.blcok = ^(NSString * _Nonnull dateStr) {
                textField.text = dateStr;
            };
            ZZBPPopViewController *popvc = [ZZBPPopViewController initVC:vc];
            [self presentViewController:popvc animated:YES completion:nil];
        }
            break;
        case 3:
        {
            ZZAreaSelectPickerVC *vc = [ZZAreaSelectPickerVC new];
            vc.block = ^(NSString * _Nonnull aresStr) {
                textField.text = aresStr;
            };
            ZZBPPopViewController *popvc = [ZZBPPopViewController initVC:vc];
            [self presentViewController:popvc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
    
    return NO;

}


#pragma mark 选择照片

- (void)selectAlbumOrCammer{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self openCammer];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self openAlbum];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

- (void)openCammer{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied){
        // 无权限
        NSLog(@"无权限");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)openAlbum{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
        // 无权限
        NSLog(@"无权限无权限");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

/** 选择图片结束代理方法 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image){
        NSLog(@"%@",image);
        // 压缩图片质量
        
        self.selectImage = image;
        
    } else {
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

@end
