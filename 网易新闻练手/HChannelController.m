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

@interface HChannelController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *channels;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation HChannelController

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
    cell.labels = self.channels[indexPath.item];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    HChannelLabelView *currentLabel = self.scrollView.subviews[self.currentPage];
    NSArray *index = [self.collectionView indexPathsForVisibleItems];
    __block HChannelLabelView *nextLabel;
    [index enumerateObjectsUsingBlock:^(NSIndexPath *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.item != self.currentPage) {
            nextLabel = self.scrollView.subviews[obj.item];
        }
        
        if (nextLabel == nil) {
            return ;
        }
        
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat scale = ABS(offsetX / scrollView.width - self.currentPage);
        CGFloat currentScale = 1 - scale;
        currentLabel.scale = currentScale;
        nextLabel.scale = scale;
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentPage = offsetX / scrollView.width;
}
@end
