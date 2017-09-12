//
//  CommentViewController.m
//  NewsComing
//
//  Created by 陶成堂 on 2017/9/4.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "MakeCommentsVC.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [BarItem addBackItemToVC:self];

    [self requestData];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BJScreenWidth, BJScreenHeight - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItemBtn];

}


-(UIBarButtonItem *)rightBarButtonItemBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 20);
    [btn setTitle:@"去评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

-(void)rightClick{
    MakeCommentsVC *makeVC = [[MakeCommentsVC alloc]init];
    [self.navigationController pushViewController:makeVC animated:YES];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [CommentTableViewCell getWithTableView:tableView indexPath:indexPath];
    NSDictionary *dic = _dataArray[indexPath.row];
    cell.headImg.image = [UIImage imageNamed:dic[@"image"]];
    cell.nameLab.text = dic[@"name"];
    cell.timeLab.text = dic[@"time"];
    cell.connetLab.text = dic[@"conent"];
    return cell;
}




-(void)requestData{
    NSLog(@"%@",_orderId);

    
    NSDictionary *dic1 = @{@"conent":@"但行程外自行询问的内容套路较深，要谨慎选择。",@"name":@"M75****53",@"time":@"2017-07-13 01:22",@"image":@"c-1"};
    NSDictionary *dic2 = @{@"conent":@"行程很轻松，住宿非常好，早餐一级棒",@"name":@"118****887",@"time":@"2017-06-22 18:16",@"image":@"c-2"};
    NSDictionary *dic3 = @{@"conent":@"沿途为我们做了详细的介绍。整个行程的品质没有因为人少而打折，值得点赞。行程节奏很舒适，适合休闲游。",@"name":@"",@"time":@"2017-06-05 21:19",@"image":@"c-3"};
    NSDictionary *dic4 = @{@"conent":@"线路安排得很好，几个代表性的景点都到了，住宿的宾馆也都不错，土司家宴气氛很好，总体感觉不错。",@"name":@"*****17139",@"time":@"2017-05-31 14:24",@"image":@"c-4"};
    NSDictionary *dic5 = @{@"conent":@"迟一个月来就更美了。总体行程满意。",@"name":@"3*****4889",@"time":@"2017-05-10 15:22",@"image":@"c-5"};

    
    NSDictionary *dic6 = @{@"conent":@"本次路线相对比较悠闲，适合带老人孩子出来玩，安排的团餐也比较清淡。",@"name":@"E18****82",@"time":@"2016-09-19 17:14",@"image":@"c-6"};
    NSDictionary *dic7 = @{@"conent":@"这次我们游玩景点的时候天气很好 阿鑫人很热情 一路上交会了我们很多知识 还有很多我们不了解的历史让我们见识了很多文化 风俗民情 每天都玩的很充实 期待下一次",@"name":@"******9315",@"time":@"2017-09-03 21:15",@"image":@"c-7"};
    NSDictionary *dic8 = @{@"conent":@"非常棒！认真负责，度过了愉快的五天云南之旅。导游讲解很有趣",@"name":@"23****4337",@"time":@"2017-09-03 16:19",@"image":@"c-8"};
    NSDictionary *dic9 = @{@"conent":@"服务周到，比起这些印象最深的是对云南当地文化的详细介绍，让游客产生了一种进一步了解云南的冲动",@"name":@"23****2077",@"time":@"2017-09-03 15:33",@"image":@"c-9"};
    NSDictionary *dic10 = @{@"conent":@"安排合理，住的还不错，丽江王导不错的，开心",@"name":@"M51****380",@"time":@"2017-09-02 10:12",@"image":@"c-10"};

    
    //GS
    NSDictionary *dic11 = @{@"conent":@"说句老实话，选装的话，给一些车主确实带来利处：不喜欢的，可以不要；喜欢的，可以加进去。",@"name":@"地瓜1735",@"time":@"2017-09-01 11:12",@"image":@"c-11"};
    NSDictionary *dic12 = @{@"conent":@"我关心的是全景天窗能开吗",@"name":@"夜未央104264596",@"time":@"2017-09-4 09:12",@"image":@"c-12"};
    NSDictionary *dic13 = @{@"conent":@"一直就觉得橙色好看。",@"name":@"勤而行之匿",@"time":@"2017-09-03 09:33",@"image":@"c-13"};
    NSDictionary *dic14 = @{@"conent":@"如果上1.4T就买一辆，还是1.3T就算了",@"name":@"72000转干他",@"time":@"2017-09-04 11:49",@"image":@"c-14"};
    NSDictionary *dic15 = @{@"conent":@"G-netlink，这个系统好用。",@"name":@"问雪莽",@"time":@"2017-09-04 10:42",@"image":@"c-15"};
    
    //大众
    NSDictionary *dic16 = @{@"conent":@"质检球不顶，这么的问题存在这么多年，谁负责?",@"name":@"岁月如歌1578600",@"time":@"2017-09-04 10:12",@"image":@"c-16"};
    NSDictionary *dic17 = @{@"conent":@"速腾，让你速疼",@"name":@"你安好便是雨天",@"time":@"2017-09-02 10:12",@"image":@"c-17"};
    NSDictionary *dic18 = @{@"conent":@"只有把态度放正了才能赢得消费者的认同，一直靠忽悠迟早把信仰消耗完的",@"name":@"中国愤青与日本右翼有区别吗",@"time":@"2017-08-23 10:12",@"image":@"c-18"};
    NSDictionary *dic19 = @{@"conent":@"大众15年前是懂车的人买，如今是土鳖才买",@"name":@"进击的熊蛋儿",@"time":@"2017-09-01 12:43",@"image":@"c-19"};
    NSDictionary *dic20 = @{@"conent":@"我的车就有这个毛病，迈腾",@"name":@"A刘瑜",@"time":@"2017-09-02 10:12",@"image":@"c-20"};
    
    
    //红色
    NSDictionary *dic21 = @{@"conent":@"此情此景，我想吟诗一首：啊……萧编，萧编湿沙壁，木幽晓寂寂。朔花向房辟，酒汇虾碧碧",@"name":@"剑缈",@"time":@"2017-09-02 10:12",@"image":@"c-21"};
    NSDictionary *dic22 = @{@"conent":@"保险公司对超跑保险的规定是：川藏线除外!",@"name":@"多想世界上只有我一人",@"time":@"2017-09-02 10:12",@"image":@"c-22"};
    NSDictionary *dic23 = @{@"conent":@"何止一辆兰博基尼，简直带了一个团队去的",@"name":@"爱我者光芒万丈84960370",@"time":@"2017-09-02 10:12",@"image":@"c-23"};
    NSDictionary *dic24 = @{@"conent":@"毛的骗保险，这个法拉利加玛莎拉蒂车队，我认识带头的，根本都没有上面说的那么严重，只是法拉利中途换了轮胎，最后都上去了，一共9辆车。网上那些传的关于这个车队的，都是假的，他们每天发很多朋友圈，是15年春天的事情",@"name":@"明远分享给你多一些",@"time":@"2017-09-02 09:44",@"image":@"c-24"};
    NSDictionary *dic25 = @{@"conent":@"骗保险的 知道内幕的赞",@"name":@"用眼睛看清楚",@"time":@"2017-08-29 10:32",@"image":@"c-25"};
    
    //低配
    NSDictionary *dic26 = @{@"conent":@"如果没减配，我肯定来一辆。",@"name":@"无名72751333",@"time":@"2017-08-29 09:12",@"image":@"c-26"};
    NSDictionary *dic27 = @{@"conent":@"柯迪亚克月销8000台的好车，销量已经说明消费者的认可",@"name":@"花懋1192497771",@"time":@"2017-08-29 11:15",@"image":@"c-27"};
    
    //紧凑型
    NSDictionary *dic28 = @{@"conent":@"我最欢的是奔驰AMGA45,我同学买了！",@"name":@"肖世仲",@"time":@"2017-09-02 10:12",@"image":@"c-28"};
    NSDictionary *dic29 = @{@"conent":@"超喜欢a3",@"name":@"小蚂蚁45311209",@"time":@"2017-09-02 12:12",@"image":@"c-29"};
    NSDictionary *dic30 = @{@"conent":@"我买的是标致的308S。对这种两厢版车型没有抵抗力。",@"name":@"失重的太阳",@"time":@"2017-09-04 11:16",@"image":@"c-30"};
    
    
    NSDictionary *dic31 = @{@"conent":@"福克斯",@"name":@"ananloloba",@"time":@"2017-09-02 10:12",@"image":@"c-31"};
    NSDictionary *dic32 = @{@"conent":@"这种小车我最喜欢v40",@"name":@"lovezex",@"time":@"2017-09-01 9:12",@"image":@"c-32"};
    
    //更换7速
    NSDictionary *dic33 = @{@"conent":@"起步价超过15万就是胎死腹中。",@"name":@"Zhouyihua",@"time":@"2017-09-03 11:53",@"image":@"c-33"};
    NSDictionary *dic34 = @{@"conent":@"20万左右",@"name":@"西瓜弹弓商城",@"time":@"2017-09-01 10:12",@"image":@"c-34"};
    NSDictionary *dic35 = @{@"conent":@"外观可以了，怎么内饰……就不能一下弄差不多嘛，非得有一个瘸腿的",@"name":@"2167167651",@"time":@"2017-09-03 10:12",@"image":@"c-35"};
    
    
    NSDictionary *dic36 = @{@"conent":@"侧面的线条还不够流畅",@"name":@"犼牛",@"time":@"2017-09-02 10:12",@"image":@"c-36"};
    NSDictionary *dic37 = @{@"conent":@"中控台十年前一样！",@"name":@"用户5533004629",@"time":@"2017-09-01 11:22",@"image":@"c-36"};
    NSDictionary *dic38 = @{@"conent":@"没有h5好看",@"name":@"凤来龙腾",@"time":@"2017-09-01 7:12",@"image":@"c-38"};
   
    
    //彩票
    NSDictionary *dic39 = @{@"conent":@"他们是还没想好怎么花…",@"name":@"刘龙杰",@"time":@"2017-09-02 10:12",@"image":@"c-39"};
    NSDictionary *dic40 = @{@"conent":@"中国彩票就是黑，",@"name":@"幸福豪情",@"time":@"2017-09-0110:14",@"image":@"c-40"};
    
    
    NSDictionary *dic41 = @{@"conent":@"低调",@"name":@"清风侠10147091",@"time":@"2017-09-01 8:12",@"image":@"c-41"};
    
    //停止印制
    NSDictionary *dic42 = @{@"conent":@"还是把中国所有彩票全停了吧，把外国的阳光彩票引进来。",@"name":@"天与之而不受天必惩之",@"time":@"2017-09-01 12:13",@"image":@"c-42"};
    NSDictionary *dic43 = @{@"conent":@"刮刮乐都是骗人",@"name":@"君子兰147955206",@"time":@"2017-09-01 10:12",@"image":@"c-43"};
    NSDictionary *dic44 = @{@"conent":@"为什么没人查查彩票背后到底有多少黑幕，那么多钱，真正有多少真正做了公益事业？",@"name":@"真空看世界",@"time":@"2017-08-28 5:56",@"image":@"c-44"};
    NSDictionary *dic45 = @{@"conent":@"中福在线……害人无限……",@"name":@"null155568435 ",@"time":@"2017-08-27 5:43",@"image":@"c-45"};
    
    
    NSDictionary *dic46 = @{@"conent":@"全别卖了才好",@"name":@"内蒙海军陆战队",@"time":@"2017-09-02 10:12",@"image":@"c-46"};
    
    
    //男子100元
    NSDictionary *dic47 = @{@"conent":@"为什么是最后一分钟中奖？骗人也弄点新鲜的！又在骗国人买彩票对吧？？大家伙清醒点啊！！不买就对了。合法的骗子骗子骗子！！同样的话说三片！",@"name":@"手机用户54694176372",@"time":@"2017-09-02 11:23",@"image":@"c-47"};
    NSDictionary *dic48 = @{@"conent":@"中国的彩票就是诈骗集团",@"name":@"雨季162052446",@"time":@"2017-09-02 11:14",@"image":@"c-48"};
    NSDictionary *dic49 = @{@"conent":@"谁说中国中不了大奖，有，是内部人员中了，",@"name":@"风华正茂124975994",@"time":@"2017-09-02 11:12",@"image":@"c-49"};
    NSDictionary *dic50 = @{@"conent":@"又骗我在最后一分钟出票。",@"name":@"大魏太祖武皇帝曹操",@"time":@"2017-07-02 10:15",@"image":@"c-50"};
    
    
    NSDictionary *dic51 = @{@"conent":@"不用看不是中国，",@"name":@"最不喜欢那些名字长的",@"time":@"2017-09-02 10:33",@"image":@"c-51"};
    //多彩贵州
    
    NSDictionary *dic52 = @{@"conent":@"彩票是骗人的，吸亿万彩民的血",@"name":@"手机用户59528232169",@"time":@"2017-09-02 11:12",@"image":@"c-52"};
    
    
    if ([_orderId integerValue] == 728078) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    }else if ([_orderId integerValue] == 906060){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic6,dic7,dic8,dic9,dic10, nil];

    }else if ([_orderId integerValue] == 906582){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic11,dic12,dic13,dic14,dic15, nil];

    }else if ([_orderId integerValue] == 112592){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic21,dic22,dic23,dic24,dic25, nil];

    }else if ([_orderId integerValue] == 906581){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic16,dic17,dic18,dic19,dic20, nil];

    }else if ([_orderId integerValue] ==906562){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic26,dic27, nil];

    }else if ([_orderId integerValue] == 905609){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic28,dic29,dic30,dic31,dic32, nil];

    }else if ([_orderId integerValue] == 906578){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic33,dic34,dic35,dic36,dic37,dic38, nil];
    }else if ([_orderId integerValue] == 90){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic39,dic40,dic41, nil];

    }else if ([_orderId integerValue] == 234){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic42,dic43,dic44,dic45,dic46, nil];

    }else if ([_orderId integerValue] == 369){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic47,dic48,dic49,dic50,dic51, nil];

    }else if ([_orderId integerValue] == 18){
        _dataArray = [[NSMutableArray alloc] initWithObjects:dic52, nil];

    }
    
//    NSDictionary *dic53 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic54 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic55 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    
//    NSDictionary *dic56 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic57 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic58 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic59 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic60 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    
//    NSDictionary *dic61 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic62 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic63 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic64 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic65 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    
//    NSDictionary *dic66 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic67 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic68 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic69 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic70 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic71 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic72 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic73 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic74 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic75 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic76 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic77 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic78 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic79 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic80 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic81 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic82 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic83 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic84 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic85 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic86 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic87 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic88 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic89 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic90 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic91 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic92 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic93 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic94 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic95 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic96 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic97 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic98 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic99 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic100 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    
//    NSDictionary *dic101 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic102 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic103 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic104 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
//    NSDictionary *dic105 = @{@"conent":@"",@"name":@"",@"time":@"",@"image":@""};
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
