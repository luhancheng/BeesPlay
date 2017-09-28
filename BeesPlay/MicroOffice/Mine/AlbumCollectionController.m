//
//  AlbumCollectionController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/26.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "AlbumCollectionController.h"
#import "AlbumCell.h"
#import "AlbumModel.h"
@interface AlbumCollectionController ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageNo;
    UIView *noTaskView; // 空任务时显示view
    double cellHeight;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation AlbumCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userInfo = [BXKJUserInfo getUserInfoFromCache];
    //pageNo = 1;
   _dataArray = [NSMutableArray arrayWithCapacity:0];
    cellHeight = WIDTH(80);
    
    [self initTableView];
    /*
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self refreshHeader];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self refreshFooter];
        [self.tableView.mj_footer endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
*/
}
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, kScreenHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = kHexColor(@"efeff4");
    //_tableView.rowHeight = cellHeight;
    [self.view addSubview:_tableView];
    [self setExtraCellLineHidden:_tableView];
    
    
}

#pragma mark -  UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
   // if (indexPath.section < _dataArray.count) {
        AlbumCell *workCell = [[AlbumCell alloc] init];
      //  [workCell setModel:self.dataArray[indexPath.row]];
        [cell.contentView addSubview:workCell];
    //}
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 刷新
/*
- (void)refreshHeader {
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }
    pageNo = 1;
    [self getTaskListWithPageNum:pageNo];
    
}

- (void)refreshFooter {
    ++pageNo;
    
    [self getTaskListWithPageNum:pageNo];
}
*/
#pragma mark - 数据请求
/*
- (void)getTaskListWithPageNum:(int)pageNum {
    NSString *url = BX_DRP;
    NSString *pageSize = @"10";
    url = [url stringByAppendingFormat:@"/u/wealth/takecash/list.html?v=%@&userId=%@&token=%@&pageNo=%@&pageSize=%@",@"",self.userInfo.userId,[USERDEFAULTS valueForKey:@"token"],[NSString stringWithFormat:@"%d",pageNum],pageSize];
    [HttpManager getJSONDataWithUrl:url success:^(id json) {
        if ([json[@"code"] isEqual:@0]) {
            
            for (NSDictionary *dic in json[@"data"][@"payHistory"]) {
                AlbumModel *model = [AlbumModel modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            //            if (self.dataArray.count < 10 ) {
            //                self.tableView.mj_footer.hidden = YES ;
            //            }else {
            //                self.tableView.mj_footer.hidden = NO ;
            //            }
        }else if ([json[@"code"] isEqual:@14]){
        
            if (IOS8) {
                
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录已失效，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *defult = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    LoginViewController *loginVC = [[LoginViewController alloc ] init];
                    [self goToController:loginVC withAnimation:YES];
                }];
                [alertC addAction:cancle];
                [alertC addAction:defult];
                [self presentViewController:alertC animated:YES completion:nil];
            } else {
                [self showAlertViewWithMessage:@"登陆已失效"];
            }
          
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (pageNum == 1) {
            
            if (_dataArray.count == 0) {
                if (noTaskView) {
                    [self.view addSubview:noTaskView];
                } else {
                    [self showNoTaskView];
                }
            } else {
                if (noTaskView) {
                    [noTaskView removeFromSuperview];
                }
            }
            
            if (_dataArray.count < 10) {
                [_tableView.mj_footer setHidden:YES];
            }else{
                [_tableView.mj_footer setHidden:NO];
            }
        }else {
            if (_dataArray.count == 0) {
                [_tableView.mj_footer setHidden:YES];
            }else{
                [_tableView.mj_footer setHidden:NO];
            }
        }
    } fail:^{
        [self showAlertViewWithMessage:@"网络连接不可用，请检查您的网络"];
    }];
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
