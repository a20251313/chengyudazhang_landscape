//
//  JFRaceReq.m
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRaceReq.h"
#import "JFPhaseXmlData.h"
#import "JFSQLManger.h"
#import "JFDownUrlModel.h"

@implementation JFRaceReq
@synthesize delegate;


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [JFWarProtrol shareDealloc];
    m_httpResuest.delegate = nil;
    [m_httpResuest release];
    m_httpResuest = nil;
    [super dealloc];
}


-(void)getCommonInfo:(id)Thread
{
    
    if (!m_httpResuest)
    {
        m_httpResuest = [[JFHttpRequsetManger alloc] init];
        m_httpResuest.delegate = self;
    }
    [m_httpResuest startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@(CLIENT_PLATFORM),@"platform",@(APP_VERSION),@"version",@(APP_CUSTOMID),@"customid", nil] requestURL:@"get_common_info"];
    
}

-(void)requestOnlineNumber:(NSString*)userID
{
    
    if (!m_httpResuest)
    {
        m_httpResuest = [[JFHttpRequsetManger alloc] init];
        m_httpResuest.delegate = self;
    }

    [m_httpResuest startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id", nil] requestURL:@"get_online_num"];

}

-(void)requestPersonalInfo:(NSString*)userID
{
    
    if (!m_httpResuest)
    {
        m_httpResuest = [[JFHttpRequsetManger alloc] init];
        m_httpResuest.delegate = self;
    }

    [m_httpResuest startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id", nil] requestURL:@"personal_vs_info"];

}

-(void)getServerResult:(NSDictionary*)dicInfo requsetString:(NSString *)requestString
{
    eSDStatus  status = [[dicInfo valueForKey:@"result"] intValue];
    
    
    DLOG(@"status:%d dicInfo:%@ requestString:%@",status,dicInfo,requestString);
    
    if ([requestString isEqualToString:@"get_online_num"])
    {
        if (delegate && [delegate respondsToSelector:@selector(getOnlineNumber:number:)])
        {
            [delegate getOnlineNumber:status number:[[dicInfo valueForKey:@"online_num"] intValue]];
        }
    }else if ([requestString isEqualToString:@"personal_vs_info"])
    {
        if (delegate && [delegate respondsToSelector:@selector(getPersionalInfo:info:)])
        {
            [delegate getPersionalInfo:status info:dicInfo];
        }
    }else if([requestString isEqualToString:@"get_common_info"])
    {
        if (delegate  && [delegate respondsToSelector:@selector(getCommonInfoInRace:LanchModel:)])
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
            [delegate getCommonInfoInRace:status LanchModel:model];
            [model release];
        }
        
    }
    
}
-(void)getNetError:(NSString*)statusCode requsetString:(NSString *)requestString
{
    if (delegate && [delegate respondsToSelector:@selector(getNetErrorOccur:)])
    {
        [delegate getNetErrorOccur:statusCode];
    }
    
}

-(BOOL)checkHasSameModel:(JFIdiomModel*)Tempmodel inarray:(NSMutableArray*)array
{
    for (JFIdiomModel  *temp in array)
    {
        if (temp.index == Tempmodel.index && Tempmodel.packageIndex == temp.packageIndex)
        {
            return YES;
        }
    }
    return NO;
}


-(void)resetWarProtrol
{
    eSDStatus status =  [[JFWarProtrol shareInstance] resetWar];
    if (status != eSDS_Ok)
    {
        DLOG(@"resetWarProtrol fail");
    }
}
-(void)startGame
{
    
    int     version = [JFPhaseXmlData phaseXml:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BNRPlayerJoinResult" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StartGameResult:) name:@"BNRPlayerJoinResult" object:nil];
    JFWarProtrol *share = [JFWarProtrol shareInstance];
    [share joinGame:[JFLocalPlayer shareInstance] localQuestionVersion:version];
    DLOG(@"startGame");
    
}

-(void)StartGameResult:(NSNotification*)note
{
    
    DLOG(@"StartGameResult:%@",note);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BNRPlayerJoinResult" object:nil];
    if (delegate && [delegate respondsToSelector:@selector(getStartGameResult:)])
    {
        [delegate getStartGameResult:[note userInfo]];
    }
    
}
@end
