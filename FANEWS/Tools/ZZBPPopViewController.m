//
//  ZZBPPopViewController.m
//  Aetos
//
//  Created by 朱世博 on 2021/5/25.
//

#import "ZZBPPopViewController.h"

@interface ZZBPPopViewController ()

@end

@implementation ZZBPPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentVC.view.frame = self.view.frame;
    [self.view addSubview:self.contentVC.view];
    [self addChildViewController:self.contentVC];
    [self.contentVC didMoveToParentViewController:self];
}

+ (ZZBPPopViewController *)initVC:(UIViewController *)vc{
    ZZBPPopViewController *bpVC = [[ZZBPPopViewController alloc]init];
    bpVC.modalPresentationStyle = UIModalPresentationCustom;
    bpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    bpVC.contentVC = vc;
    
    
    
    return bpVC;
}

@end
