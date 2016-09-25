//
//  HDetailViewController.m
//  网易新闻练手
//
//  Created by 栈然亦卡安 on 2016/9/25.
//  Copyright © 2016年 栈然亦卡安. All rights reserved.
//

#import "HDetailViewController.h"
#import "HHTTPManager.h"

@interface HDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,copy) NSString *body;
@property (nonatomic,copy) NSString *newsTitle;
@property (nonatomic,copy) NSString *time;

@end

@implementation HDetailViewController

- (void)loadView {
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.view = self.webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    [[HHTTPManager sharedManager]GET:self.detailURL parameters:nil completionHandle:^(NSDictionary * responseObject, NSError *error) {
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSDictionary *result = responseObject[key];
        __block NSString *body = result[@"body"];
        NSArray *images = result[@"img"];
        
        [images enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 取出ref
            NSString *ref = obj[@"ref"];
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHtmlWithDict:obj]];
        }];
        
        // 标题
        NSString *title = result[@"title"];
        
        // 时间和来源
        NSString *time = [NSString stringWithFormat:@"%@  %@",result[@"ptime"],result[@"source"]];
        
        
        self.body = body;
        self.newsTitle = title;
        self.time = time;
        // 加载详情页的html
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"detail.html" withExtension:nil];
        
        // 请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 加载详情页
        [self.webView loadRequest:request];
    }];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 调用js的方法
    NSString *code = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.time,self.body];
    
    // 把js代码拼接到webView
    [webView stringByEvaluatingJavaScriptFromString:code];
}


- (NSString *)imageHtmlWithDict:(NSDictionary *)dict {
    
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\">"
                      "<span style=\"font-size: 13px;color: grey\">%@</span>",dict[@"src"],dict[@"alt"]];
    
    return html;
}

@end
