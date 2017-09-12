//
//  URLWeb.m
//  ahssc
//
//  Created by zuqiu on 17/3/31.
//  Copyright © 2017年 zuqiu. All rights reserved.
//

#import "URLWeb.h"

@interface URLWeb ()
{
    UIWebView *webView;
}
@end

@implementation URLWeb

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    btn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btn];
    
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:_reLastURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [web sizeToFit];
    [self.view addSubview:web];
    
    // 禁止回弹
    web.scrollView.bounces = NO;
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width ,20)];
    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



@end
