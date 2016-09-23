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

@interface HNewsController ()
@property (weak, nonatomic) IBOutlet UIView *headLineView;
@property (nonatomic,strong) NSArray *data;

@end

@implementation HNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
//- (void)setStringURL:(NSString *)stringURL {
//    _stringURL = stringURL;
//    [self loadData];
//}
#pragma mark 加载数据
- (void)loadData {
    [HNewsData newsDataWithCompletion:^(NSArray *data) {
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
    cell.news = self.data[indexPath.item];
    return cell;
}

#pragma mark 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNewsData *news = self.data[indexPath.item];
    return [HNewsCell cellHeightWithNews:news];
}
@end
