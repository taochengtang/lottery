//
//  HomeDetailController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeDetailController.h"
#import "CommentViewController.h"

@interface HomeDetailController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation HomeDetailController

- (instancetype)initWithID:(NSInteger)ID {
    if (self = [super init]) {
        self.ID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [BarItem addBackItemToVC:self];
    self.title = @"新闻详情";
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItemBtn];
    [self webView];
}

-(UIBarButtonItem *)rightBarButtonItemBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 20);
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

-(void)rightClick{
    CommentViewController *commentVC = [[CommentViewController alloc]init];
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    if ([type integerValue] == 2) {
    commentVC.orderId = _comment;
    }else{
    commentVC.orderId = [NSString stringWithFormat:@"%ld",self.ID];
    }
    [self.navigationController pushViewController:commentVC animated:YES];
}


#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self hideLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self hideLoad];
}

#pragma mark - 懒加载
- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
        if ([type integerValue] == 2) {
            NSString *path = [NSString stringWithFormat:@"%@",_url];
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        }else{
        NSString *path = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov5.0.0/content/news/newscontent-n%ld-t0-rct1.json", self.ID];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];

        }
    }
    return _webView;
}

@end
