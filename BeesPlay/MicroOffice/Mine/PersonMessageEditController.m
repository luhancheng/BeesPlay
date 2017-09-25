
//
//  PersonMessageEditController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/25.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "PersonMessageEditController.h"

@interface PersonMessageEditController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UITextField *account;
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *age;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womenBtn;
@end

@implementation PersonMessageEditController
#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.account resignFirstResponder];
    [self.name resignFirstResponder];
    [self.age  resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.account == textField|| self.name == textField || self.age == textField ) {
        [textField resignFirstResponder];
    }
    return true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"个人资料编辑"];
    self.titleBackgroudView.backgroundColor = rgb(255, 255, 255);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButtonWithTitle:@"返回"];
    [self initSubView];
  
}
- (void)initSubView {
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54, TOP_BLANNER_HEIGHT-44, 44, 44) title:@"保存" textColor:[UIColor orangeColor] target:self action:@selector(save:)];
    [self.titleBackgroudView addSubview:saveBtn];
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH(20), self.titleBackgroudView.bottom + WIDTH(20), WIDTH(40), WIDTH(40))];
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
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.headImage.right - WIDTH(10), self.headImage.bottom-WIDTH(10), WIDTH(10), WIDTH(10))];
    phoneImage.image = [UIImage imageNamed:@"相机"];
    [self.view addSubview:phoneImage];
    UILabel *oneL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImage.bottom + WIDTH(20), kScreenWidth, 7)];
    oneL.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:oneL];
    UILabel *accountL = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(15), oneL.bottom + WIDTH(20), WIDTH(60), WIDTH(20)) text:@"用户名"];
    [self.view addSubview:accountL];
    self.account = [[UITextField alloc] initWithFrame:CGRectMake(accountL.right +WIDTH(20), accountL.top , kScreenWidth-accountL.right - WIDTH(20), accountL.height) text:nil placeholder:@"阿呆" delegate:self];
    self.account.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.account];

    for (int i = 1; i< 4; i++) {
        UILabel *hengxianL = [[UILabel alloc] initWithFrame:CGRectMake(0, oneL.bottom + i *WIDTH(60), kScreenWidth, 1)];
        hengxianL.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:hengxianL];
        if (i ==1) {
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(accountL.left, hengxianL.bottom + WIDTH(20), WIDTH(60), WIDTH(20)) text:@"姓名"];
            [self.view addSubview:nameL];
            self.name = [[UITextField alloc] initWithFrame:CGRectMake(nameL.right+WIDTH(20), nameL.top, kScreenWidth - nameL.right - WIDTH(20), nameL.height) text:nil placeholder:@"刘二" delegate:self];
            self.name.borderStyle = UITextBorderStyleNone;
            [self.view addSubview:self.name];
        } else if (i == 2) {
            UILabel *sexL = [[UILabel alloc] initWithFrame:CGRectMake(accountL.left, hengxianL.bottom + WIDTH(20), WIDTH(60), WIDTH(20)) text:@"性别"];
            [self.view addSubview:sexL];
            self.manBtn = [[UIButton alloc] initWithFrame:CGRectMake(sexL.right + WIDTH(20), sexL.top, sexL.height, sexL.height) imageNames:@[@"选中@2x",@"选中@2x"] target:self action:@selector(hoosePayType:)];
            [self.view addSubview:self.manBtn];
            UILabel *manL = [[UILabel alloc] initWithFrame:CGRectMake(self.manBtn.right, self.manBtn.top, self.manBtn.width, self.manBtn.height) text:@"男"];
            [self.view addSubview:manL];
            self.womenBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.manBtn.right*2, self.manBtn.top, self.manBtn.width, self.manBtn.height) imageNames:@[@"未选中@2x",@"未选中@2x"] target:self action:@selector(hoosePayType:)];
            [self.view addSubview:self.womenBtn];
            UILabel *womenL = [[UILabel alloc] initWithFrame:CGRectMake(self.womenBtn.right, self.womenBtn.top, self.womenBtn.width, self.womenBtn.height) text:@"女"];
            [self.view addSubview:womenL];
            
        } else if (i == 3) {
            UILabel *ageL = [[UILabel alloc] initWithFrame:CGRectMake(accountL.left, hengxianL.bottom + WIDTH(20), WIDTH(60), WIDTH(20)) text:@"年龄"];
            [self.view addSubview:ageL];
            self.age = [[UITextField alloc] initWithFrame:CGRectMake(ageL.right+WIDTH(20), ageL.top, kScreenWidth - ageL.right - WIDTH(20), ageL.height) text:nil placeholder:@"年龄" delegate:self];
            self.age.borderStyle = UITextBorderStyleNone;
            [self.view addSubview:self.age];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
  
     UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
     [actionSheet showInView:self.view];
   
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





#pragma mark = 男女性别选择
- (void)hoosePayType:(UIButton *) sender {
    DLog(@"hahahahhahahahha");
    if (sender == self.manBtn) {
        [self.manBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [self.womenBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }else if (sender == self.womenBtn){
        [self.womenBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [self.manBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
}



- (void)save:(UIButton *)sender {
    DLog(@"保存了");
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
