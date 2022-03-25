//
//  ZZMineHeadView.m
//  FANEWS
//
//  Created by fanews on 2022/3/16.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZMineHeadView.h"

@implementation ZZMineHeadView

+ (instancetype)initMineHeadView{
    KXIBVIEW(@"ZZMineHeadView")
}

- (void)initViewWith{
    self.userImageView.layer.cornerRadius = 8;
    self.vipBt.layer.cornerRadius = 10;
}

- (IBAction)infoBtAction:(UIButton *)sender {
    _block();
}

@end
