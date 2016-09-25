//
//  HChannelLabelView.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HChannelLabelView : UILabel
//创建一个频道的label
+ (instancetype)channelLabelWithTitle:(NSString *)title;
//缩放比例
@property (nonatomic, assign) CGFloat scale;

//点击回调
@property (nonatomic,copy) void (^clickChannel)();
@end
