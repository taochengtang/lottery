//
//  MyController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "MyController.h"
#import "SetController.h"
#import "RegisterLoginController.h"
#import "UserViewController.h"
#import "InvitationViewController.h"
#import "AboutViewController.h"

@interface MyController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation MyController

- (instancetype)init {
    if (self = [super init]) {
        [self headView];
        [self tableView];
    }
    return self;
}

+ (UINavigationController *)defaultMyNavi {
        MyController *vc = [MyController new];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBColor(244, 244, 244);
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"分享",@"关于",@"设置", nil];
    _imageArray = [[NSMutableArray alloc]initWithObjects:@"persen_share",@"persen_about",@"me_setting", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
   
    UIButton *btn = (UIButton *)[self.view viewWithTag:102];
    if ([isLoginName integerValue] == 1) {
        [btn setBackgroundImage:[UIImage imageNamed:userInfoDic[@"head"]] forState:UIControlStateNormal];
        self.label.text = userInfoDic[@"name"];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"login_portrait_ph"] forState:UIControlStateNormal];
        self.label.text = @"注册/登陆";

    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.font = kTitleFont;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        InvitationViewController *invitationVC = [[InvitationViewController alloc]init];
        invitationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:invitationVC animated:YES];
    }else if (indexPath.row == 1){
        AboutViewController *aboutVC = [[AboutViewController alloc]init];
        aboutVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else{
    SetController *vc = [SetController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 懒加载
- (UIView *)headView {
    if(_headView == nil) {
        _headView = [[UIView alloc] init];
        UIImageView *imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:@"tableViewBackgroundImage"];
        [_headView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        
        UIButton *myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myBtn.tag = 102;
        if ([isLoginName integerValue] ==1) {
            [myBtn setBackgroundImage:[UIImage imageNamed:userInfoDic[@"head"]] forState:UIControlStateNormal];
        }else{
           [myBtn setBackgroundImage:[UIImage imageNamed:@"login_portrait_ph"] forState:UIControlStateNormal];
        }
        [_headView addSubview:myBtn];
        [myBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(65, 65));
        }];
        [myBtn bk_addEventHandler:^(id sender) {
                if ([isLoginName integerValue] == 1) {
                    UserViewController *userVC = [[UserViewController alloc]init];
                    userVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:userVC animated:YES];
                }else{
                RegisterLoginController *vc = [RegisterLoginController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                }
        } forControlEvents:UIControlEventTouchUpInside];
        
        self.label = [UILabel new];
        if ([isLoginName integerValue] == 1) {
        self.label.text = userInfoDic[@"name"];
        }else{
        self.label.text = @"注册/登陆";
        }
        self.label.font = kSubtitleFont;
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(myBtn);
            make.width.mas_equalTo(65);
            make.top.mas_equalTo(myBtn.mas_bottom).mas_equalTo(5);
        }];
        
        [self.view addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(kWindowH/3);
        }];
    }
    return _headView;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.top.mas_equalTo(self.headView.mas_bottom).mas_equalTo(0);
        }];
    }
    return _tableView;
}

@end
