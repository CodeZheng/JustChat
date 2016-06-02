//
//  RegisterViewController.m
//  JustChat
//
//  Created by admin on 5/24/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import "RegisterViewController.h"
#import "EMSDK.h"
@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerBtn.layer.cornerRadius = 7;
    self.registerBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 7;
    self.cancelBtn.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)registerAction:(id)sender {
    EMError *error = [[EMClient sharedClient]registerWithUsername:self.usernameTF.text password:self.pwdTF.text];
    UIAlertController *altC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (error == nil) {
        NSLog(@"注册成功！");
        altC.title = @"注册成功！";
        [altC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }]];
    }else{
        NSLog(@"注册失败");
        altC.title = @"注册失败！";
        switch (error.code) {
            case 203:
                altC.message = @"用户已存在";
                break;
            case 208:
                altC.message = @"用户注册失败";
            default:
                break;
        }
        [altC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
    }
    [self presentViewController:altC animated:YES completion:nil];

}
- (IBAction)cancelAction:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
