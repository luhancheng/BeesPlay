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
#import "SDCycleScrollView.h"
@interface HomeImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SDCycleScrollView *sdcView ;
@property (nonatomic, strong) NSArray *imageData;
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
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    _imageData = imagesURLStrings;
    [self setupUICollectionView];
    [self setButtons];
}
- (void)setupUICollectionView {
   
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, kScreenHeight - TOP_BLANNER_HEIGHT) collectionViewLayout:[UICollectionViewFlowLayout new]];
    
    _collectionView.dataSource = self;//配置数据源对象
  
    _collectionView.delegate = self;  //配置代理对象
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    
    //[_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"item"];//注册cell
     [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
     [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];// 注册页眉
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];              //注册尾视图
}


#pragma mark - UICollectionViewDataSource
//设置collectionView分区的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

//设置每个分区item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 6 : 3;
}
//针对于每一个item返回对应的cell对象, cell重用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
//    cell.titleLabel.text = @"测试数据";
//    return cell;
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath :indexPath];
    for (UIView *view in [cell.contentView subviews])
    {
        [view removeFromSuperview];
    }
    UIImageView  *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width - 20, cell.frame.size.height - 30)];
    backImage.image = [UIImage imageNamed:@"logo"];
    [cell.contentView addSubview:backImage];
    return cell;
}
//针对于每个分区的页眉和页脚 返回对应的视图对象, 重用.
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
      UICollectionReusableView *reusableView = nil;
     if (kind == UICollectionElementKindSectionHeader) {       //头视图
         UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                 withReuseIdentifier:@"UICollectionViewHeader"
                                                                                        forIndexPath:indexPath];
         headView.backgroundColor = [UIColor redColor];
         UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
         titleLabel.textAlignment = NSTextAlignmentLeft;
         titleLabel.text = @"热门专辑";
         [headView addSubview:titleLabel];
         
         UIButton *findMore = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 10, 80, 20) title:@"查看全部" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:13] backgroundImageNames:nil target:self action:@selector(findmore:)];//查看更多
         [headView addSubview:findMore];
         
         if (indexPath.section == 0) {
             if (!self.sdcView) {
                 self.sdcView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight/4 -30) delegate:self placeholderImage:[UIImage imageNamed:@"logo"]];
                 self.sdcView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                 self.sdcView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
                 [headView addSubview:self.sdcView];
                 //         --- 模拟加载延迟
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     self.sdcView.imageURLStringsGroup = _imageData;
                 });
                 
                 /*
                  block监听点击方式
                  
                  self.sdcView.clickItemOperationBlock = ^(NSInteger index) {
                  NSLog(@">>>>>  %ld", (long)index);
                  };
                  
                  */
             }
    
             titleLabel.frame = CGRectMake(10, self.sdcView.bottom + 10, 100, 20);
             findMore.frame = CGRectMake(kScreenWidth - 90, titleLabel.top, 80, 20);
         }else if (indexPath.section == 1) {
         titleLabel.text = @"热播视频";
         }else if (indexPath.section == 2) {
         titleLabel.text = @"热门新闻";
         }
         reusableView = headView;
     }else if (kind == UICollectionElementKindSectionFooter) {    //尾视图
       UICollectionReusableView  *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
         reusableView = footerView;
     }
  
    
    return reusableView;
}


#pragma mark -  UICollectionViewDelegate

//item选中之后触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld, item:%ld", indexPath.section, indexPath.item);
}
#pragma mark - UICollectionViewDelegateFlowLayout

//动态设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? CGSizeMake(100, 100) : CGSizeMake(kScreenWidth, 150);
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
    return section == 0 ? CGSizeMake(0, kScreenHeight/4) : CGSizeMake(0, 30);
}
//动态设置每个分区的页脚的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
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
- (void)findmore:(UIButton *)found {
    DLog(@"查看更多");
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
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
