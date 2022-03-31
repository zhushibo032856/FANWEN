//
//  ZZDigitalCell.h
//  FANEWS
//
//  Created by fanews on 2022/3/30.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZDigitalCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsName;
@property (weak, nonatomic) IBOutlet UIButton *collectionBT;


@end

NS_ASSUME_NONNULL_END
