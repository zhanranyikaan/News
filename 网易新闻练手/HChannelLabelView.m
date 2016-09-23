//
//  HChannelLabelView.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HChannelLabelView.h"

@implementation HChannelLabelView

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    HChannelLabelView *label = [[HChannelLabelView alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:18];
    
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    return label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",self.text);
}
@end
