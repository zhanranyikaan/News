//
//  HAPIManager.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAPIManager : NSObject
+ (instancetype)sharedManager;
- (void)requestHeadLineWithCompletionHandle:(void(^)(id responseObject,NSError *error))completionHandle;

- (void)requestNewsDataWithPath:(NSString *)path CompletionHandle:(void(^)(id responseObject,NSError *error))completionHandle;
@end
