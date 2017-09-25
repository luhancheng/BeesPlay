//
//  MineViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/12.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "MineViewController.h"
#import "PersonMessageEditController.h"
@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
// 定义数据源
@property (nonatomic, strong) NSArray *dataSource ;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UIImageView *topView;
@end

@implementation MineViewController


-(NSArray *)dataSource {
    if ( !_dataSource) {
        
        _dataSource = @[@[@"收藏",@"笔记",@"讨论",@"学习记录",@"设置"]];
    }
    return _dataSource ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self loadTopView];
}
/*
- (void)viewWillAppear:(BOOL)animated {
    
    if (![Singleton shareSingleton].isLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    self.userInfo = [BXKJUserInfo getUserInfoFromCache];
    DLog(@"phone%@",self.userInfo.phone);
    
}
 */
//头像视图
- (void)loadTopView {
    self.view.backgroundColor = [UIColor whiteColor];
    _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WIDTH(150))];
    _topView.image = [UIImage imageNamed:@"Science"];
    [self.view addSubview:_topView];
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-WIDTH(60))/2, _topView.height-(WIDTH(60)/2), WIDTH(60), WIDTH(60))];
    self.headImage.layer.cornerRadius = self.headImage.bounds.size.width/2;
    self.headImage.layer.masksToBounds = YES;
    [self.view addSubview:self.headImage];
    if ([self isBlankString:self.userInfo.avatarImg] == YES) {
        self.headImage.image = [UIImage imageNamed:@"阿呆"];
    }else {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.userInfo.avatarImg]];
    }
   
    self.headImage.userInteractionEnabled = YES;
    //添加轻拍手势,读取相册换照片
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.headImage addGestureRecognizer:tap];
    
    //self.nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImage.bottom+WIDTH(10), kScreenWidth, WIDTH(15))];
    self.nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImage.bottom, kScreenWidth/2+12, WIDTH(12)) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:WIDTH(12)]];
    self.nickLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.nickLabel];
    NSString *nick = [NSString stringWithFormat:@"%@",self.userInfo.nickName];
    if ([self isBlankString:self.userInfo.nickName] == YES) {
        self.nickLabel.text = @"阿呆";
        self.nickLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapNickName = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapNickName:)];
        [self.nickLabel addGestureRecognizer:tapNickName];
        
    } else {
        self.nickLabel.userInteractionEnabled = NO;
        NSString* nickText = [nick stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        self.nickLabel.text = [NSString stringWithFormat:@"%@",nickText];
    }
    UIImageView *penImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.nickLabel.right, self.nickLabel.top+1, self.nickLabel.height-2, self. nickLabel.height-2)];
    penImage.image = [UIImage imageNamed:@"笔"];
    [self.view addSubview:penImage];
}
//tabeView 加载
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WIDTH(200), kScreenWidth, kScreenHeight-WIDTH(200))];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = kHexColor(@"efeff4");
    _tableView.backgroundColor = [UIColor whiteColor];
    [self setExtraCellLineHidden:_tableView];
}


#pragma UITableViewDelegate 代理方法实现
// cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
// 点击 cell 实现的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    ShopPartViewController *shopPart = [ShopPartViewController new];
    AccountSetupViewController *accountVC = [[AccountSetupViewController alloc] init];
    FeedbackViewController *feedBackVC = [[FeedbackViewController alloc] init];
    SettingsViewController *setVC = [SettingsViewController new];
    if (indexPath.section == 0 && indexPath.row == 0) {
        shopPart.backtype = 0;
        [self goToController:shopPart withAnimation:YES];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        shopPart.backtype = 1;
        [self goToController:shopPart withAnimation:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        shopPart.backtype = 2;
        [self goToController:shopPart withAnimation:YES];
    }
    
    if (indexPath.section == 1) {
        
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        [self goToController:feedBackVC withAnimation:YES];
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        [self goToController:setVC withAnimation:YES];
    }
     */
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
    UIImageView *NewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(NewImageView.right+ 10, NewImageView.top , WIDTH(100), NewImageView.height) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17]];
    [cell.contentView addSubview:newLabel];
    [cell.contentView addSubview:NewImageView];
    if (indexPath.section == 0) {
        
        newLabel.text =[self.dataSource[0] objectAtIndex:indexPath.row];
        NewImageView.image = [UIImage imageNamed:[self.dataSource[0] objectAtIndex:indexPath.row]];
    } else if (indexPath.section == 1) {
        newLabel.text =[self.dataSource[1] objectAtIndex:indexPath.row];
        NewImageView.image = [UIImage imageNamed:[self.dataSource[1] objectAtIndex:indexPath.row]];
    } else {
        newLabel.text =[self.dataSource[2] objectAtIndex:indexPath.row];
        NewImageView.image = [UIImage imageNamed:[self.dataSource[2] objectAtIndex:indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    PersonMessageEditController *pmeVC = [[PersonMessageEditController alloc] init];
    [self goToController:pmeVC withAnimation:YES];
    /*
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
     */
}

#pragma mark --UIImagePickerControllerDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self pickerPictureFromCamera]; //拍照
            break;
        case 1:
            [self pickerPictureFromAlbum]; //读取相册
            break;
        default:
            break;
    }
}

//从相册读取
- (void)pickerPictureFromAlbum {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];//初始化图片选择控制器
    [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
    controller.allowsEditing = YES;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [controller setDelegate:self];// 设置代理
    [self presentViewController:controller animated:YES completion:^{
        
    }];//以模态的方式弹出视图
    
}

//拍照
- (void)pickerPictureFromCamera {
    //判断摄像头是否可用
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        return;
    }
    //初始化图片选择控制器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置通过照相来选取照片
    
    imagePicker.allowsEditing = YES; //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//但得到图片或者视频后, 调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info  {
    self.headImage.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(self.headImage.image,nil,nil,nil);
    }
    //对图片大小进行压缩--
    self.headImage.image = [self imageWithImage:self.headImage.image scaledToSize:CGSizeMake(200, 200)];//改变宽高
    
    [self saveImage:self.headImage.image WithName:@"currentImage.png"];
    //获取图片路径
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    
    NSData *imageData = UIImageJPEGRepresentation(self.headImage.image,0.1f);//改变像素(png)
    
    NSString *imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *fileType = @"";
    NSString *url = BX_URL ;
    url = [url stringByAppendingString:@"/user/updateavatar/base64byte.html"];
    NSDictionary *params = @{@"v":@"",@"userId":self.userInfo.userId,@"token":self.userInfo.token,@"baseByte":imageStr,@"fileType":fileType};
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL URLWithString:fullPath] name:@"currentImage.png" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取用户信息
        NSString *userURL = BX_URL;
        userURL = [userURL stringByAppendingString:[NSString stringWithFormat:@"/user/info.html"]];
        NSDictionary *infoParams = @{@"v":@"",@"userId":self.userInfo.userId,@"token":self.userInfo.token};
        [HttpManager postJSONDataWithUrl:userURL params:infoParams succss:^(id json) {
            if ([json[@"code"] isEqual:@0]) {
                [self.headImage sd_setImageWithURL:[NSURL URLWithString:json[@"data"][@"user"][@"avatarImg"]]];
                DLog(@"OKOKOKOKOKO");
                NSDictionary *userDic = json[@"data"][@"user"];
                
                BXKJUserInfo *userinfo = [[BXKJUserInfo alloc] initWithFields:userDic];
                
                [userinfo saveUserInfo];
                
                self.userInfo = [BXKJUserInfo getUserInfoFromCache];
            }
        } fail:^{
            
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//对图片大小进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
    
}

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.01f);//改变像素(png)
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

//修改昵称
- (void)handleTapNickName:(UITapGestureRecognizer *)tapNickName {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"请输入新的昵称，只能修改一次呦" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"昵称" ;
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //数据请求
        NSString *url = BX_URL;
        NSString *nick = [NSString stringWithFormat:@"%@",alertC.textFields[0].text];
        nick = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)nick, nil, nil, kCFStringEncodingUTF8)) ;  // 汉字转换UTF8
        if ([alertC.textFields[0].text isEqualToString:@""]) {
            [self showAlertViewWithMessage:@"昵称不能为空哟！"];
            return ;
        }
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/user/updatenick.html"]];
        
        NSDictionary *params = @{@"v":@"",@"userId":self.userInfo.userId,@"token":self.userInfo.token,@"nick":nick};
        [HttpManager postJSONDataWithUrl:url params:params succss:^(id json) {
            if ([json[@"code"] isEqual:@0]) {
                self.nickLabel.userInteractionEnabled = NO;
                self.nickLabel.text = alertC.textFields[0].text ;
                
                //获取用户信息
                NSString *userURL = BX_URL;
                userURL = [userURL stringByAppendingString:[NSString stringWithFormat:@"/user/info.html"]];
                NSDictionary *infoParams = @{@"v":@"",@"userId":self.userInfo.userId,@"token":self.userInfo.token};
                [HttpManager postJSONDataWithUrl:userURL params:infoParams succss:^(id json) {
                    if ([json[@"code"] isEqual:@0]) {
                        [self.headImage sd_setImageWithURL:[NSURL URLWithString:json[@"data"][@"user"][@"avatarImg"]]];
                        DLog(@"OKOKOKOKOKO");
                        NSDictionary *userDic = json[@"data"][@"user"];
                        
                        BXKJUserInfo *userinfo = [[BXKJUserInfo alloc] initWithFields:userDic];
                        
                        [userinfo saveUserInfo];
                        
                        self.userInfo = [BXKJUserInfo getUserInfoFromCache];
                    }
                } fail:^{
                    
                }];
                
                
            } else if ([json[@"code"] isEqual:@19]){
                [self showAlertViewWithMessage:@"昵称只能修改一次，你已经修改过了哟"];
            }else {
                [self showAlertViewWithMessage:@"修改失败"];
            }
        } fail:^{
            
        }];
    }];
    [alertC addAction:cancle];
    [alertC addAction:defult];
    [self presentViewController:alertC animated:YES completion:nil];
    
}


@end

