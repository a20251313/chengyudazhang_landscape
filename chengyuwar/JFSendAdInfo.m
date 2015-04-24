//
//  JFSendAdInfo.m
//  chengyuwar
//
//  Created by ran on 14-1-14.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFSendAdInfo.h"
#import "AdCommonDef.h"
static JFSendAdInfo  *shareSendAd = nil;

@implementation JFSendAdInfo
+(id)shareInstance
{
    if (!shareSendAd)
    {
        shareSendAd = [[JFSendAdInfo alloc] init];
    }
    return shareSendAd;
}


+(void)sendShowAD:(NSString*)userID adType:(int)adType
{
    JFSendAdInfo  *info = [JFSendAdInfo shareInstance];
    if (info)
    {
        [info sendShowAD:userID adType:adType];
    }
}

-(void)dealloc
{
    m_http.delegate =  nil;
    [m_http release];
    m_http = nil;
    [super dealloc];
}
-(void)sendShowAD:(NSString*)userID  adType:(int)type
{
    if (!m_http)
    {
        m_http = [[JFHttpRequsetManger alloc] init];
        m_http.delegate = self;
    }

    NSDictionary *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id",@(CLIENT_PLATFORM),@"platform",@(APP_VERSION),@"version",@(type),@"ad_supplier_type",nil];
    [m_http startRequestData:dicInfo requestURL:@"ad_show_request"];

    
}

-(void)getServerResult:(NSDictionary*)dicInfo requsetString:(NSString*)requestString
{
    DLOG(@"JFSendAdInfo dicInfo:%@",dicInfo);
}
-(void)getNetError:(NSString*)statusCode requsetString:(NSString*)requestString
{
    DLOG(@"JFSendAdInfo statusCode:%@",statusCode);
}
@end
