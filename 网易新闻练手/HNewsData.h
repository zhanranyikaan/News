//
//  HNewsData.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNewsData : NSObject
@property (nonatomic,copy) NSString *imgsrc;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *digest;
@property (nonatomic,copy) NSString *replyCount;

//多张图片
@property (nonatomic,strong) NSArray *imgextra;
//图片类型
@property (nonatomic,copy) NSString *imgType;

+ (void)newsDataWithPath:(NSString *)path Completion:(void(^)(NSArray *data))completion;
@end
