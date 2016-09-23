//
//  HAPIManager.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HAPIManager.h"
#import "HHTTPManager.h"

@implementation HAPIManager
+ (instancetype)sharedManager {
    static HAPIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)requestHeadLineWithCompletionHandle:(void (^)(id, NSError *))completionHandle {
    [[HHTTPManager sharedManager]GET:@"ad/headline/0-4.html" parameters:nil completionHandle:completionHandle];
}

- (void)requestNewsDataWithCompletionHandle:(void (^)(id, NSError *))completionHandle {
    [[HHTTPManager sharedManager]GET:@"article/headline/T1348649580692/0-20.html" parameters:nil completionHandle:completionHandle];
}
@end
