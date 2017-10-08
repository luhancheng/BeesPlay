//
//  SetupViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/29.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "SetupViewController.h"
#import "SiteOrSwitchViewController.h"
#import "MultilingualViewController.h"
#import "CommonProblemVController.h"
#import "SystemMessageVController.h"
#import "ResetPasswordViewController.h"
@interface SetupViewController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
// 定义数据源
@property (nonatomic, strong) NSArray *dataSource ;
@property (nonatomic, strong) UILabel *nickLabel;
@end

@implementation SetupViewController
-(NSArray *)dataSource {
    if ( !_dataSource) {
        
        _dataSource = @[@[@"我的站点",@"站点切换",@"站点动态"], @[@"多语言"],@[@"常见问题",@"系统留言"],@[@"修改密码"]];
    }
    return _dataSource ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"设置"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    [self initTableView];

}
//tabeView 加载
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, 380)];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = kHexColor(@"efeff4");
    [self setExtraCellLineHidden:_tableView];
    
    UIButton *signOut = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH(20), TOP_BLANNER_HEIGHT+410, kScreenWidth - WIDTH(40), WIDTH(50)) title:@"退出登录" textColor:[UIColor whiteColor] target:self action:@selector(signOut:)];
    signOut.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:signOut];
}

#pragma UITableViewDelegate 代理方法实现
// cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return 0;
    }else {
       return 10;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}
// 点击 cell 实现的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        SiteOrSwitchViewController *siteVC = [SiteOrSwitchViewController new];
        [self goToController:siteVC withAnimation:YES];
     
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        SiteOrSwitchViewController *siteVC = [SiteOrSwitchViewController new];
        siteVC.judgeType = 6;
        [self goToController:siteVC withAnimation:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
       
    }
    
    if (indexPath.section == 1) {
        MultilingualViewController *multilingualVC = [MultilingualViewController new];
        [self goToController:multilingualVC withAnimation:YES];
      
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        CommonProblemVController *cpVC = [CommonProblemVController new];
        [self goToController:cpVC withAnimation:YES];
       
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        SystemMessageVController *systemMessage = [SystemMessageVController new];
        [self goToController:systemMessage withAnimation:YES];
        
    }else if (indexPath.section == 3) {
        ResetPasswordViewController *resetPasswordVC = [ResetPasswordViewController new];
        [self goToController:resetPasswordVC withAnimation:YES];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text =[self.dataSource[0] objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text =[self.dataSource[1] objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2){
        cell.textLabel.text =[self.dataSource[2] objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.dataSource[3] objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signOut:(UIButton *) sender {
    [self doBack];
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
