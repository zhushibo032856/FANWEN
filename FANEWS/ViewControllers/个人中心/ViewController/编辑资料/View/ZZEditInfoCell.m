//
//  ZZEditInfoCell.m
//  FANEWS
//
//  Created by fanews on 2022/4/6.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZEditInfoCell.h"

@interface ZZEditInfoCell ()<UITextFieldDelegate>

@end

@implementation ZZEditInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.infoTF];
        [self.contentView addSubview:self.lineLabel];
        [self.contentView addSubview:self.nextImageView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(70);
        }];
        
        [self.infoTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.nextImageView.mas_left).offset(-20);
            make.left.mas_equalTo(self.titleLabel).offset(20);
        }];
        
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(.5);
        }];
        
        [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(15);
        }];
        
    }
    return self;
}

- (void)initCellWith{
    
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = kColor(230, 230, 230);
    }
    return _lineLabel;
}

- (UITextField *)infoTF{
    if (!_infoTF) {
        _infoTF = [[UITextField alloc]init];
        _infoTF.textAlignment = NSTextAlignmentRight;
        _infoTF.placeholder = @"待完善";
        _infoTF.delegate = self;
    }
    return _infoTF;
}

- (UIImageView *)nextImageView{
    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc]init];
        _nextImageView.image = [UIImage imageNamed:@"next"];
    }
    return _nextImageView;
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
