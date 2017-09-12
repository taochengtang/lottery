//
//  WordDetailController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordDetailController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface WordDetailController () <AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) UITextView *contentTV;

@property (strong, nonatomic) AVSpeechSynthesizer *speech;
@property (strong, nonatomic) UIBarButtonItem *readItem;
#pragma mark - 
@property (strong, nonatomic) UIButton *shareBtn;

@end

@implementation WordDetailController

- (instancetype)initWithContent:(NSString *)content {
    if (self = [super init]) {
        self.content = content;
        [BarItem addBackItemToVC:self];
        self.title = @"详情";
        self.view.backgroundColor = [UIColor whiteColor];
        self.contentTV.text = self.content;
        self.navigationItem.rightBarButtonItem = self.readItem;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        [self shareBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.speech stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

#pragma mark - <AVSpeechSynthesizerDelegate>
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.readItem.title = @"暂停";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.readItem.title = @"读笑话";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.readItem.title = @"读笑话";
}

#pragma mark - 懒加载
- (UITextView *)contentTV {
	if(_contentTV == nil) {
		_contentTV = [[UITextView alloc] init];
        _contentTV.editable = NO;
        _contentTV.font = kSubtitleFont;
        [self.view addSubview:_contentTV];
        [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-kWindowH/2);
        }];
	}
	return _contentTV;
}

- (AVSpeechSynthesizer *)speech {
    if(_speech == nil) {
        _speech = [[AVSpeechSynthesizer alloc] init];
        _speech.delegate = self;
    }
    return _speech;
}

- (UIBarButtonItem *)readItem {
    if(_readItem == nil) {
        _readItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"读笑话" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if (self.speech.speaking) {
                [self.speech stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return;
            }
            AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:self.content];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
            [self.speech speakUtterance:utt];
        }];
    }
    
    return _readItem;
}

- (UIButton *)shareBtn {
    if(_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.backgroundColor = [UIColor redColor];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateHighlighted];
        [self.view addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentTV.mas_bottom).mas_equalTo(0);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [_shareBtn bk_addEventHandler:^(id sender) {
            NSLog(@"分享");
            //1、创建分享参数
            NSArray* imageArray = @[[UIImage imageNamed:@"152x152.png"]];
//images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
            if (imageArray) {
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:@"秀才不出门，便知天下事"
                                                 images:imageArray
                                                    url:[NSURL URLWithString:@"http://baidu.com"]
                                                  title:@"66"
                                                   type:SSDKContentTypeAuto];
                //有的平台要客户端分享需要加此方法，例如微博
                [shareParams SSDKEnableUseClientShare];
                //2、分享（可以弹出我们的分享菜单和编辑界面）
                [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                         items:nil
                                   shareParams:shareParams
                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                               
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
                                                                                       message:[NSString stringWithFormat:@"%@",error]
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil, nil];
                                       [alert show];
                                       break;
                                   }
                                   default:
                                       break;
                               }
                           }  
                 ];}        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

@end
