//
//  ZZThematicNormalCell.m
//  FANEWS
//
//  Created by fanews on 2022/3/24.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZThematicNormalCell.h"

@implementation ZZThematicNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.newsImageView];
        [self.contentView addSubview:self.timeImageView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.lineLabel];
        
        [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(20);
            make.bottom.mas_equalTo(self.contentView).offset(-20);
            make.width.mas_equalTo(145);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(20);
            make.left.mas_equalTo(self.newsImageView.mas_right).offset(12);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_lessThanOrEqualTo(65);
        }];
        
        [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.newsImageView.mas_right).offset(12);
            make.bottom.mas_equalTo(self.contentView).offset(-22.5);
            make.width.height.mas_equalTo(10);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.timeImageView.mas_right).offset(5);
        }];
        
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(.5);
        }];
    }
    return self;
}

- (void)initCellWith:(ZZTextModel *)model{
    self.titleLabel.text = model.text;
    self.timeLabel.text = @"2022-03-02 18:09";
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg"]];
}

- (UIImageView *)newsImageView{
    if (!_newsImageView) {
        _newsImageView = [[UIImageView alloc]init];
        _newsImageView.layer.masksToBounds = YES;
        _newsImageView.layer.cornerRadius = 8;
    }
    return _newsImageView;
}

- (UIImageView *)timeImageView{
    if (!_timeImageView) {
        _timeImageView = [[UIImageView alloc]init];
        _timeImageView.image = [UIImage imageNamed:@"Thematic-2"];
    }
    return _timeImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = kColor(29, 36, 43);
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = KUIFont(17);
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = kColor(153, 153, 153);
        _timeLabel.font = KUIFont(12);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = kColor(235, 235, 235);
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
