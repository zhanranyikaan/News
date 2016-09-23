//
//  HHTTPManager.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HHTTPManager.h"
#define HBaseURL  [NSURL URLWithString:@"http://c.m.163.com/nc/"]

@implementation HHTTPManager
+ (instancetype)sharedManager {
    static HHTTPManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:HBaseURL];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript" ,@"text/html", nil];
    });
    return manager;
}

- (void)GET:(NSString *)path parameters:(id)parameters completionHandle:(void (^)(id, NSError *))completionHandle {
    [self GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil,error);
    }];
}

- (void)POST:(NSString *)path parameters:(id)parameters completionhandle:(void (^)(id, NSError *))completionHandle {
    [self POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil,error);
    }];
}
@end
