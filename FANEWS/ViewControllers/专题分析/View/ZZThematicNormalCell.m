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
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.lineLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(12);
            make.left.right.mas_equalTo(self.contentView);
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(18);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView);
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

+ (CGFloat)heightWithModel:(ZZTextModel *)model{
    
    NSString *string = model.text;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange allRange = [string rangeOfString:string];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor]range:allRange];
    CGFloat titleHeight;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // 获取label的最大宽度
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(kScreenWidth - 30, CGFLOAT_MAX)options:options context:nil];
    titleHeight = ceilf(rect.size.height);
    return titleHeight + 50; // 动态高度 + 静态高度
}

- (void)initCellWith:(ZZTextModel *)model{
    self.titleLabel.text = model.text;
    self.typeLabel.text = [NSString stringWithFormat:@"indexPath"];
    self.timeLabel.text = @"2022-03-02 18:09";
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

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.textColor = kColor(153, 153, 153);
        _typeLabel.font = KUIFont(12);
    }
    return _typeLabel;
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
