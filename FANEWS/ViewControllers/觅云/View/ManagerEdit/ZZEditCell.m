//
//  ZZEditCell.m
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZEditCell.h"
#import "ZZEditCellModel.h"
#import "DataManager.h"

@interface ZZEditCell()

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ZZEditCell

- (void)resetModel:(ZZEditCellModel *)data :(NSIndexPath *)indexPath {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonState:) name:KCellBeganEditing object:nil];
    self.data = data;
    self.nameLabel.text = data.title;
    self.indexPath = indexPath;
    self.backgroundColor = data.backGroundColor;
    if ([DataManager shareDataManager].isEditing) {
        if (self.indexPath.section == 0 || self.indexPath.section == 1) {
            if (self.indexPath.item == 0) {
                [self.statusBt setHidden:YES];
            }else{
                [self.statusBt setHidden:NO];
            }
        }else{
            self.statusBt.hidden = NO;
        }
        [self showStateButton];
    }else{
        self.statusBt.hidden = YES;
    }
}


- (void)showStateButton {
    switch (self.data.state) {
        case ServeAdd:
            self.statusBt.enabled = YES;
            [self.statusBt setImage:[UIImage imageNamed:@"app_add"] forState:UIControlStateNormal];
            break;
        case ServeSelected:
            if (self.indexPath.section == 0) {
                self.statusBt.enabled = YES;
                [self.statusBt setImage:[UIImage imageNamed:@"app_del"] forState:UIControlStateNormal];

            }else {
                if ([[DataManager shareDataManager].headArray containsObject:self.data]) {
                    self.statusBt.enabled = NO;
                    [self.statusBt setImage:nil forState:UIControlStateNormal];

                }else{
                    self.statusBt.enabled = YES;
                    [self.statusBt setImage:[UIImage imageNamed:@"app_add"] forState:UIControlStateNormal];
                }
            }
            break;
    }
}


- (void)changeButtonState:(NSNotification *)notification {
    NSString *string = notification.object;

    if ([string isEqualToString:@"yes"]) {
        
        if (self.indexPath.section == 0 || self.indexPath.section == 1) {
            if (self.indexPath.item == 0) {
                [self.statusBt setHidden:YES];
            }else{
                [self.statusBt setHidden:NO];
            }
        }else{
            self.statusBt.hidden = NO;
        }
        
        [self showStateButton];
        self.statusBt.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            self.statusBt.transform = CGAffineTransformIdentity;
        }];
    }else{

        [UIView animateWithDuration:0.1 animations:^{
            self.statusBt.transform = CGAffineTransformMakeScale(0.001, 0.001);
        } completion:^(BOOL finished) {
            self.statusBt.transform = CGAffineTransformIdentity;
            self.statusBt.hidden = YES;
        }];
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    sender.enabled = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:KCellStateChange object:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
