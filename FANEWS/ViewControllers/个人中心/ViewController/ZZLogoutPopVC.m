//
//  ZZLogoutPopVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/16.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZLogoutPopVC.h"

@interface ZZLogoutPopVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBT;
@property (weak, nonatomic) IBOutlet UIButton *logoutBT;

@end

@implementation ZZLogoutPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initContentView];
}

- (void)initContentView{
    self.backView.layer.cornerRadius = 8;
    
    self.cancelBT.layer.cornerRadius = 20;
    self.logoutBT.layer.cornerRadius = 20;
}
//取消
- (IBAction)cancelBtAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//退出登录
- (IBAction)logoutBtAction:(UIButton *)sender {
    
    
}

@end
