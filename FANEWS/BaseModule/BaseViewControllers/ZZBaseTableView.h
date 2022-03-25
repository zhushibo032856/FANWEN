//
//  ZZBaseTableView.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseTableView : UITableView<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) FBKVOController *kvoController;
@property (nonatomic, strong) UILabel *stringLabel;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat noDataHeight;

@end

NS_ASSUME_NONNULL_END
