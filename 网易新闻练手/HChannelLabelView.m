//
//  HChannelLabelView.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HChannelLabelView.h"
#define HSelectedFont 18.f
#define HNormalFont 14.f

@implementation HChannelLabelView

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    HChannelLabelView *label = [[HChannelLabelView alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:HSelectedFont];
    
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:HNormalFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    return label;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    CGFloat percent = (HSelectedFont - HNormalFont) / HSelectedFont * scale;
    
    //选中字体的缩放比例为放大
    _scale = percent + 1;
    self.transform = CGAffineTransformMakeScale(_scale, _scale);
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",self.text);
}
@end
