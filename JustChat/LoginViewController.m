//
//  ViewController.m
//  JustChat
//
//  Created by admin on 5/23/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import "LoginViewController.h"
#import "EMSDK.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imagePicture;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePicture.layer.cornerRadius = self.imagePicture.bounds.size.width / 2;
    self.imagePicture.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 7;
    self.loginBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 7;
    self.registerBtn.layer.masksToBounds = YES;
    self.navigationItem.title = @"登录";
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loginAction:(id)sender {
    EMError *error = [[EMClient sharedClient]loginWithUsername:self.usernameTF.text password:self.passwordTF.text];
    UIAlertController *altC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [altC addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil]];
    if (error == nil) {
        NSLog(@"登录成功！");
        altC.title = @"登录成功";
    }else{
        altC.title = @"登录失败";
        switch (error.code) {
            case 101:
                altC.message = @"用户名无效";
                break;
            case 102:
                altC.message = @"用户密码无效";
            case 204:
                altC.message = @"用户不存在";
            default:
                break;
        }
        [self presentViewController:altC animated:YES completion:nil];
        NSLog(@"error: %@----code: %u",error.description,error.code);
    }
}
- (IBAction)registerAction:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    RegisterViewController * rVC = [sb instantiateViewControllerWithIdentifier:@"rr"];
//    rVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:rVC animated:YES completion:nil];
    [self.navigationController pushViewController:rVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
