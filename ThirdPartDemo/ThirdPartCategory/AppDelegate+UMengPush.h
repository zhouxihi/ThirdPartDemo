//
//  AppDelegate+UMengPush.h
//  UMengPushDemo
//
//  Created by Jackey on 2017/7/3.
//  Copyright © 2017年 com.zhouxi. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (UMengPush)<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) NSDictionary *userInfo;

/**
 配置友盟推送SDK

 @param launchOptions App launchOptions
 */
- (void)configureUMessageWithLaunchOptions:(NSDictionary *)launchOptions;

/**
 给类别属性赋值

 @param userInfo 推送消息字典
 */
- (void)zx_setUserInfo:(NSDictionary *)userInfo;

/**
 获取类别属性值

 @return 暂存的推送消息
 */
- (NSDictionary *)zx_getUserInfo;

@end
