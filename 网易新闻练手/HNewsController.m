//
//  HNewsController.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/22.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HNewsController.h"
#import "HNewsData.h"
#import "HNewsCell.h"
#import "HDetailViewController.h"

@interface HNewsController ()
@property (weak, nonatomic) IBOutlet UIView *headLineView;
@property (nonatomic,strong) NSArray *data;

@end

@implementation HNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.tableFooterView = [[UIView alloc] init];
    
   
}
- (void)setStringURL:(NSString *)stringURL {
    _stringURL = stringURL;
    [self loadData];
}
#pragma mark 加载数据
- (void)loadData {
    [HNewsData newsDataWithPath:self.stringURL Completion:^(NSArray *data) {
//        NSLog(@"%@",data);
        self.data = data;
        [self.tableView reloadData];
    }];
}

#pragma mark 实现数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNewsData *news = self.data[indexPath.item];
    HNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[HNewsCell cellIdentifierWithNews:news] forIndexPath:indexPath];
    
    cell.news = news;
    return cell;
}

#pragma mark 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNewsData *news = self.data[indexPath.item];
    return [HNewsCell cellHeightWithNews:news];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出对应的新闻
    HNewsData *news = self.data[indexPath.row];
    // 初始化详情页控制器
    HDetailViewController *detail = [[HDetailViewController alloc]init];
    // 设置详情页的URL
    detail.detailURL = news.detailURL;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
