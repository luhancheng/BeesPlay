//
//  ResourcesViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "ResourcesViewController.h"
#import "ResourceModel.h"
#import "ResourceCell.h"
@interface ResourcesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    double cellHeight;
    
    int _pageNumber;
    UIView *noTaskView; // 空任务时显示view
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
   // self.userInfo = [BXKJUserInfo getUserInfoFromCache];
    cellHeight = WIDTH(80);
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self initTableView];
    [AppUtils setupRefreshHeader:_tableView target:self header:@selector(refreshHeader)];
    [AppUtils setupRefreshFooter:_tableView target:self footer:@selector(refreshFooter)];
    [self.tableView.header beginRefreshing];
}
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.rowHeight = cellHeight;
    
    [self setExtraCellLineHidden:_tableView];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark -  UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    cell.backgroundColor = [UIColor magentaColor];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    ResourceCell *workCell = [[ResourceCell alloc]initWithItem:nil];
    
    [cell.contentView addSubview:workCell];
    
    return cell;
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 刷新

- (void)refreshHeader {
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }
_pageNumber = 0;
    
}

- (void)refreshFooter {
    ++_pageNumber;

}

#pragma mark - 数据请求
- (void)getTaskListWithPageNum:(int)pageNum {

}
- (void)showNoTaskView {
    
    noTaskView = [[UIView alloc] initWithFrame:CGRectMake(_tableView.left, _tableView.top, kScreenWidth,  _tableView.height)];
    [self.view addSubview:noTaskView];
    
    UIImageView *logoPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(100), WIDTH(100))];
    logoPic.center = CGPointMake(noTaskView.center.x, noTaskView.height/3);
    logoPic.image = [UIImage imageNamed:@"空任务@2x"];//还未放置图片
    [noTaskView addSubview:logoPic];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(10, logoPic.bottom+WIDTH(10), kScreenWidth-20, WIDTH(15)) text:@"您好没有任何信息" textColor:kHexColor(@"999999") font:[UIFont systemFontOfSize:WIDTH(15)]];
    nameL.textAlignment = NSTextAlignmentCenter;
    [noTaskView addSubview:nameL];
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
