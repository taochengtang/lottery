//
//  RegisterLoginController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "RegisterLoginController.h"
#import "RegisterController.h"
#import "MyController.h"
#import "PersonViewController.h"

@interface RegisterLoginController ()

@property (strong, nonatomic) UITextField *passwdTF;

@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIBarButtonItem *registerItem;
@property (strong, nonatomic) UIButton *personMent;

@end

@implementation RegisterLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"个人资料";
    [BarItem addBackItemToVC:self];
    self.view.backgroundColor = kRGBColor(236, 236, 236);
    
    [self usernameTF];
    [self passwdTF];
    [self loginBtn];
    [self personMent];
    self.navigationItem.rightBarButtonItem = self.registerItem;
}

#pragma mark - 懒加载
- (UIButton *)loginBtn {
    if(_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn.layer setMasksToBounds:YES];
        [_loginBtn.layer setCornerRadius:5];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:kRGBColor(137, 37, 44)];
        [self.view addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        [_loginBtn bk_addEventHandler:^(id sender) {
            
                    if ([self.usernameTF.text isEqualToString:@""] && [self.passwdTF.text isEqualToString:@""]) {
                        [self showSuccessWithMsg:@"请输入用户名和密码"];
                    }else if ([self.passwdTF.text isEqualToString:@""]) {
                        [self showSuccessWithMsg:@"请输入密码"];
                    }else if ([self.usernameTF.text isEqualToString:@""]) {
                        [self showSuccessWithMsg:@"请输入用户名"];
                    }else if ([self.usernameTF.text isEqualToString:@"15620633051"] && [self.passwdTF.text isEqualToString:@"123456"]){
                        
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
                        NSDictionary *userDic = @{@"head":@"头像",@"name":@"桃成糖",@"id":@"12",@"phone":@"15620633051"};
                        [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"userInfo"];
                        
                        // 快速显示一个提示信息
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.removeFromSuperViewOnHide = YES;
                        hud.labelText = @"登录成功";
                        double delayInSeconds = 1.0;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [hud hide:YES];
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}



-(UIButton *)personMent{
    if (_personMent == nil) {
        _personMent = [UIButton buttonWithType:UIButtonTypeCustom];
        [_personMent.layer setMasksToBounds:YES];
        [_personMent.layer setCornerRadius:5];
        _personMent.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_personMent setTitle:@"用户协议" forState:UIControlStateNormal];
        [_personMent setTitleColor:kRGBColor(137, 37, 44) forState:UIControlStateNormal ];
        _personMent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.view addSubview:_personMent];
        [_personMent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        [_personMent bk_addEventHandler:^(id sender) {
            PersonViewController *perVC = [[PersonViewController alloc]init];
            [self.navigationController pushViewController:perVC animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _personMent;
}


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
        _passwdTF.placeholder = @"    请输入您的密码";
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

- (UIBarButtonItem *)registerItem {
    if(_registerItem == nil) {
        _registerItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"注册" style:UIBarButtonItemStyleDone handler:^(id sender) {
            RegisterController *vc = [RegisterController new];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        _registerItem.tintColor = [UIColor whiteColor];
    }
    return _registerItem;
}




@end
