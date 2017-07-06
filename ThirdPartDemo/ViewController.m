//
//  ViewController.m
//  ThirdPartDemo
//
//  Created by Jackey on 2017/7/3.
//  Copyright © 2017年 com.zhouxi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+UMengPush.h"
#import "AppDelegate+UMSocial.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"分享文字" forState:UIControlStateNormal];
    [btn setBounds:CGRectMake(0, 0, 100, 35)];
    [btn setCenter:self.view.center];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn2 setBackgroundColor:[UIColor orangeColor]];
    [btn2 setTitle:@"新浪登录" forState:UIControlStateNormal];
    [btn2 setBounds:CGRectMake(0, 0, 100, 35)];
    [btn2 setCenter:CGPointMake(self.view.center.x, self.view.center.y + 50)];
    [btn2 addTarget:self action:@selector(sinaLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];
}

- (void)shareAction {
    
    NSLog(@"分享文字");
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app zx_shareTextWithString:@"分享" currentViewController:self callback:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            NSLog(@"分享成功");
        } else {
            
            NSLog(@"分享失败");
        }
    }];
}

- (void)sinaLoginAction {
    
    NSLog(@"新浪登录");
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app zx_getAuthInfoFromSinaWithCurrentViewController:self CallBack:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            
            UMSocialUserInfoResponse *resp = responseObject;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
        } else {
            
            NSLog(@"登录失败: %@", error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
