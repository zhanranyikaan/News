//
//  HChannelCell.h
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/23.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HChannelLabel,HNewsController;
@interface HChannelCell : UICollectionViewCell
@property (nonatomic,strong) HChannelLabel *labels;
@property (nonatomic,strong) HNewsController *news;

@end
