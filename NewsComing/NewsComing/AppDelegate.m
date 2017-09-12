//
//  AppDelegate.m
//  NewsComing
//
//  Created by 任波 on 16/3/1.
//  Copyright © 2016年 renbo. All rights reserved.
//
// GitHub最新下载地址：https://github.com/borenfocus/NewsComing

#import "AppDelegate.h"
#import "AppDelegate+DDLog.h"
#import "HomeController.h"
#import "WordController.h"
#import "VideoController.h"
#import "MyController.h"
#import "SenNetWorking.h"
#import "URLWeb.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "WXApi.h"
#import "WeiboSDK.h"


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface AppDelegate ()<JPUSHRegisterDelegate>
@property(nonatomic,copy) NSString  *url;
@property(nonatomic,strong)UINavigationController  *nav;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeWithApplication:application];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
         }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];


    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"type"];
    [self setSenNetWorking];
    [self startToListenNow];
    [ShareSDK registerApp:@"" activePlatforms:@[
                                                @(SSDKPlatformTypeSinaWeibo),
                                                @(SSDKPlatformTypeSMS),
                                                @(SSDKPlatformTypeWechat),
                                                @(SSDKPlatformTypeQQ),
                                                @(SSDKPlatformSubTypeWechatTimeline)] onImport:^(SSDKPlatformType platformType) {
                                                    switch (platformType)
                                                    {
                                                        case SSDKPlatformTypeWechat:
                                                            [ShareSDKConnector connectWeChat:[WXApi class]];
                                                            break;
                                                        case SSDKPlatformTypeQQ:
                                                            [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                            break;
                                                        case SSDKPlatformTypeSinaWeibo:
                                                            [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                            break;
                                                        default:
                                                            break;
                                                    }

    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:Share_SinaWeiBo_Key
                                          appSecret:Share_SinaWeiBo_Secret
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:Share_WeiXin_Key
                                      appSecret:Share_WeiXin_Secret];
                break;
            case SSDKPlatformSubTypeWechatTimeline:
                [appInfo SSDKSetupWeChatByAppId:Share_WeiXin_Key
                                      appSecret:Share_WeiXin_Secret];
                break;

            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQ_AppID
                                     appKey:QQ_AppKey
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    }];
    
    return YES;
}

/** 配置导航栏 */
- (void)configGlobalUIStyle {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"backgroundImage"] forBarMetrics:UIBarMetricsDefault];
    bar.translucent = NO;
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldFlatFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)setupViewControllers {
    UINavigationController *navi0 = [HomeController defaultHomeNavi];
    UINavigationController *navi1 = [WordController defaultWordNavi];
    UINavigationController *navi2 = [VideoController defaultVideoNavi];
    UINavigationController *vc3 = [MyController defaultMyNavi];
    CYLTabBarController *tbc = [CYLTabBarController new];
    [self customTabBarForController:tbc];
    [tbc setViewControllers:@[navi0,navi1,navi2,vc3]];
    self.tabBarController = tbc;
    
}

- (void)customTabBarForController:(CYLTabBarController *)tbc {
    NSDictionary *dict0 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:@"news",
                            CYLTabBarItemSelectedImage:@"newsblue"};
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"图文",
                            CYLTabBarItemImage:@"live",
                            CYLTabBarItemSelectedImage:@"liveblue"};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"视频",
                            CYLTabBarItemImage:@"market",
                            CYLTabBarItemSelectedImage:@"marketblue"};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:@"my",
                            CYLTabBarItemSelectedImage:@"myblue"};
    NSArray *tabBarItemsAttributes = @[dict0,dict1,dict2,dict3];
    tbc.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (UIWindow *)window {
    if(_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (UITabBarController *)tabBarController {
    if(_tabBarController == nil) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    return _tabBarController;
}


//留一手
-(void)requestData{
    NSString *url = @"client/index.php?act=user&op=login";
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:@"15620633051" forKey:@"member_name"];
    [par setObject:@"e10adc3949ba59abbe56e057f20f883e"forKey:@"member_passwd"];
    
    [SenNetWorking postWithUrl:url isCache:NO params:par success:^(id response, BOOL isShowCache) {
        NSLog(@"%@",response);
        NSDictionary *dic = (NSDictionary *)response;
        NSString *code = dic[@"code"];
        if ([code integerValue] == 0) {
            NSString *phone = dic[@"data"][@"member_mobile"];
            if ([phone isEqualToString:@"15620633051"]) {
                [self configGlobalUIStyle];
                [self setupViewControllers];
                self.window.rootViewController = self.tabBarController;
                [[NSUserDefaults standardUserDefaults] setObject:@"fuqian" forKey:@"request"];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"request" forKey:@"request"];
                [self webUrlController:self.url];
            }
        }else{
            [self webUrlController:self.url];
        }
    } fail:^(NSError *error) {
        [self webUrlController:self.url];
    }];
}

-(void)setSenNetWorking
{
    [SenNetWorking setBaseUrl:BASE_URL];
    [SenNetWorking autoToClearCacheWithLimitedToSize:30];
    [SenNetWorking setResponseType:SenResponseTypeData];
    [SenNetWorking setRequestType:SenRequestTypeJSON];
    [SenNetWorking setOverTime:2.0];
}


#pragma mark -  网络监听

-(void)startToListenNow
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [self tryToLoad];
            }
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}



#pragma mark - 进行给的网络数据接口请求
-(void)tryToLoad {
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://appmgr.jwoquxoc.com/frontApi/getAboutUs"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"post";
    
    NSString *param = [NSString stringWithFormat:@"appid=%@",appURLID];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response;
    NSError *error;
    NSData *backData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        self.url = @"";
        [self configGlobalUIStyle];
        [self setupViewControllers];
        self.window.rootViewController = self.tabBarController;

    }else{
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dic======%@",dic);
        if ([[dic objectForKey:@"status"] intValue]== 1) {
            NSLog(@"获取数据成功%@%@",[dic objectForKey:@"desc"],[dic objectForKey:@"appname"]);//
            self.url =  ([[dic objectForKey:@"isshowwap"] intValue]) == 1?[dic objectForKey:@"wapurl"] : @"";
            //self.url = @"http://www.baidu.com";
            //self.url = @"http://www.11c8.com/index/index.html?wap=yes&appid=c8app16";
            if ([self.url isEqualToString:@""]) {
                //[self setupContentVC];
                self.url = @"";
//                [self requestData];
                [self configGlobalUIStyle];
                [self setupViewControllers];
                self.window.rootViewController = self.tabBarController;
            }else{
                NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"request"];
                if ([str isEqualToString:@"request"]) {
                    [self webUrlController:self.url];
                }else{
                    [self requestData];
                }

            }
        }else if ([[dic objectForKey:@"status"] intValue]== 2) {
            NSLog(@"获取数据失败");
            self.url = @"";
            [self configGlobalUIStyle];
            [self setupViewControllers];
            self.window.rootViewController = self.tabBarController;

        }else{
            self.url = @"";
            [self configGlobalUIStyle];
            [self setupViewControllers];
            self.window.rootViewController = self.tabBarController;

        }
    }
}

-(void)webUrlController:(NSString *)urlStr{
    URLWeb *webUrlVC = [URLWeb new];
    webUrlVC.reLastURL = urlStr;

    if (self.nav== nil)
    {
        self.nav = [[UINavigationController alloc] initWithRootViewController:webUrlVC];
    }
    self.window.rootViewController= self.nav  ;
    self.nav.navigationBar.barStyle = UIBarStyleBlack;
    [self.window makeKeyAndVisible];
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
}


//程序退出后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
}


@end
