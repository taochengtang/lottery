//
//  AboutViewController.m
//  NewsComing
//
//  Created by 陶成堂 on 2017/8/24.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"
@interface AboutViewController ()
-(IBAction)phoneClick:(id)sender;
-(IBAction)QQclick:(id)sender;
-(IBAction)WebClick:(id)sender;@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.navigationController.navigationBar.hidden = NO;
    [BarItem addBackItemToVC:self];

}

//电话
-(IBAction)phoneClick:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"022-58118821"]]];
}

//QQ
-(IBAction)QQclick:(id)sender{
    
}

//官网
-(IBAction)WebClick:(id)sender{
    WebViewController *webVC = [[WebViewController alloc]init];
    [self.navigationController pushViewController:webVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
