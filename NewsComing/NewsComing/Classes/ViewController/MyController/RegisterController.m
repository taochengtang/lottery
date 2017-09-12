//
//  RegisterController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "RegisterController.h"
#import "MyController.h"
#import "PersonViewController.h"

@interface RegisterController ()

@property (strong, nonatomic) UITextField *usernameTF;
@property (strong, nonatomic) UITextField *passwdTF;
@property (strong, nonatomic) UIButton *registerBtn;
@property (strong, nonatomic) UIButton *personMent;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [BarItem addBackItemToVC:self];
    self.view.backgroundColor = kRGBColor(236, 236, 236);
    
    [self usernameTF];
    [self passwdTF];
    [self registerBtn];
    [self personMent];
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

- (UIButton *)registerBtn {
    if(_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn.layer setMasksToBounds:YES];
        [_registerBtn.layer setCornerRadius:5];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:kRGBColor(137, 37, 44)];
        [self.view addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
        }];
        [_registerBtn bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
    
    
    }
    return _registerBtn;
}


-(UIButton *)personMent{
    if (_personMent == nil) {
        _personMent = [UIButton buttonWithType:UIButtonTypeCustom];
        [_personMent.layer setMasksToBounds:YES];
        [_personMent.layer setCornerRadius:5];
        [_personMent setTitle:@"用户协议" forState:UIControlStateNormal];
        _personMent.titleLabel.font = [UIFont systemFontOfSize:13.0];
        _personMent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_personMent setTitleColor:kRGBColor(137, 37, 44) forState:UIControlStateNormal ];
        [self.view addSubview:_personMent];
        [_personMent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.registerBtn.mas_bottom).mas_equalTo(20);
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


@end
