//
//  HChannelLabelView.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HChannelLabelView : UILabel
+ (instancetype)channelLabelWithTitle:(NSString *)title;
@property (nonatomic, assign) CGFloat scale;
@end
