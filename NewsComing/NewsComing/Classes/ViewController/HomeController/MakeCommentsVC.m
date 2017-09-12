//
//  MakeCommentsVC.m
//  NewsComing
//
//  Created by 陶成堂 on 2017/9/4.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "MakeCommentsVC.h"

@interface MakeCommentsVC ()<UITextViewDelegate>

@property (nonatomic,strong)IBOutlet UILabel *commentLab;
@property (nonatomic,strong)IBOutlet UITextView *commentView;
@property (nonatomic,strong)IBOutlet UIButton *sureBtn;
@property (nonatomic,strong)IBOutlet UILabel *numLab;
@property (nonatomic,strong)NSString *commentStr;

@end

@implementation MakeCommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表评论";
    [BarItem addBackItemToVC:self];

    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 5.0;
    
    [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _commentView.delegate = self;
}


-(void)sureClick{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    if (_commentStr.length == 0) {
    hud.labelText = @"发表内容不能为空";
    }else{
    hud.labelText = @"正在提交";
    }
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
        [self.navigationController popViewControllerAnimated:YES];
    });

}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length != 0) {
       _commentLab.hidden = YES;
        if (textView.text.length <= 300) {
            _commentStr = _commentView.text;
        }
        _commentView.text = _commentStr;
    }else{
        _commentLab.hidden = NO;
    }
    _numLab.text = [NSString stringWithFormat:@"%ld/300",_commentView.text.length];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
