//
//  JFShareManger.m
//  DrawSelf
//
//  Created by Ran Jingfu on 2/22/14.
//  Copyright (c) 2014 com.jingfu.ran. All rights reserved.
//
//
#import "JFShareManger.h"
#if  UMSOCAIL
#import "UMSocial.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"
#else
#import "WXApi.h"
#import "WeiboApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>

#import <FacebookConnection/ISSFacebookApp.h>
#endif
#define APPLINK     @"https://itunes.apple.com/us/app/feng-kuang-cheng-yu/id908875876?l=zh&ls=1&mt=8"
#define SHAREHEAD   @"#疯狂成语#"
//#define UmengAppkey @"UmengAppkey"


@interface JFShareManger ()<ISSShareViewDelegate>

@end
static JFShareManger    *shareManger = nil;
@implementation JFShareManger


+(id)shareInstance
{
    if (!shareManger)
    {
        shareManger = [[JFShareManger alloc] init];
#if UMSOCAIL
#else
        
        [ShareSDK registerApp:@"5873f8a7ac36"];
        [shareManger initializePlat];
        [shareManger initializePlatForTrusteeship];
    
#endif
    }
    return shareManger;
    
}


+(void)shareWithMsg:(NSString*)strMsg image:(UIImage*)image viewController:(UIViewController*)viewController
{
    [[JFShareManger shareInstance] shareWithMsg:strMsg image:image viewController:viewController];
}


#if UMSOCAIL
-(void)shareWithMsg:(NSString*)strMsg image:(UIImage*)image viewController:(UIViewController*)viewController
{

    strMsg = [NSString stringWithFormat:@"%@ %@ %@",SHAREHEAD,strMsg,APPLINK];
    //如果得到分享完成回调，需要设置delegate为self
    [UMSocialSnsService presentSnsIconSheetView:viewController appKey:UmengAppkey shareText:strMsg shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToEmail,UMShareToSms,UMShareToWechatSession,UMShareToWechatTimeline, nil] delegate:self];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess)
    {
        DLOG(@"didFinishGetUMSocialDataInViewController:%@",response);
    }
}
#else



- (void)initializePlat
{
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"1586810742"
                               appSecret:@"fb6983ef331782d66fb43e4576066a34"
                             redirectUri:@"http://www.sns.whalecloud.com"];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //连接短信分享
    //[ShareSDK connectSMS];
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    /*[ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];*/
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    //    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wxc6d70fb221f3d704"
                           appSecret:@"ca9223f4afc6bb23b3dde31d17b2ab68"
                           wechatCls:[WXApi class]];
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
   /* [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];*/
    
    /**
     连接Facebook应用以使用相关功能，此应用需要引用FacebookConnection.framework
     https://developers.facebook.com上注册应用，并将相关信息填写到以下字段
     **/
 //   [ShareSDK connectFacebookWithAppKey:@"107704292745179"
                            //  appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    
    /**
     连接Twitter应用以使用相关功能，此应用需要引用TwitterConnection.framework
     https://dev.twitter.com上注册应用，并将相关信息填写到以下字段
     **/
   /* [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"
                                redirectUri:@"http://www.sharesdk.cn"];*/
    

    


    
    //连接邮件
   // [ShareSDK connectMail];
    
    //连接打印
   // [ShareSDK connectAirPrint];
    
    //连接拷贝
 //   [ShareSDK connectCopy];
    

    
}

/**
 *	@brief	托管模式下的初始化平台
 */
- (void)initializePlatForTrusteeship
{
    
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
    [ShareSDK importTencentWeiboClass:[WeiboApi class]];
    
    //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
    [ShareSDK importWeChatClass:[WXApi class]];
}


#pragma mark - ButtonHandler


-(void)shareWithMsg:(NSString*)strMsg image:(UIImage*)image viewController:(UIViewController*)viewController
{
    NSString    *content = [NSString stringWithFormat:@"%@  %@",strMsg,APPLINK];
    [self shareAllByimage:image content:content];
}

/**
 *	@brief	分享全部
 *
 *	@param 	sender 	事件对象
 */
- (void)shareAllByimage:(UIImage*)image content:(NSString*)content
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSDate date]]];
    NSData  *data = UIImagePNGRepresentation(image);
    [data writeToFile:dataPath atomically:NO];
    

  
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK imageWithPath:dataPath]
                                                title:@"分享"
                                                  url:APPLINK
                                          description:APPLINK
                                            mediaType:SSPublishContentMediaTypeImage];
    
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    

    //结束定制信息
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    

    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"分享"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:nil
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}






#pragma mark - ISSShareViewDelegate
/*
- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType
{
    
    if ([[UIDevice currentDevice].systemVersion compare:@"7.0"] != NSOrderedAscending)
    {
        UIButton *leftBtn = (UIButton *)viewController.navigationItem.leftBarButtonItem.customView;
        UIButton *rightBtn = (UIButton *)viewController.navigationItem.rightBarButtonItem.customView;
        
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.text = viewController.title;
        label.font = [UIFont boldSystemFontOfSize:18];
        [label sizeToFit];
        
        viewController.navigationItem.titleView = label;
        
        [label release];
    }
    
    if (isPad)
    {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:22];
        viewController.navigationItem.titleView = label;
        label.text = viewController.title;
        [label sizeToFit];
        [label release];
        
        if (UIInterfaceOrientationIsLandscape(viewController.interfaceOrientation))
        {
            [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadLandscapeNavigationBarBG.png"]];
        }
        else
        {
            [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadNavigationBarBG.png"]];
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(viewController.interfaceOrientation))
        {
            if ([[UIDevice currentDevice] isPhone5])
            {
                [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG-568h.png"]];
            }
            else
            {
                [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG.png"]];
            }
        }
        else
        {
            [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];
        }
    }
}

- (void)view:(UIViewController *)viewController autorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation shareType:(ShareType)shareType
{
    if (isPad)
    {
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
        {
            [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadLandscapeNavigationBarBG.png"]];
        }
        else
        {
            [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadNavigationBarBG.png"]];
        }
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
        {
            if ([[UIDevice currentDevice] isPhone5])
            {
                [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG-568h.png"]];
            }
            else
            {
                [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG.png"]];
            }
        }
        else
        {
            [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];
        }
    }
}
 */

#endif
@end
