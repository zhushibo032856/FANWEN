//
//  ZZHeadLinesCell.m
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZHeadLinesCell.h"

@implementation ZZHeadLinesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.fromLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.newsImageView];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.newsImageView.mas_left).offset(-6);
            make.height.mas_equalTo(48);
        }];
        
        [self.fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView).offset(-5);
            make.height.mas_equalTo(17);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.fromLabel);
            make.left.mas_equalTo(self.fromLabel.mas_right).offset(10);
            make.height.mas_equalTo(17);
        }];
        
        [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView).offset(-5);
            make.width.mas_equalTo(120);
        }];
        
    }
    return self;
}

- (void)initCellWith{
    self.contentLabel.text = @"江都区组织收看市专题视频调度会强调高度重";
    self.fromLabel.text = @"ZAKER客户端";
    self.timeLabel.text = @"2022-03-02 18:09";
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:@"https://alifei01.cfp.cn/creative/vcg/veer/1600water/veer-368621010.jpg"]];
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UILabel *)fromLabel{
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc]init];
        _fromLabel.textColor = kColor(153, 153, 153);
        _fromLabel.font = KUIFont(12);
    }
    return _fromLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = kColor(153, 153, 153);
        _timeLabel.font = KUIFont(12);
    }
    return _timeLabel;
}

- (UIImageView *)newsImageView{
    if (!_newsImageView) {
        _newsImageView = [[UIImageView alloc]init];
        _newsImageView.layer.masksToBounds = YES;
        _newsImageView.layer.cornerRadius = 5;
    }
    return _newsImageView;
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
