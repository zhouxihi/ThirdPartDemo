#一般开发中我们比较多使用的三方有友盟推送, 友盟分享, 友盟登录, 微信支付, 支付宝支付, 融云等等...等等...

#光集成一个友盟推送就要好几十行代码, 如果多集成几个AppDelegate就会变得臃肿不堪, 也降低了可读性

#为了解决这个问题, 目前想到以Category的方式给AppDelegate添加新的类别去完成这些三方集成

##当前已经完成友盟推送, 友盟分享, 友盟三方登录的部分

##结构
```objective-c
###AppDelegate + UMengPush --- 友盟推送
###AppDelegate + UMSocial  --- 友盟分享, 友盟Sina/Wechat/QQ登录
###AppDelegate + AppKey    --- 固定位置统一存在各平台秘钥
```

##使用方法

###友盟推送
####首先在AppKey.h中设置好UMessageAppKey
####然后在AppDelegate.m中引入头文件AppDelegate+ UMengPush.h, 或者加入到PCH(推荐)
####在AppDelegate.m中一行代码完成集成
```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.

    // 配置UMessage
    [self nv_configureUMessageWithLaunchOptions:launchOptions];

    return YES;
}
```

###请不要删除AppKey.h中的定义内容
###如果不需要集成某一个SDK, 可以将对应的appKey内容清空, 只保留@""

###友盟分享, 友盟登录
####首先在AppKey.h中设置好UMSocialAppKey 以及 需要继承的第三方平台秘钥
####然后在AppDelegate.m中引入头文件AppDelegate+ UMSocial.h, 或者加入到PCH(推荐)
####在AppDelegate.m中一行代码完成集成
```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // 配置UMSocial
    [self nv_configureUMSocialSDK];

    return YES;
}
```

###Controller中的调用

###发起分享
####首先引入头文件AppDelegate.h, AppDelegate+ UMengPush.h, 或者加入到PCH(推荐)
####分享文字实例
```objective-c
AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

[app zx_shareTextWithString:@"分享" currentViewController:self callback:^(BOOL success, id responseObject, NSError *error) {

if (success) {

    NSLog(@"分享成功");
} else {

    NSLog(@"分享失败");
}
}];
```

###发起登录
####首先引入头文件AppDelegate.h, AppDelegate+ UMSocial, 或者加入到PCH(推荐)
####分享文字实例
```objective-c
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
```

