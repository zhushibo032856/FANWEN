//
//  ZZNetWorkManager.m
//  FANEWS
//
//  Created by fanews on 2022/3/15.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZNetWorkManager.h"
#import "AFHTTPSessionManager.h"

@implementation ZZNetWorkManager

+(instancetype )shareAFManegerHelp{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

-(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    NSLog(@"%@%@",URLString,parameters);
  
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (success) {//并且code = 正确
            if ([responseObject[@"code"] intValue] == 0) {
                success(responseObject);
            }else if([responseObject[@"code"] intValue] == 10086){
                NSLog(@"401");
                [MBProgressHUD showError:@"用户信息已过期,请重新登录"];

            }else{
                [MBProgressHUD showError:responseObject[@"msg"]];
               // success(responseObject);
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        failure(error);
    }];
    
    
}
-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    NSLog(@"%@%@",URLString,parameters);
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];

    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
     //   NSLog(@"%@",responseObject);
        if (success) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                success(responseObject);
            }else if([responseObject[@"code"] intValue] == 10086){
                NSLog(@"401");
                [MBProgressHUD showError:@"用户信息已过期,请重新登录"];
                
            }else{
                [MBProgressHUD showError:responseObject[@"msg"]];
              //  success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"%ld",error.code);
        failure(error);
    }];
}

- (void)postBody:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:15];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg", nil];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request setHTTPMethod:@"POST"];
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:bodyData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)bodyData.length] forHTTPHeaderField:@"Content-Length"];
    if (kStringIsEmpty(@"") == YES) {
        [request setValue:@"" forHTTPHeaderField:@"Authorization"];
    }else{
        [request setValue:[NSString stringWithFormat:@"Bearer %@",@""] forHTTPHeaderField:@"Authorization"];
    }
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                success(responseObject);
            }else if([responseObject[@"code"] intValue] == 10086){
               
                [MBProgressHUD showError:@"用户信息已过期,请重新登录"];
               
            }else{
                [MBProgressHUD showError:responseObject[@"msg"]];
              //  success(responseObject);
            }
        }
    }] resume];
    
}

//配置AFManager
-(AFHTTPSessionManager *)AFHTTPSessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setTimeoutInterval:15];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (kStringIsEmpty(@"") == YES) {
        
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }else{
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",@""] forHTTPHeaderField:@"Authorization"];
    }
    
    
    return manager;
}


@end
