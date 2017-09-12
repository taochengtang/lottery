//
//  InvitationViewController.m
//  Truck_WindCat
//
//  Created by ChengTang on 16/5/28.
//  Copyright © 2016年 BJKJ. All rights reserved.
//

#import "InvitationViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <UIImageView+WebCache.h>

#import "WeiboSDK.h"

#import "WXApi.h"


@interface InvitationViewController ()

@property (nonatomic,strong)IBOutlet UIImageView *QRcodeImg;
@property (nonatomic,strong)NSString *url;

-(IBAction)wechat:(id)sender;
-(IBAction)fiendsCricle:(id)sender;
-(IBAction)sina:(id)sender;
-(IBAction)smsBtn:(id)sender;

@property (nonatomic,strong)IBOutlet UILabel *wechat;
@property (nonatomic,strong)IBOutlet UILabel *Circle;
@property (nonatomic,strong)IBOutlet UILabel *micrBlog;
@property (nonatomic,strong)IBOutlet UILabel *information;
@property (nonatomic,strong)IBOutlet UILabel *con;


@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = @"分享好友";
    self.navigationController.navigationBar.hidden = NO;
    [BarItem addBackItemToVC:self];
    
    [self requestShare];
}

-(IBAction)wechat:(id)sender{

    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    [shareParams SSDKSetupShareParamsByText:@"秀才不出门，便知天下事"
                                     images:[UIImage imageNamed:@"zj1024x1024"] //传入要分享的图片
                                        url:[NSURL URLWithString:_url  ]
                                      title:@"66"
                                       type:SSDKContentTypeAuto];

    //进行分享
    [ShareSDK share:SSDKPlatformTypeWechat //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         NSLog(@"%@",error.userInfo);
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:[NSString stringWithFormat:@"%@",error.userInfo[@"error_message"]]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }

     }];
}


-(IBAction)fiendsCricle:(id)sender{
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    [shareParams SSDKSetupShareParamsByText:@"秀才不出门，便知天下事"
                                     images:[UIImage imageNamed:@"zj1024x1024"] //传入要分享的图片
                                        url:[NSURL URLWithString:_url  ]
                                      title:@"66"
                                       type:SSDKContentTypeAuto];

    //进行分享
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         NSLog(@"%@",error.userInfo);
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:[NSString stringWithFormat:@"%@",error.userInfo[@"error_message"]]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }

     }];
}

-(IBAction)sina:(id)sender{
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    [shareParams SSDKSetupShareParamsByText:@"秀才不出门，便知天下事"
                                     images:[UIImage imageNamed:@"zj1024x1024"] //传入要分享的图片
                                        url:[NSURL URLWithString:_url  ]
                                      title:@"66"
                                       type:SSDKContentTypeAuto];

    //进行分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         NSLog(@"%@",error.userInfo);
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:[NSString stringWithFormat:@"%@",error.userInfo[@"error_message"]]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }

     }];
}

-(IBAction)smsBtn:(id)sender{

    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    [shareParams SSDKSetupShareParamsByText:@"秀才不出门，便知天下事"
                                     images:[UIImage imageNamed:@"zj1024x1024"] //传入要分享的图片
                                        url:[NSURL URLWithString:_url  ]
                                      title:@"66"
                                       type:SSDKContentTypeAuto];

    //进行分享
    [ShareSDK share:SSDKPlatformTypeSMS //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         NSLog(@"%@",error.userInfo);
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:[NSString stringWithFormat:@"%@",error.userInfo[@"error_message"]]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }

     }];
}


-(void)requestShare{
//    NSMutableDictionary *shareDic = [[NSMutableDictionary alloc]init];
//    [shareDic setObject:@"qr_ios" forKey:@"type"];
//    HttpRequestModel *request = [[HttpRequestModel alloc]init];
//    [request GetLoginOfUserWithUrl:shareDic strUrl:shareUrl FinishBlock:^(NSDictionary *dic) {
//        NSString *code = dic[NET_KEY_ERRORCODE];
//        if ([code integerValue] == 0) {
//            [_QRcodeImg sd_setImageWithURL:[NSURL URLWithString:dic[NET_KEY_DATA][@"img_url"]]];
//            _url = dic[NET_KEY_DATA][@"url"];
//        }
//    } ErrorBlock:^(NSError *error) {
//
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
