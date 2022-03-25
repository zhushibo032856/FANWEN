//
//  ZZNetWorkManager.h
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZZNetWorkManager;

@protocol AFManegerHelpDelegate <NSObject>
//必须实现
-(void)aFManegerHelp:(ZZNetWorkManager *)afManagerHelp successResponseObject:(id)responseObject;
@optional
-(void)aFManegerHelp:(ZZNetWorkManager *)afManagerHelp error:(NSError *)error;
@end

//成功上传图片的回调
typedef void(^SuccessUploadImageBlock)(id responseObject);
//上传失败
typedef void(^FailtureUploadImageBlock)(NSError *error);


@interface ZZNetWorkManager : NSObject

@property(nonatomic, weak)id<AFManegerHelpDelegate>delegate;
//单例
+(instancetype)shareAFManegerHelp;

/**
 *  对象方法
 */
//对象方法公用接口GET请求
-(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;
//POST请求
-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;

- (void)postBody:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;


@end

NS_ASSUME_NONNULL_END
