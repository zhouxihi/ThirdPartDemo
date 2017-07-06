//
//  AppDelegate+UMSocial.h
//  ThirdPartDemo
//
//  Created by Jackey on 2017/7/4.
//  Copyright © 2017年 com.zhouxi. All rights reserved.
//
//  如果使用demo中的SDK文件, 记得要添加SQLite3.tbd
//  并记得配置URL Scheme & LSApplicationQueriesSchemes

#import "AppDelegate.h"

#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

typedef void(^UMSocialCallBack)(BOOL success, id responseObject, NSError *error);

@interface AppDelegate (UMSocial)

/**
 初始化友盟分享 (推荐方法, 在AppKey.h中配置各项秘钥)
 */
- (void)zx_configureUMSocialSDK;

/**
 单一只初始化友盟分享, 此方法不会去配置微信/QQ/新浪等分享组件

 @param appKey 秘钥
 */
- (void)zx_configuerUMSocialSDKWithAppKey:(NSString *)appKey;

/**
 单一只配置微信分享 (推荐使用- (void)zx_configureUMSocialSDK;方法统一配置)

 @param appKey Wechat appKey
 @param appSecret Wechat appSecret
 @param redirectURL Wechat redirect URL
 */
- (void)zx_configureWechatShareWithAppKey:(NSString *)appKey
                                appSecret:(NSString *)appSecret
                              redirectURL:(NSString *)redirectURL;

/**
 单一只配置QQ分享 (推荐使用- (void)zx_configureUMSocialSDK;方法统一配置)

 @param appKey QQ appKey
 @param appSecret QQ appSecrect (一般传nil)
 @param redirectURL QQ redirect URL
 */
- (void)zx_configureQQShareWithAppKey:(NSString *)appKey
                            appSecret:(NSString *)appSecret
                          redirectURL:(NSString *)redirectURL;

/**
 单一只配置QQ分享 (推荐使用- (void)zx_configureUMSocialSDK;方法统一配置)

 @param appKey Sina appKey
 @param appSecrect Sina app
 @param redirectURL Sina redirect URL
 */
- (void)zx_configureSinaShareWithAppKey:(NSString *)appKey
                             appSecrect:(NSString *)appSecrect
                            redirectURL:(NSString *)redirectURL;

/**
 分享文本

 @param text 要分享的文本
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_shareTextWithString:(NSString *)text
         currentViewController:(UIViewController *)currentVC
                      callback:(UMSocialCallBack)callback;

/**
 分享图片

 @param image 要分享的图片
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_shareImageWithImage:(UIImage *)image
                     thumImage:(UIImage *)thumImage
         currentViewController:(UIViewController *)currentVC
                      callback:(UMSocialCallBack)callback;

/**
 分享图文

 @param text 要分享的文字
 @param image 要分享的图片
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_shareTextWithString:(NSString *)text
                      andImage:(UIImage *)image
                     thumImage:(UIImage *)thumImage
         currentViewController:(UIViewController *)currentVC
                      callback:(UMSocialCallBack)callback;


/**
 分享网页

 @param url 要分享的网页地址
 @param title 标题
 @param description 描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_shareWebPageWithURLStr:(NSString *)url
                            title:(NSString *)title
                      description:(NSString *)description
                        thumImage:(UIImage *)thumImage
            currentViewController:(UIViewController *)currentVC
                         callback:(UMSocialCallBack)callback;

/**
 分享音乐

 @param musicURL 音乐的url
 @param title 标题
 @param description 描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_shareMusicWithURLStr:(NSString *)musicURL
                          title:(NSString *)title
                    description:(NSString *)description
                      thumImage:(UIImage *)thumImage
          currentViewController:(UIViewController *)currentVC
                       callback:(UMSocialCallBack)callback;

/**
 分享视频

 @param videoURL 视频的url
 @param title 标题
 @param description 描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_shareVideoWithURLStr:(NSString *)videoURL
                          title:(NSString *)title
                    description:(NSString *)description
                      thumImage:(UIImage *)thumImage
          currentViewController:(UIViewController *)currentVC
                       callback:(UMSocialCallBack)callback;

/**
 分享微信小程序

 @param programPath 小程序页面路径
 @param webPageURL 兼容网页地址
 @param userName 用户名
 @param title 小程序标题
 @param description 小程序内容描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)zx_WeichatMiniProgramWithPath:(NSString *)programPath
                           webPageURL:(NSString *)webPageURL
                             userName:(NSString *)userName
                                title:(NSString *)title
                          description:(NSString *)description
                            thumImage:(UIImage *)thumImage
                currentViewController:(UIViewController *)currentVC
                             callback:(UMSocialCallBack)callback;

/**
 拉取新浪登录授权信息

 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 
 */
- (void)zx_getAuthInfoFromSinaWithCurrentViewController:(UIViewController *)currentViewController
                                               CallBack:(UMSocialCallBack)callback;

/**
 拉取微信登录授权信息

 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 */
- (void)zx_getAuthInfoFromWechatWithCurrentViewController:(UIViewController *)currentViewController
                                                 CallBack:(UMSocialCallBack)callback;

/**
 拉取QQ登录授权信息
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 */
- (void)zx_getAuthInfoFromQQWithCurrentViewController:(UIViewController *)currentViewController
                                             CallBack:(UMSocialCallBack)callback;

@end
