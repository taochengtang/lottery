//
//  WordController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordController.h"
#import "WordViewModel.h"
#import "PicController.h"
#import "WordCell.h"
#import "WordDetailController.h"

@interface WordController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UISegmentedControl *sc;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) WordViewModel *wordVM;
@property (nonatomic,strong)UIView *bgView;

@end

@implementation WordController

+ (UINavigationController *)defaultWordNavi {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WordController *vc = [WordController new];
        navi = [[UINavigationController alloc] initWithRootViewController:vc];
    });
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sc];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wordVM.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.contentLB.text = [self.wordVM contentForRow:indexPath.row];
    NSString *title = [self.wordVM zanNumForRow:indexPath.row];
    [cell.zanBtn setTitle:title forState:UIControlStateNormal];
    [cell.zanBtn bk_addEventHandler:^(id sender) {
        [cell.zanBtn setTitle:[NSString stringWithFormat:@"%ld",(title.integerValue+1)] forState:UIControlStateNormal];
        [self showSuccessWithMsg:@"点赞成功"];
    } forControlEvents:UIControlEventTouchUpInside];
    cell.dateLB.text = [self.wordVM dateForRow:indexPath.row];
    
    [cell.reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    [cell.reportBtn bk_addEventHandler:^(id sender) {
        [self creatShareView];
        [cell.reportBtn setTitle:@"已举报" forState:UIControlStateNormal];
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WordDetailController *vc = [[WordDetailController alloc] initWithContent:[self.wordVM contentForRow:indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (WordViewModel *)wordVM {
    if(_wordVM == nil) {
        _wordVM = [[WordViewModel alloc] init];
    }
    return _wordVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[WordCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.wordVM refreshDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_header endRefreshing];
            }];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self.wordVM getMoreDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_footer endRefreshing];
            }];
        }];
    }
    return _tableView;
}

- (UISegmentedControl *)sc {
    if(_sc == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@"段子",@"图片", nil];
        _sc = [[UISegmentedControl alloc] initWithItems:arr];
        _sc.frame = CGRectMake(0, 0, 150, 30);
        _sc.selectedSegmentIndex = 0;
        _sc.tintColor = [UIColor whiteColor];
        [_sc bk_addEventHandler:^(id sender) {
            NSMutableArray *naviVCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [naviVCs removeLastObject];
            PicController *vc = [PicController new];
            [naviVCs addObject:vc];
            self.navigationController.viewControllers = naviVCs;
        } forControlEvents:UIControlEventValueChanged];
        [self.navigationItem setTitleView:_sc];
    }
    return _sc;
}



-(void)creatShareView{
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, BJScreenHeight, BJScreenWidth, 0)];
    _bgView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(BJScreenWidth - 60, 60, 40, 40)];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:closeBtn];
    
    UIView *viewB = [[UIView alloc]initWithFrame:CGRectMake(0, BJScreenHeight - 360, BJScreenWidth, 360)];
    viewB.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:viewB];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, BJScreenWidth, 20)];
    titleLab.text = @"举报内容问题";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [viewB addSubview:titleLab];
    
    NSArray *titleArr = @[@"广告",@"重复，旧闻",@"低俗色情",@"违法犯罪",@"标题夸张",@"与事实不符",@"内容质量差",@"疑似抄袭"];
    
    for (int i = 0; i < 8; i++) {
        UIButton *reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 40 + 40 * i, BJScreenWidth - 40, 40)];
        [reportBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [reportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        reportBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [reportBtn addTarget:self action:@selector(clickReport) forControlEvents:UIControlEventTouchUpInside];
        [viewB addSubview:reportBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, BJScreenWidth-40, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [reportBtn addSubview:lineView];
        
    }
    
    AppDelegate *app = (UIApplication *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:_bgView];
    
    [UIView animateWithDuration:.5 animations:^{
        _bgView.frame = CGRectMake(0, 0, BJScreenWidth, BJScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    
}


-(void)clickReport{
    [UIView animateWithDuration:.5 animations:^{
        _bgView.frame = CGRectMake(0, BJScreenHeight, BJScreenWidth, 0);
    } completion:^(BOOL finished) {
        [self showSuccessWithMsg:@"举报成功"];
        [_bgView removeFromSuperview];
    }];
}


-(void)closeClick{
    [UIView animateWithDuration:.5 animations:^{
        _bgView.frame = CGRectMake(0, BJScreenHeight, BJScreenWidth, 0);
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
    }];
    
    
}


@end
