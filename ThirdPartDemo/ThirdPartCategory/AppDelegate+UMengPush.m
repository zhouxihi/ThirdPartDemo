//
//  AppDelegate+UMengPush.m
//  UMengPushDemo
//
//  Created by Jackey on 2017/7/3.
//  Copyright © 2017年 com.zhouxi. All rights reserved.
//

#import "AppDelegate+UMengPush.h"
#import "UMessage.h"

#import <objc/runtime.h>

static char UserInfoKey;

@implementation AppDelegate (UMengPush)

#pragma mark - Configure UMessage SDK

- (void)configureUMessageWithLaunchOptions:(NSDictionary *)launchOptions {
    
    // 设置AppKey & LaunchOptions
    [UMessage startWithAppkey:UMessageAppKey launchOptions:launchOptions];
    
    // 注册
    [UMessage registerForRemoteNotifications];
    
    // 开启Log
    [UMessage setLogEnabled:YES];
    
    // 检查是否为iOS 10以上版本
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
        // 如果检查到时iOS 10以上版本则必须执行以下操作
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate                  = self;
        UNAuthorizationOptions types10   = \
            UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
        
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                
                // 点击允许
                // 这里可以添加一些自己的逻辑
            } else {
                
                // 点击不允许
                // 这里可以添加一些自己的逻辑
            }
        }];
        
    }
}

#pragma mark - UMessage Delegate Methods

- (void)application:(UIApplication *)application
            didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    
    // 关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
    [self zx_setUserInfo:userInfo];
    
    // 定制自己的弹出框
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:userInfo[@"aps"][@"alert"]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

// iOS 10新增: 处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        
        //应用处于前台时的本地推送接受
    }
    
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
            didReceiveNotificationResponse:(UNNotificationResponse *)response
                withCompletionHandler:(void (^)())completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        
        //应用处于后台时的本地推送接受
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [UMessage sendClickReportForRemoteNotification:[self zx_getUserInfo]];
}

- (void)zx_setUserInfo:(NSDictionary *)userInfo {
    
    objc_setAssociatedObject(self, &UserInfoKey, userInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)zx_getUserInfo {
    
    if (objc_getAssociatedObject(self, &UserInfoKey)) {
        
        return objc_getAssociatedObject(self, &UserInfoKey);
    } else {
        
        return nil;
    }
}

@end
