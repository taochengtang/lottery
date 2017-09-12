//
//  IntroduceViewController.m
//  NewsComing
//
//  Created by 陶成堂 on 2017/8/24.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"软件介绍";
    
    self.navigationController.navigationBar.hidden = NO;
    [BarItem addBackItemToVC:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
