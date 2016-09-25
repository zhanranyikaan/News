//
//  HChannelController.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HChannelController.h"
#import "HChannelLabel.h"
#import "HChannelLabelView.h"
#import "HChannelCell.h"
#import "UIView+HMExt.h"
#import "HNewsController.h"

@interface HChannelController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *channels;
@property (nonatomic, assign) NSInteger currentPage;

//控制器缓存
@property (nonatomic,strong) NSMutableDictionary *controllerCache;
@end

@implementation HChannelController

- (NSMutableDictionary *)controllerCache {
    if (_controllerCache == nil) {
        _controllerCache = [NSMutableDictionary dictionary];
    }
    return _controllerCache;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self loadData];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupCollectionView];
}
- (void)setupCollectionView {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.layout.minimumLineSpacing = 0;
    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)loadData {
    NSArray *channels = [HChannelLabel channels];
    
    channels = [channels sortedArrayUsingComparator:^NSComparisonResult(HChannelLabel *  _Nonnull obj1, HChannelLabel *  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    self.channels = channels;
    
    __block CGFloat labelX = 0;
    [channels enumerateObjectsUsingBlock:^(HChannelLabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat labelY = 0;
        CGFloat labelH = self.scrollView.height;
        HChannelLabelView *label = [HChannelLabelView channelLabelWithTitle:obj.tname];
        
        //如果选中第一个
        if (idx == 0) {
            label.scale = 1;
        }
        
        __weak typeof(label) weakLabel = label;
        __weak typeof(self) weakSelf = self;
        [label setClickChannel:^{
            
            NSIndexPath *index = [NSIndexPath indexPathForItem:idx inSection:0];
            
            [weakSelf.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            
            
            HChannelLabelView *currentLabel  = weakSelf.scrollView.subviews[weakSelf.currentPage];
            
            if (currentLabel == weakSelf) {
                return ;
            }
            currentLabel.scale = 0;
            weakLabel.scale = 1;
            weakSelf.currentPage = idx;
            [weakSelf adjOffset];
            
        }];
        
        CGFloat labelW = label.width;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [self.scrollView addSubview:label];
        labelX += labelW;
    }];
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
}


#pragma mark 实现代理和数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HCELL" forIndexPath:indexPath];
    
    [cell.news.view removeFromSuperview];
    cell.labels = self.channels[indexPath.item];
    
    HChannelLabel *channel = self.channels[indexPath.item];
    HNewsController *new = [self controllerWithChannel:channel];
    
    [cell.contentView addSubview:new.view];
    new.view.frame = cell.bounds;
    cell.news = new;
    
    if (![self.childViewControllers containsObject:new]) {
        [self addChildViewController:new];
    }
    return cell;
}

- (HNewsController *)controllerWithChannel:(HChannelLabel *)channel {
    HNewsController *news = [self.controllerCache objectForKey:channel.tname];
    
    if (news == nil) {
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        news = [st instantiateInitialViewController];
        NSString *urlstring = [NSString stringWithFormat:@"article/headline/%@/0-20.html",channel.tid];
        news.stringURL = urlstring;
        [self.controllerCache setObject:news forKey:channel.tname];
    }
    return news;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    HChannelLabelView *currentLabel = self.scrollView.subviews[self.currentPage];
    NSArray *index = [self.collectionView indexPathsForVisibleItems];
    
    //记录即将被选中的label
    __block HChannelLabelView *nextLabel;
    [index enumerateObjectsUsingBlock:^(NSIndexPath *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.item != self.currentPage) {
            nextLabel = self.scrollView.subviews[obj.item];
        }
    }];
    
        if (nextLabel == nil) {
            return ;
        }
        
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat scale = ABS(offsetX / scrollView.width - self.currentPage);
        CGFloat currentScale = 1 - scale;
        currentLabel.scale = currentScale;
        nextLabel.scale = scale;
        
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentPage = offsetX / scrollView.width;
}

- (void)adjOffset {
    // 取出选中的label
    // 取出当前选中的label
    HChannelLabelView *currentLabel = self.scrollView.subviews[self.currentPage];
    
    // 取出选中的label的x值
    CGFloat labelX = currentLabel.x;
    CGFloat offsetX = 0;
    if (labelX > self.scrollView.width * 0.5) {
        // 偏移的offset值
        offsetX = labelX - self.scrollView.width * 0.5;
    }
    
    
    // 判断offset 跟 contentSize 的关系
    if (labelX > (self.scrollView.contentSize.width - self.scrollView.width * 0.5)) {
        // 偏移的offset值
        offsetX = (self.scrollView.contentSize.width - self.scrollView.width);
    }
    
    if (labelX < self.scrollView.width * 0.5) {
        // 偏移的offset值
        offsetX = 0;
    }
    // 设置scrollView的offset
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

@end
