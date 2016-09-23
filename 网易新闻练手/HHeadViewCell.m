//
//  HHeadViewCell.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HHeadViewCell.h"
#import "HHeadLine.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HHeadViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIPageControl *pageContro;

@end
@implementation HHeadViewCell

-(void)setHeadLine:(HHeadLine *)headLine {
    _headLine = headLine;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_headLine.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.title.text = _headLine.title;
    self.pageContro.currentPage = self.tag ;
    
}
@end
