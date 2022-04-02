//
//  ZZEditCell.h
//  FANEWS
//
//  Created by fanews on 2022/4/2.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZEditCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZZEditCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusBt;

@property (nonatomic, strong) ZZEditCellModel *data;

- (void)resetModel:(ZZEditCellModel *)data :(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
