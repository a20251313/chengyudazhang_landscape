//
//  JFLanchRequest.m
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFLanchRequest.h"

@implementation JFLanchRequest
@synthesize delegate;



-(void)getCommonInfo:(id)Thread
{
    
    if (!m_httpResuest)
    {
        m_httpResuest = [[JFHttpRequsetManger alloc] init];
        m_httpResuest.delegate = self;
    }
    [m_httpResuest startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@(CLIENT_PLATFORM),@"platform",@(APP_VERSION),@"version",@(APP_CUSTOMID),@"customid", nil] requestURL:@"get_common_info"];

}


-(void)getServerResult:(NSDictionary*)dicInfo requsetString:(NSString *)requestString
{
    eSDStatus  status = [[dicInfo valueForKey:@"result"] intValue];
    
    DLOG(@"getServerResult:%d   mangerrequetstring:%@ dicInfo:%@ ",status,requestString,dicInfo);

    if ([requestString isEqualToString:@"get_common_info"])
    {
        if (delegate  && [delegate respondsToSelector:@selector(getCommoninfo:lanchModel:)])
        {
            
            JFLanchModel    *model = [[JFLanchModel alloc] init];
            model.question_db_xml_url = [dicInfo valueForKey:@"question_db_xml_url"];
            model.question_db_xml_ver = [[dicInfo valueForKey:@"question_db_xml_ver"] intValue];
            model.iwvs_server_ip = [dicInfo valueForKey:@"iwvs_server_ip"];
            model.iwvs_server_port = [[dicInfo valueForKey:@"iwvs_server_port"] intValue];
            model.notice = [dicInfo valueForKey:@"notice"];
            model.last_verion_url = [dicInfo valueForKey:@"last_verion_url"];
            model.last_verion = [[dicInfo valueForKey:@"last_verion"] intValue];
            model.ios_share_app_url = [dicInfo valueForKey:@"ios_share_app_url"];
            model.exhibition_type = [[dicInfo valueForKey:@"ad_exhibition_type"] intValue];
            model.scorewallType = [[dicInfo valueForKey:@"ad_score_wall_type"] intValue];
            [delegate getCommoninfo:status lanchModel:model];
            [model release];
        }
        
    }else if ([requestString isEqualToString:@"daily_signed_req"])
    {
        if (delegate  && [delegate respondsToSelector:@selector(getDailySignResult:)])
        {
            [delegate getDailySignResult:status];
        }
    }else if ([requestString isEqualToString:@"get_user_id"])
    {
        if (delegate  && [delegate respondsToSelector:@selector(getUserIDResult:dicInfo:)])
        {
            [delegate getUserIDResult:status dicInfo:dicInfo];
        }
        
    }
}


-(void)getNetError:(NSString*)statusCode requsetString:(NSString *)requestString
{
 
    if (delegate && [delegate respondsToSelector:@selector(getNetError:)])
    {
        [delegate getNetError:0];
    }
    DLOG(@"getNetError:%@ reauestString:%@",statusCode,requestString);
}


-(void)sendDailySignedReq:(int)userID
{
    
    if (!m_httpResuest)
    {
        m_httpResuest = [[JFHttpRequsetManger alloc] init];
        m_httpResuest.delegate = self;
    }
    

    [m_httpResuest startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@(CLIENT_PLATFORM),@"platform",@(userID),@"user_id",@(APP_VERSION),@"version",@(APP_CUSTOMID),@"customid",nil] requestURL:@"daily_signed_req"];

    
}

-(void)getUserID:(NSString*)strGameCenterID
{
    int phone_factory_type = 1111111111;
    NSString *systionVersion = [[UIDevice currentDevice] systemVersion];
    
    if (!m_httpResuest)
    {
        m_httpResuest = [[JFHttpRequsetManger alloc] init];
        m_httpResuest.delegate = self;
    }

    [m_httpResuest startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@(CLIENT_PLATFORM),@"platform",strGameCenterID,@"appstore_key",@"Apple",@"phone_factory",systionVersion,@"phone_sysversion",@(phone_factory_type),@"phone_factory_type",nil] requestURL:@"get_user_id"];

    
}

-(void)dealloc
{
    [m_httpResuest setDelegate:nil];
    [m_httpResuest release];
    m_httpResuest = nil;
    [super dealloc];
}
@end
