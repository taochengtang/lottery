//
//  AppDelegate.h
//  NewsComing
//
//  Created by 任波 on 16/3/1.
//  Copyright © 2016年 renbo. All rights reserved.
//
// GitHub最新下载地址：https://github.com/borenfocus/NewsComing

#import <UIKit/UIKit.h>
#define AFURL @"http://appmgr.jwoquxoc.com/frontApi/getAboutUs?appid="
#define appURLID @"c66app160"


#warning "极光的appKey 打包出去需根据提示修改"
//dff888e4f8e41251f2fc7fc8
//7c1ebdefa5269badde3345f8
static NSString *appKey = @"ba4547f5b22f87cd2d97b69e";
static NSString *channel = @"Publish channel";
static BOOL isProduction = true;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end

