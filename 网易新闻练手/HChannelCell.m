//
//  HChannelCell.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/23.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HChannelCell.h"
#import "HChannelLabel.h"
#import "HNewsController.h"

@interface HChannelCell ()
@property (nonatomic,strong) HNewsController *news;

@end
@implementation HChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    HNewsController *news = [st instantiateInitialViewController];
    [self.contentView addSubview:news.view];
    news.view.frame = self.contentView.bounds;
    self.news = news;
}
- (void)setLabels:(HChannelLabel *)labels {
    _labels = labels;
    NSString *stringURL = [NSString stringWithFormat:@"article/headline/%@/0-20.html",_labels.tid];
    self.news.stringURL = stringURL;
}

@end
