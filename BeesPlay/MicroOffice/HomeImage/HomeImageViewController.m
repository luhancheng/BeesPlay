//
//  HomeImageViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/12.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "HomeImageViewController.h"
#import "LoginViewController.h"
#import "ClassificationController.h"
#import "TaskSearchController.h"
#import "PYSearch.h"
#import "HomeCollectionViewCell.h"
@interface HomeImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HomeImageViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![Singleton shareSingleton].isLogin) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        //[self.navigationController presentViewController:loginVC animated:NO completion:nil];
        [self goToController:loginVC withAnimation:NO];
       
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUICollectionView];
    [self setButtons];
}
- (void)setupUICollectionView {
   
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; //UICollectionView 是 UITableView加强版.//可以布局出各种展示的效果. 可以以多列展示数据,也可以支持水平滚动.
   
    layout.itemSize = CGSizeMake(100, 100); //1.设置每个item的大小
 
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5);   //2.设置分区的缩进量, 上, 左, 下, 右

    layout.minimumLineSpacing = 20;    //3.设置最小行间距
 
    layout.minimumInteritemSpacing = 10;   //4.设置最小item间距
   
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; //5.设置滑动的方向
    
    layout.headerReferenceSize = CGSizeMake(0, 30);//6.设置页眉的大小
   
    layout.footerReferenceSize = CGSizeMake(0, 40); //7.设置页脚的大小
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    
    collectionView.dataSource = self;//配置数据源对象
  
    collectionView.delegate = self;  //配置代理对象
    
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
    
    [collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"item"];//注册cell

}
#pragma mark - UICollectionViewDataSource
//设置collectionView分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

//设置每个分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 7 : 8;
}
//针对于每一个item返回对应的cell对象, cell重用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.titleLabel.text = @"测试数据";
    return cell;
}
//针对于每个分区的页眉和页脚 返回对应的视图对象, 重用.
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        //页眉
//        UIView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        return headerView;
//    } else {
//        //页脚
//        UIView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
//        return footerView;
//    }
//}


#pragma mark -  UICollectionViewDelegate

//item选中之后触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld, item:%ld", indexPath.section, indexPath.item);
}
#pragma mark - UICollectionViewDelegateFlowLayout

//动态设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? CGSizeMake(100, 100) : CGSizeMake(100, 150);
}
//动态设置每个分区的缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 10, 5);
}
//动态设置每个分区的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//动态设置每个分区的最小item间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//动态设置每个分区的页眉的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 30);
}
//动态设置每个分区的页脚的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 40);
}

#pragma mark - 初始化我的、筛选、搜索按钮

- (void)setButtons {
    UIButton *drawerBtn = [[UIButton alloc] initWithFrame:CGRectMake(13, TOP_BLANNER_HEIGHT-40, 30, 30) imageNames:@[@"抽屉图标@3x",@"抽屉图标@3x"] target:self action:@selector(drawer:)];
    [self.titleBackgroudView addSubview:drawerBtn];
    UIButton *filterBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-43, TOP_BLANNER_HEIGHT-40, 30, 30) imageNames:@[@"filter@2x",@"filter@2x"] target:self action:@selector(clickFilterBtn)];
    [self.titleBackgroudView addSubview:filterBtn]; // 筛选按钮
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectOffset(filterBtn.frame, -43, 0) imageNames:@[@"search@2x",@"search@2x"] target:self action:@selector(clickSearchBtn)];
    [self.titleBackgroudView addSubview:searchBtn]; // 搜索按钮
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 按钮的点击方法
- (void) clickSearchBtn { // 搜索按钮
    TaskSearchController *searchVC = [[TaskSearchController alloc] init];
    [self goToController:searchVC withAnimation:YES];
}

- (void) clickFilterBtn { // 筛选按钮
    ClassificationController *chooseVC = [[ClassificationController alloc] init];
    [self goToController:chooseVC withAnimation:YES];
}

- (void)drawer:(UIButton *)sender {
    DLog(@"抽屉塞选");
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
