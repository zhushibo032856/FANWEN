//
//  ZZSetFontPopVC.m
//  FANEWS
//
//  Created by fanews on 2022/4/1.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZSetFontPopVC.h"
#import "ZZCustomSlider.h"
@interface ZZSetFontPopVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ZZSetFontPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ZZCommenTools drawTopCornerions:12 with:self.backView with:0];
    ZZCustomSlider *slider = [[ZZCustomSlider alloc] initWithFrame:CGRectMake(kScreenWidth * 0.1, 100, kScreenWidth * 0.8, 30)];
    slider.backgroundColor = [UIColor whiteColor];
    slider.value = 1;
    slider.sliderBarHeight = 0.5;
    slider.numberOfPart = 4;
    slider.thumbImage = [UIImage imageNamed:@"login-2"];
    slider.partNameOffset = CGPointMake(0, -30);
    slider.thumbSize = CGSizeMake(15, 15);
    slider.partSize = CGSizeMake(1, 1);
    slider.thumbColor = [UIColor grayColor];
    slider.sliderColor = [UIColor grayColor];
 //   slider.partNameArray = @[@"小",@"标准",@"大",@"超大"];
    [slider addTarget:self action:@selector(valuechange:) forControlEvents:UIControlEventValueChanged];
    [self.backView addSubview:slider];
}

- (void)valuechange:(ZZCustomSlider*)sender {
    NSLog(@"current index = %ld",sender.value);
    
    _block(sender.value);
}

- (IBAction)cancelBtAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
