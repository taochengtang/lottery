//
//  HomeListController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "HomeListController.h"
#import "HomeCell.h"
#import "HomeViewModel.h"
#import "HomeDetailController.h"
#import "iCarousel.h"

@interface HomeListController () <UITableViewDataSource, UITableViewDelegate, iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) HomeViewModel *homeVM;
@property (nonatomic,strong)UIView *bgView;
@property (assign,nonatomic) NSInteger index;

@end

@implementation HomeListController
{
    iCarousel *_ic;
    NSTimer *_timer;
    UIPageControl *_pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self messageData];
    [self.tableView.mj_header beginRefreshing];
}

- (UIView *)configHeadView {
    [_timer invalidate];
    if (!self.homeVM.hasHeadImg) {
        return nil;
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kWindowW*375/750)];
    
    _ic = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _ic.dataSource = self;
    _ic.delegate = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = 6;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.userInteractionEnabled = NO;
    [headView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(1);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(0);
    }];
    
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
        [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
    } repeats:YES];
    
    return headView;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    if ([type integerValue] == 2) {
        return _dataArray.count;
    }
    return self.homeVM.rowNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    if ([type integerValue] == 2) {
        NSDictionary *dic = _dataArray[indexPath.row];
        cell.titleLB.text = dic[@"title"];
        cell.dateLB.text = dic[@"time"];
        cell.commentNumLB.text = [NSString stringWithFormat:@"%@评论",dic[@"comment"]];
        cell.iconIV.imgView.image = [UIImage imageNamed:dic[@"image"]];

    }else{
        if([self.homeVM mediaTypeForRow:indexPath.row] == 6) {
            cell.iconIV.imgView.image = [UIImage imageNamed:@"car"];
        }else {
            [cell.iconIV.imgView setImageWithURL:[self.homeVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        }
    NSString *title =  [self.homeVM reportNumForRow:indexPath.row];
    [cell.Report setTitle:@"举报" forState:UIControlStateNormal];
    cell.Report.tag = indexPath.row;
    cell.titleLB.text = [self.homeVM titleForRow:indexPath.row];
    cell.dateLB.text = [self.homeVM dateForRow:indexPath.row];
    cell.commentNumLB.text = [self.homeVM commentNumForRow:indexPath.row];
        
        [cell.Report bk_addEventHandler:^(id sender) {
            [self creatShareView];
            _index = cell.Report.tag;
            [cell.Report setTitle:@"已举报" forState:UIControlStateNormal];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    if ([type integerValue] ==2) {
        NSDictionary *dic = _dataArray[indexPath.row];
        HomeDetailController *vc = [[HomeDetailController alloc]init];
        vc.url = dic[@"url"];
        vc.comment = dic[@"comment"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    HomeDetailController *vc = [[HomeDetailController alloc] initWithID:[self.homeVM IDForRow:indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - <iCarouselDataSource>
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.homeVM.headImgURLs.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW*375/750)];
        UIImageView *imgView = [UIImageView new];
        imgView.tag = 100;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [view addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imgView = (UIImageView *)[view viewWithTag:100];
    [imgView setImageWithURL:self.homeVM.headImgURLs[index] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    
    return view;
}

#pragma mark - <iCarouselDelegate>
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    //循环滚动
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    _pageControl.currentPage = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    HomeDetailController *vc = [[HomeDetailController alloc] initWithID:[self.homeVM IDForRow:index]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (HomeViewModel *)homeVM {
    if(_homeVM == nil) {
        _homeVM = [[HomeViewModel alloc] initWithType:self.infoType.integerValue];
    }
    return _homeVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.homeVM refreshDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    _tableView.tableHeaderView = [self configHeadView];
                    [_tableView reloadData];
                }
                [_tableView.mj_header endRefreshing];
            }];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
            [self.homeVM getMoreDataCompletionHandler:^(NSError *error) {
                if (!error) {
                    [_tableView reloadData];
                }
                [_tableView.mj_footer endRefreshing];
            }];
        }];
        
    }
    return _tableView;
}



-(void)messageData{
    NSDictionary *dic1 = @{@"time":@"2017-07-17",@"image":@"01.jpg",@"title":@"这对夫妇买彩票中了22亿 把日子过成了这样-图",@"url":@"http://taochengtang.legendh5.com/h5/91ec5b7e-6319-f519-243d-b8fbad59e82d.html",@"comment":@"90"};
    NSDictionary *dic2 = @{@"time":@"2017-07-19 08:07:24",@"image":@"02.jpg",@"title":@"关于停止销售2012年（含）前印制的各批次彩票的公告",@"url":@"http://taochengtang.baiduux.com/h5/01624204-3654-a518-b482-2bb2c94447bb.html",@"comment":@"234"};
    NSDictionary *dic3 = @{@"time":@"2017-07-17",@"image":@"03.jpg",@"title":@"男子100元买彩票中6977万:最后一分钟出单-票",@"url":@"http://taochengtang.baiduux.com/h5/55f96e71-6c17-c6c1-a1ae-256b4a9a2bb4.html",@"comment":@"369"};
    NSDictionary *dic4 = @{@"time":@"2017-07-17",@"image":@"04.jpg",@"title":@"中国体育彩票添彩2017“多彩贵州”自行车联赛（安顺开发区站）",@"url":@"http://taochengtang.baiduux.com/h5/2e108b01-0b0a-1479-3e47-4d7465cb0cd9.html",@"comment":@"18"};
    NSDictionary *dic5 = @{@"time":@"2017-07-17",@"image":@"05.jpg",@"title":@"4500万得主露脸接受采访:曾一度因彩票想跳楼",@"url":@"http://taochengtang.baiduux.com/h5/c8471f2a-4ad5-d60a-579f-1cab1ca5cc7d.html",@"comment":@"160"};
    NSDictionary *dic6 = @{@"time":@"2017-07-17",@"image":@"06.jpg",@"title":@"大乐透1注1000万头奖花落徐汇 中奖彩票为单式票",@"url":@""};
    NSDictionary *dic7 = @{@"time":@"2017-07-16",@"image":@"07.jpg",@"title":@"2017体彩上半年：“投注+中奖”成玩家常态",@"url":@"http://taochengtang.baiduux.com/h5/96999223-4e91-9ffb-f829-b0aed6fdd57a.html",@"comment":@"223"};
    NSDictionary *dic8 = @{@"time":@"2017-07-16",@"image":@"08.jpg",@"title":@"“体彩迎全运 彩民大回馈”系列活动启动",@"url":@"http://taochengtang.baiduux.com/h5/3752ab62-f505-10ab-1d0c-12ee5b4d4fe9.html",@"comment":@"596"};
    NSDictionary *dic9 = @{@"time":@"2017-07-16",@"image":@"09.jpg",@"title":@"惠州男子下楼取外卖 零钱顺手买彩票中奖百万",@"url":@"http://taochengtang.baiduux.com/h5/4a8e379a-a529-3496-74dc-0cee78bdbdc5.html",@"comment":@"129"};
    NSDictionary *dic10 = @{@"time":@"2017-07-16",@"image":@"10.jpg",@"title":@"老年人福利支出占东莞市2016年福利彩票公益金44.30%",@"url":@"http://taochengtang.baiduux.com/h5/74f609e7-9494-0fe2-d004-f9df21213f7a.html",@"comment":@"683"};
    NSDictionary *dic11 = @{@"time":@"2017-07-16",@"image":@"11.jpg",@"title":@"16日竞彩赔率解读:千叶市原安全系数高",@"url":@"http://taochengtang.baiduux.com/h5/3a623053-f8cc-04ee-c92b-70b3e7a8adf8.html",@"comment":@"442"};
    NSDictionary *dic12 = @{@"time":@"2017-07-16",@"image":@"12.jpg",@"title":@"买彩票输光钱 他竟跑到高档别墅偷东西",@"url":@"http://taochengtang.baiduux.com/h5/b4f29d69-62c8-305a-52d2-2eca006976d8.html",@"comment":@"457"};
    NSDictionary *dic13 = @{@"time":@"2017-07-15",@"image":@"13.jpg",@"title":@"用奖金换彩票结果幸运延续 刮出25万被围观",@"url":@"http://taochengtang.baiduux.com/h5/19312335-0e14-b693-17b5-89cddb6b2d47.html",@"comment":@"865"};
    NSDictionary *dic14 = @{@"time":@"2017-07-16",@"image":@"14.jpg",@"title":@"早晨醒来核对彩票发现中1000万 疑惑仍在梦中",@"url":@"http://taochengtang.baiduux.com/h5/9e903f3e-3989-6a59-47a7-ac5459eb18ef.html",@"comment":@"123"};
    NSDictionary *dic15 = @{@"time":@"2017-07-16",@"image":@"15.jpg",@"title":@"工薪小伙今年只买1次彩票 112元投注中1001万",@"url":@"http://taochengtang.baiduux.com/h5/2f21d507-3b31-910c-6717-748ed31afa9c.html",@"comment":@"2331"};
    NSDictionary *dic16 = @{@"time":@"2017-07-15",@"image":@"16.jpg",@"title":@"天津启动“体彩迎全运 彩民大回馈”系列活动",@"url":@"http://taochengtang.baiduux.com/h5/9bcb8529-4081-c4ed-f527-24dbc71f916f.html",@"comment":@"23"};
    
    //加载
    //page=2
    NSDictionary *dic17 = @{@"time":@"2017-07-04",@"image":@"17.jpg",@"title":@"幸运中奖1000万 得主因何事竟再也不说话",@"url":@"http://cai.163.com/article/17/0704/10/COGAIIR100052DT2.html",@"comment":@"23"};
    NSDictionary *dic18 = @{@"time":@"2017-07-05 07:47:34",@"image":@"18.jpg",@"title":@"女承母业 买彩票 抱走双色球头奖709万",@"url":@"http://cai.163.com/article/17/0705/07/COIKDCO400052DT2.html"};
    NSDictionary *dic19 = @{@"time":@"2016年12月23日 10:04:41",@"image":@"19.jpg",@"title":@"神人”四年三次领大奖，争取来个“大满贯",@"url":@"http://news.xinhuanet.com/caipiao/2016-12/23/c_1120173371.htm"};
    NSDictionary *dic20 = @{@"time":@"2017年07月08日14:56",@"image":@"20.jpg",@"title":@"33人合买团擒双色球741万 众人自制条幅露脸兑奖",@"url":@"http://sports.sina.com.cn/l/2017-07-08/doc-ifyhwehx5373521.shtml"};
    NSDictionary *dic21 = @{@"time":@"2017-07-04 09:48:56",@"image":@"21.jpg",@"title":@"份子钱送彩票已过时 彩票其实还能这样玩！",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/04/c_1121259645.htm"};
    NSDictionary *dic22 = @{@"time":@"2017-07-04 10:03:16",@"image":@"22.jpg",@"title":@"女彩民4元击中636万 用三天时间平复心情",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/04/c_1121259833.htm"};
    NSDictionary *dic23 = @{@"time":@"2017-07-04 09:14:44",@"image":@"23.jpg",@"title":@"无锡女彩民用丈夫半包烟钱 揽大乐透110万",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/04/c_1121259144.htm"};
    NSDictionary *dic24 = @{@"time":@"2017-07-04 07:58:49",@"image":@"24.jpg",@"title":@"彩民一人独中325注双色球 奖金超733万!",@"url":@"http://cai.163.com/article/17/0704/07/COG2L91200052DT2.html"};
    NSDictionary *dic25 = @{@"time":@"2017-07-04 04:13",@"image":@"25.jpg",@"title":@"图文：7.2亿奖池在为亿元巨奖憋大招吗",@"url":@"http://www.sohu.com/a/154204424_117836"};
    NSDictionary *dic26 = @{@"time":@"2017-07-06 10:15",@"image":@"26.jpg",@"title":@"重庆彩民擒获大乐透3200万元头奖",@"url":@"http://henan.china.com.cn/latest/2017/0706/5155927.shtml"};
    NSDictionary *dic27 = @{@"time":@"2017-07-03 08:35:42",@"image":@"27.jpg",@"title":@"徐州表兄弟合买彩票中双色球头奖571万多元",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/03/c_1121251021.htm"};
    
    
    //page=3
    NSDictionary *dic28 = @{@"time":@"2017-07-03 08:54:54",@"image":@"28.jpg",@"title":@"业余彩民机选彩票中619万头奖 买彩只为做公益",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/03/c_1121251404.htm"};
    NSDictionary *dic29 = @{@"time":@"2017年07月03日15:43",@"image":@"29.jpg",@"title":@"好险！小伙将彩票压在枕头下足足34天，679万大奖险成弃奖",@"url":@"http://sports.sina.com.cn/l/2017-07-03/doc-ifyhrxsk1633380.shtml"};
    NSDictionary *dic30 = @{@"time":@"2017-07-03 10:05:50",@"image":@"30.jpg",@"title":@"千元复式票 福建彩民拿下14场胜负彩182万",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/03/c_1121252927.htm"};
    NSDictionary *dic31 = @{@"time":@"2017-07-03 11:23:03",@"image":@"31.jpg",@"title":@"玩彩夫妻档 14元小复式收获15万元奖金",@"url":@"http://www.zhcw.com/xinwen/caimingushi/ssq/11863706.shtml"};
    NSDictionary *dic32 = @{@"time":@"2017-07-04 08:01:40",@"image":@"32.jpg",@"title":@"深度分析即开票销量连年不景气 原因究竟是什么",@"url":@"http://cai.163.com/article/17/0704/08/COG2QG6900052DT2.html"};
    NSDictionary *dic33 = @{@"time":@"2017-07-03 07:52:35",@"image":@"33.jpg",@"title":@"彩民15元追加票中1600万 首注号码即中头奖",@"url":@"http://cai.163.com/article/17/0703/07/CODFT4HT00052DT2.html"};
    NSDictionary *dic34 = @{@"time":@"2017-07-31 09:30:09",@"image":@"34.jpg",@"title":@"一周彩票星座:射手座可以考虑合买 金牛座有财运",@"url":@"http://cai.163.com/article/17/0731/09/CQLOJT7B00052DT2.html"};
    NSDictionary *dic35 = @{@"time":@"2017-07-03 11:13:11",@"image":@"35.jpg",@"title":@"生意人围观彩站庆祝733万 销售员暗示其就是得主",@"url":@"http://cai.163.com/article/17/0703/11/CODRCERR00052DT2.html"};
    NSDictionary *dic36 = @{@"time":@"2017-07-02 10:52:59",@"image":@"36.jpg",@"title":@"400倍投注“豹子号” 彩民中“快3”9.6万大奖",@"url":@"http://news.xinhuanet.com/caipiao/2017-07/02/c_1121249042.htm"};
    NSDictionary *dic37 = @{@"time":@"2017-07-03 07:42:28",@"image":@"37.jpg",@"title":@"彩民中450倍福彩3D奖金超46万 自称中奖近百万",@"url":@"http://cai.163.com/article/17/0703/07/CODFAJKF00052DT2.html"};
    
    //page=4
    NSDictionary *dic38 = @{@"time":@"2017-07-03 07:47:00",@"image":@"38.jpg",@"title":@"1000万中奖彩票险被拿去换酒 得主还曾痴迷赌博",@"url":@"http://cai.163.com/article/17/0703/07/CODFITMQ00052DT2.html"};
    NSDictionary *dic39 = @{@"time":@"2017-07-01 05:38:03",@"image":@"39.jpg",@"title":@"民政部彩票公益金去年使用超25亿元",@"url":@"http://news.163.com/17/0701/05/CO83DS3J00018AOP.html"};
    NSDictionary *dic40 = @{@"time":@"2017-07-03 07:56:48",@"image":@"40.jpg",@"title":@"一周内连续中得54万+112万足彩头奖 神人眼光毒",@"url":@"http://cai.163.com/article/17/0703/07/CODG4RJ600052DT2.html"};
    NSDictionary *dic41 = @{@"time":@"2015年07月22日13:48",@"image":@"41.jpg",@"title":@"概率2.6万亿分之一：男子中头彩 和女儿都曾被雷劈",@"url":@"http://world.people.com.cn/n/2015/0722/c1002-27344258.html"};
    
    NSDictionary *dic42 = @{@"time":@"2017-07-02 10:45:21",@"image":@"42.jpg",@"title":@"保定荣大突然退出中甲!昨晚这场比赛真是假球吗?",@"url":@"http://cai.163.com/article/17/0702/10/COB7COSK00052DT2.html"};
    
    NSDictionary *dic43 = @{@"time":@"2017-07-02 09:36",@"image":@"43.jpg",@"title":@"比分串关连中!小伙99倍投注仅花1584元即中77万",@"url":@"http://www.china-lottery.net/news/335773.html"};
    
    NSDictionary *dic44 = @{@"time":@"2017-07-02 07:38",@"image":@"44.jpg",@"title":@"大乐透075期开奖:头奖3注1600万 奖池37.98亿",@"url":@"http://sports.qq.com/a/20170702/019832.htm"};
    
    NSDictionary *dic45 = @{@"time":@"2017-05-14 17:19:14",@"image":@"45.jpg",@"title":@"买彩票屡次不中奖 西安男子偷彩票店老板手机变卖",@"url":@"http://news.hsw.cn/system/2017/0514/755533.shtml"};
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12,dic13,dic14,dic15,dic16,dic17, nil];
    
    for (int i = 0; i<_dataArray.count; i++) {
        NSDictionary *dic = _dataArray[i];
        [_imageArray addObject:dic[@"image"]];
    }
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
        NSLog(@"%ld",_index);
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
