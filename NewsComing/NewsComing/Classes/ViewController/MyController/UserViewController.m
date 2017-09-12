//
//  UserViewController.m
//  JWCP
//
//  Created by 陶成堂 on 2017/7/18.
//  Copyright © 2017年 zuqiu. All rights reserved.
//

#import "UserViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface UserViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *buttomView;
@property (nonatomic,strong)UIView *alphaView;
@property (nonatomic,strong)UITextField *nickField;
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)UILabel *changLab;
@property (nonatomic,strong)UIButton *outLoginBtn;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [BarItem addBackItemToVC:self];

    self.title = @"我的信息";
    [self creatUI];

}


-(void)creatUI{
    UIView *btmView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BJScreenWidth, 110)];
    btmView.backgroundColor = kColorWhite;
    [self.view addSubview:btmView];
    
    UILabel *headLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 40, 20)];
    headLab.text = @"头像";
    headLab.font = kBuyLabel;
    [btmView addSubview:headLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 70, BJScreenWidth - 35, 1)];
    lineView.backgroundColor = TESTCOLOR(220, 220, 220);
    [btmView addSubview:lineView];
    
    UILabel *nickLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 85, 40, 15)];
    nickLab.text = @"昵称";
    nickLab.font = kBuyLabel;
    [btmView addSubview:nickLab];
    
    UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(BJScreenWidth - 65, 10, 50, 50)];
    [headBtn setImage:[UIImage imageNamed:userInfoDic[@"head"]] forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(addHeadImg) forControlEvents:UIControlEventTouchUpInside];
    headBtn.tag = 40;
    headBtn.layer.masksToBounds = YES;
    headBtn.layer.cornerRadius = 25.0;
    [btmView addSubview:headBtn];
    
    UIButton *nickBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, 85, BJScreenWidth - 100, 15)];
    [nickBtn setTitle:userInfoDic[@"name"] forState:UIControlStateNormal];
    [nickBtn addTarget:self action:@selector(nickNameClick) forControlEvents:UIControlEventTouchUpInside];
    nickBtn.tag = 41;
    nickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [nickBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
    nickBtn.titleLabel.font = kBuyLabel;
    [btmView addSubview:nickBtn];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(20, 109, BJScreenWidth - 35, 1)];
    lineView1.backgroundColor = TESTCOLOR(220, 220, 220);
    [btmView addSubview:lineView1];
    
    
    _outLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30,BJScreenHeight - 150, BJScreenWidth - 60, 45)];
    _outLoginBtn.backgroundColor = TESTCOLOR(138, 29, 45);
    [_outLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_outLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _outLoginBtn.layer.masksToBounds = YES;
    _outLoginBtn.layer.cornerRadius = 5.0;
    [_outLoginBtn addTarget:self action:@selector(outLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_outLoginBtn];
}


//昵称
-(void)nickNameClick{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BJScreenWidth, BJScreenHeight)];
    _bgView.backgroundColor = kColorClear;
    
    
    _alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BJScreenWidth, BJScreenHeight)];
    _alphaView.backgroundColor = TESTCOLOR(195, 195, 195);
    _alphaView.alpha = 0.5;
    [_bgView addSubview:_alphaView];
    
    
    _buttomView = [[UIView alloc]initWithFrame:CGRectMake(BJScreenWidth/2, BJScreenHeight/2-70,0, 140)];
    _buttomView.backgroundColor = kColorWhite;
    _buttomView.layer.masksToBounds = YES;
    _buttomView.layer.cornerRadius = 5.0;
    [_bgView addSubview:_buttomView];
    
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(BJScreenWidth - 70, 5, 20, 20)];
    [_closeBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
        [_closeBtn setTitle:@"X" forState:UIControlStateNormal];
//    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _nickField = [[UITextField alloc]initWithFrame:CGRectMake(BJScreenWidth/2,(_buttomView.frame.size.height - 30)/2 ,0, 30)];
    _nickField.borderStyle = UITextBorderStyleRoundedRect;
    _nickField.backgroundColor = TESTCOLOR(220, 220, 220);
    _nickField.textAlignment = NSTextAlignmentCenter;
    _nickField.placeholder = @"昵称";
    
    [_buttomView addSubview:_nickField];
    
    _changLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10,0, 20)];
    _changLab.text = @"更改昵称";
    _changLab.textColor = kColorBlack;
    _changLab.font = kSendSheepLabel;
    [_buttomView addSubview:_changLab];
    
    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(BJScreenWidth/2, _buttomView.frame.size.height - 40, 0, 25)];
    _sureBtn.backgroundColor = TESTCOLOR(49, 144, 232);
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 5.0;
    _sureBtn.titleLabel.font = kBuyLabel;
    [_sureBtn setTitle:@"确定修改" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureChangClick) forControlEvents:UIControlEventTouchUpInside];
    [_buttomView addSubview:_sureBtn];
    
    
    AppDelegate *app = (UIApplication *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:_bgView];
    
    [UIView animateWithDuration:.5 animations:^{
        _buttomView.frame = CGRectMake(20, BJScreenHeight/2-70, BJScreenWidth - 40, 140);
    } completion:^(BOOL finished) {
        [_buttomView addSubview:_closeBtn];
        [UIView animateWithDuration:0.5 animations:^{
            _nickField.frame = CGRectMake(30, (_buttomView.frame.size.height - 30)/2, _buttomView.frame.size.width - 60, 30);
            _changLab.frame = CGRectMake(20, 10, 70, 20);
            _sureBtn.frame = CGRectMake(_buttomView.frame.size.width/2 - 50, _buttomView.frame.size.height - 40, 100, 25);
        }];
    }];
}

//添加图片
-(void)addHeadImg{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    [action showInView:self.view];
}

//关闭
-(void)closeViewClick{
    [UIView animateWithDuration:0.4 animations:^{
        _nickField.frame = CGRectMake(BJScreenWidth/2,(_buttomView.frame.size.height - 30)/2 ,0, 30);
        _closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
        _closeBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _changLab.frame = CGRectMake(20, 10, 0, 20);
        _sureBtn.frame = CGRectMake(BJScreenWidth/2, _buttomView.frame.size.height - 40, 0, 25);
    } completion:^(BOOL finished) {
        [_closeBtn removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            _buttomView.frame = CGRectMake(BJScreenWidth/2, BJScreenHeight/2-70,0, 140);
        } completion:^(BOOL finished) {
            [_bgView removeFromSuperview];
        }];
    }];
}



//确认修改
-(void)sureChangClick{
    [UIView animateWithDuration:0.4 animations:^{
        _nickField.frame = CGRectMake(BJScreenWidth/2,(_buttomView.frame.size.height - 30)/2 ,0, 30);
        _closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
        _closeBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _changLab.frame = CGRectMake(20, 10, 0, 20);
        _sureBtn.frame = CGRectMake(BJScreenWidth/2, _buttomView.frame.size.height - 40, 0, 25);
    } completion:^(BOOL finished) {
        [_closeBtn removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            _buttomView.frame = CGRectMake(BJScreenWidth/2, BJScreenHeight/2-70,0, 140);
        } completion:^(BOOL finished) {
            [_bgView removeFromSuperview];
        }];
    }];
    
    UIButton *btn = [self.view viewWithTag:41];
    [btn  setTitle:_nickField.text forState:UIControlStateNormal];
    NSDictionary *userInfo = @{@"name":_nickField.text,
                               @"head":@"头像",
                               @"phone":@"15620633051",
                               @"id":@"1"};
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    if (buttonIndex == 0) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if (buttonIndex == 1) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIButton *headBtn = [self.view viewWithTag:40];
    UIImage *imageH = info[UIImagePickerControllerOriginalImage];
    [headBtn setImage:imageH forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)outLoginClick{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = @"正在退出";
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
        [hud hide:YES];
        [self.navigationController popViewControllerAnimated:YES];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
