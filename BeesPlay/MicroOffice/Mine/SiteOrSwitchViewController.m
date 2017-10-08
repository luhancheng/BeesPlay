//
//  SiteOrSwitchViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/29.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "SiteOrSwitchViewController.h"
#import "SiteOrSwitchModel.h"
#import "SiteOrSwitchCell.h"
@interface SiteOrSwitchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    double cellHeight;
    UIView *noTaskView; // 空任务时显示view
    
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation SiteOrSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.judgeType == 6) {
        [self initTitleWith:@"站点切换"];
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54, TOP_BLANNER_HEIGHT-44, 44, 44) imageNames:@[@"垃圾桶",@"垃圾桶"] target:self action:@selector(delete:)];
        [self.titleBackgroudView addSubview:deleteBtn];
    }else {
        [self initTitleWith:@"我的站点"];
    }
    
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    cellHeight = WIDTH(80);
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self initTableView];
    
    [AppUtils setupRefreshHeader:_tableView target:self header:@selector(refreshHeader)];
    [AppUtils setupRefreshFooter:_tableView target:self footer:@selector(refreshFooter)];
    [self.tableView.mj_header beginRefreshing];

}
- (void)initTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, SCREEN_HEIGHT- TOP_BLANNER_HEIGHT) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.rowHeight = cellHeight;
    
    [self setExtraCellLineHidden:_tableView];
    
    [self.view addSubview:_tableView];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    //cell.backgroundColor = [UIColor magentaColor];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    SiteOrSwitchCell *workCell = [[SiteOrSwitchCell alloc]initWithItem:nil];
    
    [cell.contentView addSubview:workCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    
}



#pragma mark - 刷新

- (void)refreshHeader {
    
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
    }
    
}

- (void)refreshFooter {
    
    
}

#pragma mark - 数据请求

- (void)getWorkListWithPageNum:(int)pageNum type:(NSString *)type {
    

    
    
}





- (void)showNoTaskView {
    
    noTaskView = [[UIView alloc] initWithFrame:CGRectMake(0, WIDTH(50), kScreenWidth,  WIDTH(200))];
    [self.view addSubview:noTaskView];
    
    UIImageView *logoPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(100), WIDTH(100))];
    logoPic.center = CGPointMake(noTaskView.center.x, WIDTH(50));
    logoPic.image = [UIImage imageNamed:@"空任务@2x"];
    [noTaskView addSubview:logoPic];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(10, logoPic.bottom+WIDTH(10), kScreenWidth-20, WIDTH(15)) text:@"您好没有收到任务" textColor:kHexColor(@"999999") font:[UIFont systemFontOfSize:WIDTH(15)]];
    nameL.textAlignment = NSTextAlignmentCenter;
    [noTaskView addSubview:nameL];
}


// 去除UITableViewStylePlain类型的粘性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 12;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delete:(id)sender {
    DLog(@"删除");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
