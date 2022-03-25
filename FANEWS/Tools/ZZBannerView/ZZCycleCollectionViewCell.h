//
//  ZZCycleCollectionViewCell.h
//  FANEWS
//
//  Created by fanews on 2022/3/21.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZCycleCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) UIImageView *imageView;

@property (nonatomic, assign) BOOL hasConfigured;
@end

NS_ASSUME_NONNULL_END
