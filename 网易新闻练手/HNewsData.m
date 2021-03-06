//
//  HNewsData.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HNewsData.h"
#import "HAPIManager.h"
#import "HMoreImage.h"
#import <YYModel/YYModel.h>

@implementation HNewsData

- (void)setDocid:(NSString *)docid {
    _docid = docid;
    self.detailURL = [NSString stringWithFormat:@"article/%@/full.html",docid];
}
+ (void)newsDataWithPath:(NSString *)path Completion:(void (^)(NSArray *))completion {
    [[HAPIManager sharedManager]requestNewsDataWithPath:path CompletionHandle:^(NSDictionary * responseObject, NSError *error) {
        if (responseObject) {
            NSString *key = responseObject.keyEnumerator.nextObject;
            NSArray *data = responseObject[key];
            
            NSArray *newsData = [NSArray yy_modelArrayWithClass:self json:data];
            completion(newsData);
        }else {
            completion(nil);
        }
    }];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"imgextra" : [HMoreImage class]};
}
@end
