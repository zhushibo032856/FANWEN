//
//  ZZAINormalCell.m
//  FANEWS
//
//  Created by fanews on 2022/3/28.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZAINormalCell.h"

@implementation ZZAINormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.lineLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(12);
            make.left.right.mas_equalTo(self.contentView);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(18);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(.5);
        }];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
    }
    return _timeLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
    }
    return _lineLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
