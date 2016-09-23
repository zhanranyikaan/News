//
//  HChannelLabel.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HChannelLabel.h"
#import <YYModel/YYModel.h>

@implementation HChannelLabel
+ (NSArray *)channels {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *key = dict.keyEnumerator.nextObject;
    NSArray *arr = dict[key];
    NSArray *channels = [NSArray yy_modelArrayWithClass:self json:arr];
    return channels;
}
@end
