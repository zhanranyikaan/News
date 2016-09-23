//
//  HHeadViewController.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HHeadViewController.h"
#import "HHeadViewCell.h"
#import "HHeadLine.h"

@interface HHeadViewController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSArray *data;
@end

@implementation HHeadViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupCollectionView];
}
- (void)loadData {
    [HHeadLine headLineWithCompletion:^(NSArray *headLine) {
        
//        NSMutableArray *data = [NSMutableArray arrayWithArray:headLine];
//        [data addObject:[headLine firstObject]];
//        [data insertObject:[headLine lastObject] atIndex:0];
//        NSLog(@"%@",headLine);
//        self.data = data.copy;
//        [self.collectionView reloadData];
//        
//        //滚动到第一页
//        NSIndexPath *index = [NSIndexPath indexPathForItem:1 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.data = headLine;
        [self.collectionView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }];
}

- (void)setupCollectionView {
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    NSLog(@"%@",NSStringFromCGRect(self.collectionView.bounds));
    self.layout.minimumLineSpacing = 0;
    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

#pragma mark 实现数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"headCell";
    HHeadViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    cell.headLine = self.data[indexPath.item];
    
    return cell;
}

#pragma mark 实现代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.bounds.size.width;
    NSInteger page = offsetX / width;
    
    NSInteger section = page / self.data.count;
    NSInteger sectionIndex = page % self.data.count;
    
    if (section != 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sectionIndex inSection:1];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
//    if (index == 0) {
//        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:4 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    }else if (index == 5) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//    }
}

@end
