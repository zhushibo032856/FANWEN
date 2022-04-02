//
//  DataManager.h
//  PanCollectionView
//
//  Created by lizq on 16/8/31.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;//所有名称
@property (nonatomic, strong) NSMutableArray *headArray;//我的应用
@property (nonatomic, strong) NSMutableArray *titleArray;//标题分类
@property (nonatomic, assign) BOOL isShowHeaderMessage;
@property (nonatomic, assign) BOOL isEditing;

+ (DataManager *)shareDataManager;
@end
