//
//  HHTTPManager.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HHTTPManager : AFHTTPSessionManager
+ (instancetype)sharedManager;

- (void)GET:(NSString *)path parameters:(id)parameters completionHandle:(void(^)(id responseObject,NSError *error))completionHandle;
- (void)POST:(NSString *)path parameters:(id)parameters completionhandle:(void(^)(id responseObject,NSError *error))completionHandle;
@end
