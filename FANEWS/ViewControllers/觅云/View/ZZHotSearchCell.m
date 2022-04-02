//
//  ZZHotSearchCell.m
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZHotSearchCell.h"

@implementation ZZHotSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.titleImage];
        [self.contentView addSubview:self.sortingLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.tagImage];
        
        [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.width.height.mas_equalTo(18);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.sortingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.width.height.mas_equalTo(18);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.tagImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.width.height.mas_equalTo(16);
        }];
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.tagImage.mas_left).offset(-10);
            
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(55);
            make.right.mas_equalTo(self.numberLabel.mas_left).offset(-10);
        }];

    }
    return self;
}

- (void)setCellWith:(NSInteger)index{
    self.contentLabel.text = @"风云激荡的历史新征程风云激荡的历史新征程";
    self.sortingLabel.text = [NSString stringWithFormat:@"%ld",index];
    if (index == 0) {
        self.sortingLabel.hidden = YES;
        self.titleImage.image = [UIImage imageNamed:@"Erudite-14"];
        self.tagImage.image = [UIImage imageNamed:@"Erudite-15"];
    }else if(index == 1 || index == 2 || index == 3){
        self.titleImage.hidden = YES;
        self.sortingLabel.textColor = kColor(237, 66, 67);
        self.numberLabel.text = @"244.45万";
        self.tagImage.image = [UIImage imageNamed:@"Erudite-16"];
    }else{
        self.titleImage.hidden = YES;
        self.sortingLabel.textColor = kColor(0, 0, 0);
    }
}

- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc]init];
    }
    return _titleImage;
}

- (UILabel *)sortingLabel{
    if (!_sortingLabel) {
        _sortingLabel = [[UILabel alloc]init];
        _sortingLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortingLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = kColor(0, 0, 0);
        _contentLabel.font = KUIFont(16);
    }
    return _contentLabel;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = kColor(153, 153, 153);
        _numberLabel.font = KUIFont(12);
    }
    return _numberLabel;
}

- (UIImageView *)tagImage{
    if (!_tagImage) {
        _tagImage = [[UIImageView alloc]init];
    }
    return _tagImage;
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
