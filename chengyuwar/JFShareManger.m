//
//  JFShareManger.m
//  chengyuwar
//
//  Created by ran on 13-12-25.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFShareManger.h"
#import "JFLocalPlayer.h"
#import "JFShareSucView.h"
#import "JFAlertView.h"


#define WEIXINAPPID         @"wx267541488a2945f4"
#define SINAAPPID           @"3355604061"
#define TENCENTWEIBOAPPID   @"801465849"



#define SHAREHEAD           @"#成语大战#"
#define SHAREWORD           @"让人抓狂的成语，我有点上瘾了，挑战到底有木有~"
#define SHAREDOWNLOADURL    [[[JFLocalPlayer shareInstance] lanchModel] ios_share_app_url]
static  JFShareManger   *sharemanger = nil;


@implementation JFShareManger
@synthesize shareImage;
@synthesize shareMsg;
@synthesize type;


+(NSString*)storePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"localJFShareManger"];
                          
    //  NSError *error = nil;
    
    /* if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
     [[NSFileManager defaultManager] createFileAtPath:dataPath contents:nil attributes:nil:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
     if (error)
     {
     DLOG(@"error:%@",error);
     }*/
    return dataPath;
}

+(void)shareWithMsg:(NSString*)msg image:(UIImage*)image
{
    JFShareManger   *manger  = [JFShareManger shareInstance];
    manger.shareMsg = @"";
    manger.shareImage = image;
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [sharemanger showShareView];
    }); 
}

+(BOOL)isNeedShowSucAlert
{
    BOOL  bneed = NO;
    NSString    *strStorekey = [NSString stringWithFormat:@"LocalShareCount%@",[[JFLocalPlayer shareInstance] userID]];
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:strStorekey])
    {
        int count = [[[NSUserDefaults standardUserDefaults] valueForKey:strStorekey] intValue];
        if (count > 0)
        {
            bneed = YES;
        }
        
    }
    
    return bneed;
}
+(BOOL)storeLeaveShareCountDelete
{
    NSString    *strStorekey = [NSString stringWithFormat:@"LocalShareCount%@",[[JFLocalPlayer shareInstance] userID]];
    int count = 4;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:strStorekey])
    {
        count = [[[NSUserDefaults standardUserDefaults] valueForKey:strStorekey] intValue];
        count--;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@(count) forKey:strStorekey];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getleaveCount
{
   // return 5;
    int count = 5;
    NSString    *strStorekey = [NSString stringWithFormat:@"LocalShareCount%@",[[JFLocalPlayer shareInstance] userID]];
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:strStorekey])
    {
        count = [[[NSUserDefaults standardUserDefaults] valueForKey:strStorekey] intValue];
    }
    
    if (count < 0)
    {
        count = 0;
    }

    return count;
}


-(void)dealloc
{
    self.shareMsg = nil;
    self.shareMsg = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


+(id)shareInstance
{
    if (!sharemanger)
    {
        sharemanger = [[JFShareManger alloc] init];
    }
    return sharemanger;
}

-(void)shareWithType:(JFShareModelType)Temptype
{
    self.type = Temptype;
    JFShareWordView *view = [[JFShareWordView alloc] initWithFrame:CGRectZero];
    [view updateMsg:self.shareMsg UIImage:self.shareImage];
    view.delegate = self;
    [view show];
    [view release];
}

-(void)showShareView
{
    JFShareView *view = [[JFShareView alloc] initWithLeaveCount:[JFShareManger getleaveCount]];
    view.delegate = self;
    [view show];
    [view release];
}


-(void)shareWeiBoSuc:(NSNotification*)note
{
   
    if ([JFShareManger getleaveCount] > 0)
    {
       
        JFShareSucView  *view = [[JFShareSucView alloc] initWithRewardCount:50];
        [view show];
        [view release];
    }
    [JFShareManger storeLeaveShareCountDelete];
    
    DLOG(@"shareWeiBoSuc:%@",note);
    
}
-(void)shareWeiBoFail:(NSNotification*)note
{
    NSError *error = [note object];
    if (error  && [error isKindOfClass:[NSError class]])
    {
        if ([error code] == -1009)
        {
            JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
            [av show];
            [av release];
        }
    }
    DLOG(@"++++++++++++++++error occur+++++++++++++++++++\nshareWeiBoFail:%@",note);
}

#pragma mark    JFShareWordViewDelegate
-(void)shareWithMsg:(NSString*)strMsg  image:(UIImage*)image
{
    /*
    if (!strMsg || [strMsg isEqualToString:@""])
    {
        strMsg = SHAREWORD;
    }
    strMsg = [NSString stringWithFormat:@"%@%@%@",SHAREHEAD,strMsg,SHAREDOWNLOADURL];
    self.shareMsg = strMsg;
 
    
    NSString    *platom = FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO;
    switch (self.type)
    {
        case JFShareModelTypeSina:
            platom = FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO;
            break;
        case JFShareModelTypeTencent:
           platom = FRONTIA_SOCIAL_SHARE_PLATFORM_QQWEIBO;
            break;
        case JFShareModelTypeWeiXin:
            platom = FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION;
            break;
        case JFShareModelTypePengyouquan:
            platom = FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE;
            break;
        default:
            break;
    }
    
    
    
    FrontiaShare *share = [Frontia getShare];
    [share registerSinaweiboAppId:SINAAPPID];
    [share registerWeixinAppId:WEIXINAPPID];
    [share registerQQAppId:TENCENTWEIBOAPPID];
    
    

    
    
    //授权取消回调函数
    FrontiaShareCancelCallback onCancel = ^()
    {
        [self shareWeiBoFail:nil];
        NSLog(@"OnCancel: share is cancelled");
    };
    
    //授权失败回调函数
    FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage)
    {
        [self shareWeiBoFail:nil];
        NSLog(@"OnFailure: %d  %@", errorCode, errorMessage);
    };
    
    //授权成功回调函数
    FrontiaSingleShareResultCallback onResult = ^()
    {
        [self shareWeiBoSuc:nil];
        NSLog(@"OnResult: share success");
    };
    
    FrontiaShareContent *content=[[FrontiaShareContent alloc] init];
    content.url = SHAREDOWNLOADURL;
    content.title = @"分享";
    content.description = strMsg;
    content.imageObj = image;
    
    


    [share shareWithPlatform:platom content:content supportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape isStatusBarHidden:YES cancelListener:onCancel failureListener:onFailure resultListener:onResult];
    
    
    
    self.shareImage = nil;
    self.shareMsg = nil;*/
    
}
@end
