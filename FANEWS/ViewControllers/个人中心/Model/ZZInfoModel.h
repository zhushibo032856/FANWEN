//
//  ZZInfoModel.h
//  FANEWS
//
//  Created by fanews on 2022/3/18.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (copy,nonatomic)NSString *name;

@property (copy,nonatomic)NSString *sex;

@property (copy,nonatomic) NSString *age;

@end

@interface People : NSObject

@property (copy,nonatomic) User *User;

@property (copy,nonatomic)NSString *height;

@property (copy,nonatomic) NSString *wight;


@end

@interface ZZPeople : NSObject

@property (copy,nonatomic) NSArray *UserArr;

@property (copy,nonatomic)NSString *height;

@property (copy,nonatomic) NSString *wight;


@end

NS_ASSUME_NONNULL_END
