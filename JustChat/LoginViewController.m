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
#import "MainTabBarController.h"
@interface LoginViewController ()<EMClientDelegate>
@property (strong, nonatomic) IBOutlet UITextField *usernameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imagePicture;
@property (strong, nonatomic) IBOutlet UIButton *autoLoginBtn;
@property (strong, nonatomic) IBOutlet UIButton *savePasswordBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
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
    self.usernameTF.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    self.passwordTF.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    self.savePasswordBtn.selected = [[NSUserDefaults standardUserDefaults]objectForKey:@"isSavePwd"];
    self.autoLoginBtn.selected = [[NSUserDefaults standardUserDefaults]objectForKey:@"isAutoLogin"];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)autoLoginAction:(id)sender {
    if (self.autoLoginBtn.isSelected == YES) {
        self.autoLoginBtn.selected = NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isAutoLogin"];
    }else{
        self.autoLoginBtn.selected = YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isAutoLogin"];
    }
}
- (IBAction)savePasswordAction:(id)sender {
    if (self.savePasswordBtn.isSelected == YES){
        self.savePasswordBtn.selected = NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isSavePwd"];
    }else{
        self.savePasswordBtn.selected = YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isSavePwd"];
    }
}

- (IBAction)loginAction:(id)sender {
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient]loginWithUsername:self.usernameTF.text password:self.passwordTF.text];
        if (!error) {
            [[NSUserDefaults standardUserDefaults]setObject:self.usernameTF.text forKey:@"username"];
            if (self.savePasswordBtn.isSelected == YES) {
                [[NSUserDefaults standardUserDefaults]setObject:self.passwordTF.text forKey:@"password"];
            }
            if (self.autoLoginBtn.isSelected == YES) {
                [[EMClient sharedClient].options setIsAutoLogin:YES];
            }
        }
        UIAlertController *altC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [altC addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil]];
        if (error == nil) {
            NSLog(@"登录成功！");
            altC.title = @"登录成功";
            MainTabBarController *mTBC = [[UIStoryboard storyboardWithName:@"TabBar" bundle:nil]instantiateViewControllerWithIdentifier:@"tab"];
            mTBC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.navigationController presentViewController:mTBC animated:YES completion:nil];
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
}
- (void)didAutoLoginWithError:(EMError *)aError{
    if (!aError) {
        MainTabBarController *mTBC = [[UIStoryboard storyboardWithName:@"TabBar" bundle:nil]instantiateViewControllerWithIdentifier:@"tab"];
        mTBC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.navigationController presentViewController:mTBC animated:YES completion:nil];
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
