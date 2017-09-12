//
//  Const.h
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//
// GitHub最新下载地址：https://github.com/borenfocus/NewsComing

#ifndef Const_h
#define Const_h

//标题字体
#define kTitleFont      [UIFont systemFontOfSize:15]
//子标题字体
#define kSubtitleFont      [UIFont systemFontOfSize:13]

#define BJScreenWidth [UIScreen mainScreen].bounds.size.width
#define BJScreenHeight [UIScreen mainScreen].bounds.size.height

//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define TESTCOLOR(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]


//常用颜色宏
#define kColorWhite           [UIColor whiteColor]
#define kColorYellow          [UIColor yellowColor]
#define kColorRed             [UIColor redColor]
#define kColorBlack           [UIColor blackColor]
#define kColorClear           [UIColor clearColor]

//常用字体宏
#define kJobLabel     [UIFont  systemFontOfSize:15.0f]

#define kSendSheepLabel     [UIFont  systemFontOfSize:15.0f]
#define kdefaultLabel     [UIFont  systemFontOfSize:13.0f]
#define kBtnOfLabel     [UIFont  systemFontOfSize:12.0f]
#define kBuyLabel     [UIFont  systemFontOfSize:14.0f]
#define kSNLabel      [UIFont systemFontOfSize:11.0f]
#define kTimeLabel     [UIFont  systemFontOfSize:10.0f]
#define kStateLabel [UIFont systemFontOfSize:7.0f]

#define isLoginName [[NSUserDefaults standardUserDefaults] objectForKey:@"login"]
#define userInfoDic [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]

//应用程序的屏幕高度
#define kWindowH        [UIScreen mainScreen].bounds.size.height
//应用程序的屏幕宽度
#define kWindowW        [UIScreen mainScreen].bounds.size.width

/// 服务器域名.
#define BASE_URL @"http://1dingda.com/"


//新浪微博
#define Share_SinaWeiBo_Key @"4029962457"
#define Share_SinaWeiBo_Secret @"a5741420c10e5383c81565186bb0b03b"

//微信
#define Share_WeiXin_Key @"wx95c8247d9814bf39"
#define Share_WeiXin_Secret @"4b6b7d0f3f4390a561720af120a50d45"

#define QQ_AppID                   @"1105656979"
#define QQ_AppKey                  @"IMxLDihRkh2423ef"

//通过Storyboard ID 在对应Storyboard中获取场景对象  （\：换行）
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距   Preserve:保存
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif /* Const_h */
