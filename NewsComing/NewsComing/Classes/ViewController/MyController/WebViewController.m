//
//  WebViewController.m
//  JWCP
//
//  Created by 陶成堂 on 2017/7/20.
//  Copyright © 2017年 zuqiu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"官方网址";
    
    self.navigationController.navigationBar.hidden = NO;
    [BarItem addBackItemToVC:self];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *url = @"https://www.baidu.com";   //
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
