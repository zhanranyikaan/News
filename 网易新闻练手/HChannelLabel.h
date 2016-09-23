//
//  HChannelLabel.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HChannelLabel : NSObject
@property (nonatomic,copy) NSString *tname;
@property (nonatomic,copy) NSString *tid;

+ (NSArray *)channels;
@end
