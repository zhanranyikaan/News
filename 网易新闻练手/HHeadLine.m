//
//  HHeadLine.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HHeadLine.h"
#import "HAPIManager.h"
#import <YYModel/YYModel.h>

@implementation HHeadLine

+ (void)headLineWithCompletion:(void (^)(NSArray *))completion {
    [[HAPIManager sharedManager]requestHeadLineWithCompletionHandle:^(NSDictionary * responseObject, NSError *error) {
        if (responseObject) {
            NSString *key = responseObject.keyEnumerator.nextObject;
            NSArray *data = responseObject[key];
            
            NSArray *headLine = [NSArray yy_modelArrayWithClass:self json:data];
            completion(headLine);
        }else {
            completion(nil);
        }
    }];
}
@end
