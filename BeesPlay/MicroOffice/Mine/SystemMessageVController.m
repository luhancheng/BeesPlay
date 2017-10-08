//
//  SystemMessageVController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/10/5.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "SystemMessageVController.h"
#import "EditViewController.h"
@interface SystemMessageVController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
// 定义数据源
@property (nonatomic, strong) NSArray *dataSource ;
@end

@implementation SystemMessageVController
-(NSArray *)dataSource {
    if ( !_dataSource) {
        
        _dataSource = @[@[@"什么时候更新版本?",@"增加直播功能好了?"]];
    }
    return _dataSource ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"系统留言"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54, TOP_BLANNER_HEIGHT-44, 44, 44) title:@"➕" textColor:[UIColor lightGrayColor] target:self action:@selector(addAction:)];
    [self.titleBackgroudView addSubview:addBtn];
    [self initTableView];
}
//tabeView 加载
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, kScreenHeight-TOP_BLANNER_HEIGHT)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self setExtraCellLineHidden:_tableView];
}
#pragma UITableViewDelegate 代理方法实现
// cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


// 点击 cell 实现的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
      
    }
}
#pragma UITableViewDataSource 代理方法实现

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    //cell.textLabel.text =[self.dataSource[0] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.dataSource[0] objectAtIndex:indexPath.row];
    UILabel *headerL = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 5, 10)];
    headerL.backgroundColor = [UIColor orangeColor];
    [cell.contentView addSubview:headerL];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addAction:(UIButton *) sender {
    EditViewController *editVC = [EditViewController new];
    [self goToController:editVC withAnimation:YES];
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
