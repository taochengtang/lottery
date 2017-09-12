//
//  ChangPassViewController.m
//  NewsComing
//
//  Created by 陶成堂 on 2017/8/24.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "ChangPassViewController.h"

@interface ChangPassViewController ()
@property (strong, nonatomic) UITextField *usernameTF;
@property (strong, nonatomic) UITextField *passwdTF;
@property (strong, nonatomic) UIButton *registerBtn;
@end

@implementation ChangPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [BarItem addBackItemToVC:self];
    self.view.backgroundColor = kRGBColor(236, 236, 236);
    
    [self usernameTF];
    [self passwdTF];
    [self registerBtn];
}


#pragma mark - 懒加载
- (UITextField *)usernameTF {
    if(_usernameTF == nil) {
        _usernameTF = [[UITextField alloc] init];
        _usernameTF.borderStyle = UITextBorderStyleRoundedRect;
        _usernameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTF.backgroundColor = [UIColor whiteColor];
        _usernameTF.placeholder = @"    请输入您的用户名";
        [self.view addSubview:_usernameTF];
        [_usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _usernameTF;
}

- (UITextField *)passwdTF {
    if(_passwdTF == nil) {
        _passwdTF = [[UITextField alloc] init];
        _passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        _passwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwdTF.secureTextEntry = YES;
        _passwdTF.placeholder = @"    请输入您的新密码";
        _passwdTF.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_passwdTF];
        [_passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.usernameTF.mas_bottom).mas_equalTo(2);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
    }
    return _passwdTF;
}

- (UIButton *)registerBtn {
    if(_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn.layer setMasksToBounds:YES];
        [_registerBtn.layer setCornerRadius:5];
        [_registerBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:kRGBColor(137, 37, 44)];
        [self.view addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        [_registerBtn bk_addEventHandler:^(id sender) {
            if ([self.usernameTF.text isEqualToString:@""] && [self.passwdTF.text isEqualToString:@""]) {
                [self showSuccessWithMsg:@"请输入用户名和密码"];
            }else if ([self.passwdTF.text isEqualToString:@""]) {
                [self showSuccessWithMsg:@"请输入新密码"];
            }else if ([self.usernameTF.text isEqualToString:@""]) {
                [self showSuccessWithMsg:@"请输入用户名"];
            }else{
            
            // 快速显示一个提示信息
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.removeFromSuperViewOnHide = YES;
            hud.labelText = @"修改密码成功";
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [hud hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
            });
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _registerBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
