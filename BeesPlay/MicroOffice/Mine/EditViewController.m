
//
//  EditViewController.m
//  BeesPlay
//
//  Created by 路与心 on 2017/10/5.
//  Copyright © 2017年 路与心. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()<UITextFieldDelegate,UIAlertViewDelegate,UITextViewDelegate>
@property (nonatomic, strong) UITextField *heading;
@property (nonatomic, strong) UITextView *contentTextView;;
@end

@implementation EditViewController
#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.heading resignFirstResponder];
 
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.heading == textField) {
        [textField resignFirstResponder];
    }
    return true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54, TOP_BLANNER_HEIGHT-44, 44, 44) title:@"发布" textColor:[UIColor orangeColor] target:self action:@selector(addAction:)];
    [self.titleBackgroudView addSubview:sendBtn];
    
    UIButton *closeBtn =[[UIButton alloc] initWithFrame:CGRectMake(10, TOP_BLANNER_HEIGHT-44, 44, 44) title:@"关闭" textColor:[UIColor orangeColor] target:self action:@selector(closeAction:)];
    [self.titleBackgroudView addSubview:closeBtn];
    [self initSubView];
}
- (void)initSubView {
    UILabel *topL = [[UILabel alloc] initWithFrame:CGRectMake(0, TOP_BLANNER_HEIGHT, kScreenWidth, 1)];
    topL.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topL];;
    self.heading = [[UITextField alloc] initWithFrame:CGRectMake(0, topL.bottom, kScreenWidth, TOP_BLANNER_HEIGHT) text:nil placeholder:@"请输入标题" delegate:self];
    self.heading.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.heading];
    UILabel *bottomL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.heading.bottom, kScreenWidth, 1)];
    bottomL.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomL];
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, bottomL.bottom, kScreenWidth, kScreenHeight - bottomL.bottom)];
    self.contentTextView.text = @"请输入正文";
    [self.view addSubview:self.contentTextView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)closeAction:(UIButton *)action {
    [self.navigationController popViewControllerAnimated:YES];
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
