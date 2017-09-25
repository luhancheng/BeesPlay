//
//  TaskSearchController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/9/25.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "TaskSearchController.h"
#import "TaskModel.h"
@interface TaskSearchController ()<UITextFieldDelegate>

{
    UITextField *textFld;
    UIButton *cancleBtn;
}
@end

@implementation TaskSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTitleWith:@"BeesPlay电子管理平台"];
    [self addBackButtonWithTitle:@"返回"];
    
    [self addSearchView];
    [self addCenterViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [textFld becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [textFld resignFirstResponder];
}
- (void)addSearchView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, TOP_BLANNER_HEIGHT-35, kScreenWidth-75, 27)];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.layer.cornerRadius = 2;
    bgView.layer.masksToBounds = YES;
    [self.titleBackgroudView addSubview:bgView];
    
    UIImageView *searchPic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3.5, 20, 20)];
    searchPic.image = [UIImage imageNamed:@"搜索_小@2x"];
    [bgView addSubview:searchPic];
    
    
    textFld = [[UITextField alloc] initWithFrame:CGRectMake(searchPic.right+5, 0, bgView.width-30, bgView.height) text:nil placeholder:@"搜索" delegate:self];
    textFld.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textFld.textColor = kHexColor(@"ffffff");
    textFld.returnKeyType = UIReturnKeySearch;
    [bgView addSubview:textFld];
    
    
    //添加取消按钮
    cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgView.right+10, bgView.top, 40, bgView.height) title:@"取消" textColor:kHexColor(@"ffffff") target:self action:@selector(clickCancleBtn)];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.titleBackgroudView addSubview:cancleBtn];
}

- (void)addCenterViews {
    UIImageView *logoPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(100), WIDTH(100))];
    logoPic.center = CGPointMake(self.view.center.x, TOP_BLANNER_HEIGHT+WIDTH(100));
    logoPic.image = [UIImage imageNamed:@"搜索_大@2x"];
    [self.view addSubview:logoPic];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(10, logoPic.bottom+WIDTH(10), kScreenWidth-20, WIDTH(15)) text:@"立即搜索任务编号" textColor:kHexColor(@"999999") font:[UIFont systemFontOfSize:WIDTH(15)]];
    nameL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameL];
}

- (void)clickCancleBtn {
    [self doBack];
}
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self validateNumber:string]) {
        
        NSString *str = nil;
        if (string.length == 0) { // 回删字符串时
            str = [textField.text substringToIndex:textField.text.length-1];
            
            DLog(@"textField.text==%@",textField.text);
        } else {
            str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        
        
        
        DLog(@"taskId===%@",str);
        
        //        if (str.length >= 4) {
        //            [self findTaskById:str];
        //        }
        return YES;
    }
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //    if (textFld.text.length >= 4) {
    [self findTaskById:textFld.text];
    //    }
    return YES;
}

- (BOOL)validateNumber:(NSString *)number { // 匹配字符串是否为数字
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据请求

- (void)findTaskById:(NSString *)idStr {
    
    NSDictionary *params = @{@"taskId":idStr, @"mobileLogin":@"1"};
    DLog(@"findTaskById params===%@",params);
    /*
    [self doPost:@"/projectTask/findTaskById" params:params useJson:YES showProgress:NO];
     */
}

#pragma mark - 数据处理

- (void)handleHttpResponse:(BOOL) cache
{
    NSString *methedName = [[super data] securityStringWithKey:@"methedName"];
    
    if ([methedName isEqualToString:@"/projectTask/findTaskById"]) {
        
        NSDictionary *result = [self.data securityDictionaryWithKey:@"result"];
        /*
        if (result.allValues.count > 0) {
            WBGHomeTaskModel *model = [WBGHomeTaskModel initWith:result];
            WBGHomeDetailController *detailVC = [[WBGHomeDetailController alloc] init];
            detailVC.taskModel = model;
            [self goToController:detailVC withAnimation:YES];
        } else {
            [self.view makeToast:@"未搜索到该任务!"];
        }
         */
    }
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
