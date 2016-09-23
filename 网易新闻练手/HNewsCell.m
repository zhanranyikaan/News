//
//  HNewsCell.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HNewsCell.h"
#import "HNewsData.h"
#import "HMoreImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ltitle;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextra;

@end
@implementation HNewsCell
- (void)setNews:(HNewsData *)news {
    _news = news;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_news.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.title.text = _news.title;
    self.ltitle.text = _news.digest;
    //回帖数
    if (_news.replyCount) {
        self.replyCount.text = [NSString stringWithFormat:@"%@人跟帖",_news.replyCount];
    }else {
        self.replyCount.text = [NSString stringWithFormat:@"%@人跟帖",@"0"];
    }
    //更多图片
    if (_news.imgextra) {
        [_news.imgextra enumerateObjectsUsingBlock:^(HMoreImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = self.imgextra[idx];
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
        }];
    }
}

+ (NSString *)cellIdentifierWithNews:(HNewsData *)News {
    NSString *identifier;
    if (News.imgextra) {
        identifier = @"HMoreImageCell";
    }else if ([News.imgType isEqualToString:@"1"]) {
        identifier = @"HBigImageCell";
    }else {
        identifier = @"Hcell";
    }
    return identifier;
}

+ (CGFloat)cellHeightWithNews:(HNewsData *)news {
    CGFloat height = 0;
    if (news.imgextra) {
        height = 140;
    }else if ([news.imgType isEqualToString:@"1"]) {
        height = 160;
    }else {
        height = 120;
    }
    return height;
}
@end
