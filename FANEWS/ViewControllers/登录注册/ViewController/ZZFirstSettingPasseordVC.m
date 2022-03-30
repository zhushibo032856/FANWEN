//
//  ZZFirstSettingPasseordVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/30.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZFirstSettingPasseordVC.h"

@interface ZZFirstSettingPasseordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UIView *backVIew;
@property (weak, nonatomic) IBOutlet UIButton *sureBT;

@end

@implementation ZZFirstSettingPasseordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initContentView];
}

- (void)initContentView{
    self.sureBT.layer.cornerRadius = 22.5;
    [self.sureBT setEnabled:NO];
    [self.sureBT setBackgroundColor:kColor(155, 188, 237)];
    
    self.passwordTF.delegate = self;
    self.confirmPasswordTF.delegate = self;
    [self.passwordTF addTarget:self action:@selector(textFieldPasswordTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmPasswordTF addTarget:self action:@selector(textFieldPasswordTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kColor(204, 221, 255).CGColor,(__bridge id)kColor(255, 255, 255).CGColor];
    gradientLayer.locations = @[@0,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = self.backVIew.frame;
   // [self.backView.layer addSublayer:gradientLayer];
    [self.backVIew.layer insertSublayer:gradientLayer atIndex:0];
}

-(void)textFieldPasswordTextChange:(UITextField *)textField{
    
    if ([ZZCommenTools checkPassWordWith:_passwordTF.text] && [ZZCommenTools checkPassWordWith:_confirmPasswordTF.text] && [_passwordTF.text isEqualToString:_confirmPasswordTF.text]) {
        [self.sureBT setEnabled:YES];
        [self.sureBT setBackgroundColor:kColor(89, 143, 226)];
    }else{
        [self.sureBT setEnabled:NO];
        [self.sureBT setBackgroundColor:kColor(155, 188, 237)];
    }
    
    
}
- (IBAction)backBtAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sureBtAction:(UIButton *)sender {
    [[AppDelegate mainAppDelegate] showTabbarView];
}

@end
