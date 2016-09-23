//
//  UIView+HMExt.h
//  01-网易彩票
//
//  Created by HM on 16/3/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HMExt)
@property (nonatomic, assign) CGFloat x;// @property 生成setter 和 getter
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
//- (void)setX:(CGFloat)x; 如果使用 property 不太懂，可以使用setter和getter方法，效果是一样的
//- (CGFloat)x;
@end
