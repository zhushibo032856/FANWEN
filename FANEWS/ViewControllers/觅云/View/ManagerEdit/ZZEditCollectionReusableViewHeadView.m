//
//  ZZEditCollectionReusableViewHeadView.m
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZEditCollectionReusableViewHeadView.h"

@implementation ZZEditCollectionReusableViewHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, 150, 20)];
        self.headLabel.font = FontType_Bold(14);
        self.headLabel.tag = 200;
        [self addSubview:self.headLabel];
        self.backgroundColor = [UIColor whiteColor];
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2, 12, kScreenWidth / 2 - 12, 20)];
        self.messageLabel.font = KUIFont(12);
        self.messageLabel.textColor = kColor(153, 153, 153);
        self.messageLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.messageLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.headLabel.text = title;
}

@end
