//
//  JFRaceManger.m
//  chengyuwar
//
//  Created by ran on 13-12-30.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRaceManger.h"
#import "JFSQLManger.h"
#import "JFDownUrlModel.h"
#import "JFPhaseXmlData.h"

@implementation JFRaceManger
@synthesize delegate;


/*
 case eIWPD_PlayerJoinResult:
 strMsgName = @"BNRPlayerJoinResult";
 break;
 case eIWPD_PlayResult:
 strMsgName = @"BNRPlayerResult";
 break;
 case eIWPD_Play:
 strMsgName = @"BNRPlay";
 break;
 case eIWPD_StartPlay:
 strMsgName = @"BNRStartPlay";
 break;
 case eIWPD_UseItem:
 strMsgName = @"BNRUseItem";
 break;
 case eIWPD_Reconnect:
 strMsgName = @"BNRReconnect";
 break;
 case eIWPD_Relogin:
 strMsgName = @"BNRRelogin";
 break;
*/

-(id)init
{
    self = [super init];
    if (self)
    {
        [self addObserver];
    }
    return self;
}

-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PlayerResult:) name:@"BNRPlayerResult" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Play:) name:@"BNRPlay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlay:) name:@"BNRStartPlay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserItem:) name:@"BNRUseItem" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Reconnect:) name:@"BNRReconnect" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Relogin:) name:@"BNRRelogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuitSuc:) name:@"BNRQuitSuc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(errorOccurWithCode:) name:@"BNRErrorOccur" object:nil];
}

-(void)errorOccurWithCode:(NSNotification*)note
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BNRErrorOccur" object:nil];
    
    int errorcode = [[[note userInfo] valueForKey:@"errorCode"] intValue];
    if (errorcode != eSDS_ConnectError)
    {
        DLOG(@"errorOccurWithCode:%d",errorcode);
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       if(delegate  && [delegate respondsToSelector:@selector(netOccouError:)])
                       {
                           [delegate netOccouError:nil];
                       }
                       
                   });
   
}
-(void)QuitSuc:(NSNotification*)note
{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       if(delegate  && [delegate respondsToSelector:@selector(QuitSuc:)])
                       {
                           [delegate QuitSuc:nil];
                       }
                       
                   });
}

-(void)sendPlayResult:(eIdiomWarPlayResult)result
{
    JFWarProtrol  *pro = [JFWarProtrol shareInstance];
    [pro PlayResult:result];
}

-(void)sendUseProp:(int)propId
{
    JFWarProtrol  *pro = [JFWarProtrol shareInstance];
    [pro userPropItem:propId];
}

-(void)PlayerResult:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(PlayResult:)])
    {
        [delegate PlayResult:[note userInfo]];
    }
    DLOG(@"PlayerResult:%@",[note userInfo]);
}
-(void)Play:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(Play:)])
    {
        [delegate Play:[note userInfo]];
    }
    DLOG(@"Play:%@",[note userInfo]);
    
}
-(void)startPlay:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(startPlay:)])
    {
        [delegate startPlay:[note userInfo]];
    }
    DLOG(@"startPlay:%@",[note userInfo]);
    
}
-(void)UserItem:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(usePropInfo:)])
    {
        [delegate usePropInfo:[note userInfo]];
    }
    DLOG(@"usePropInfo:%@",[note userInfo]);
    
}
-(void)Reconnect:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(ReConnect:)])
    {
        [delegate ReConnect:[note userInfo]];
    }
    DLOG(@"Reconnect:%@",[note userInfo]);
    
}
-(void)Relogin:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(Relogin:)])
    {
        [delegate Relogin:[note userInfo]];
    }
    DLOG(@"Relogin:%@",[note userInfo]);
    
}
-(void)dealloc
{
    m_httpresuset.delegate = nil;
    [m_httpresuset release];
    m_httpresuset = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
-(void)startGame
{
    
    if (!isrightVersion)
    {
        NSMutableArray  *outArray = [NSMutableArray array];
        NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
        BOOL  bneed =  [JFPhaseXmlData checkArrayZip:arrZip outArray:outArray];
        
        if (bneed)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (delegate && [delegate respondsToSelector:@selector(getJoinGameResult:)])
                {
                    [delegate getJoinGameResult:[NSDictionary dictionaryWithObjectsAndKeys:@(eSDS_QuestionVersionTooLowError),@"result", nil]];
                }
                
            });
            
            return;
        }
        
        if ([JFPhaseXmlData getAllIdiomCountFromDownloadFiles] > [JFSQLManger getAllIdiomCountAccordTypeFromSql:JFIdiomTypeRace])
        {
            NSMutableArray  *arrayIdiom = [JFPhaseXmlData getAllIdiomFromDownloadFiles];
            for (JFIdiomModel *model in arrayIdiom)
            {
                
                model.type = JFIdiomTypeRace;
                model.idiomlevelString = @"-1";
                [JFSQLManger insertIdiomTotable:model type:JFIdiomTypeRace];
            }
        }
        
        
    }
    
    int     version = [JFPhaseXmlData phaseXml:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BNRPlayerJoinResult" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StartGameResult:) name:@"BNRPlayerJoinResult" object:nil];
    

    isrightVersion = YES;
    JFWarProtrol *share = [JFWarProtrol shareInstance];
    [share joinGame:[JFLocalPlayer shareInstance] localQuestionVersion:version];
    DLOG(@"startGame");
    
}

-(void)StartGameResult:(NSNotification*)note
{
    
    DLOG(@"StartGameResult:%@",note);
  // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BNRPlayerJoinResult" object:nil];
    if (delegate && [delegate respondsToSelector:@selector(getJoinGameResult:)])
    {
        [delegate getJoinGameResult:[note userInfo]];
    }
    
}

-(void)resetWarProtrol
{
    eSDStatus status =  [[JFWarProtrol shareInstance] resetWar];
    if (status != eSDS_Ok)
    {
        DLOG(@"resetWarProtrol fail");
    }
}


#pragma mark
-(void)requestPersonalInfo:(NSString*)userID
{
    
    if (!m_httpresuset)
    {
        m_httpresuset = [[JFHttpRequsetManger alloc] init];
        m_httpresuset.delegate = self;
    }

    [m_httpresuset startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id", nil] requestURL:@"personal_vs_info"];

}



-(void)getServerResult:(NSDictionary*)dicInfo requsetString:(NSString *)requestString
{
    eSDStatus  status = [[dicInfo valueForKey:@"result"] intValue];
    
    
    DLOG(@"status:%d dicInfo:%@ requestString:%@",status,dicInfo,requestString);
    
    if ([requestString isEqualToString:@"personal_vs_info"])
    {
        if (delegate && [delegate respondsToSelector:@selector(getPersonInfostats:dic:)])
        {
            [delegate getPersonInfostats:status dic:dicInfo];
        }
    }
    
}
-(void)getNetError:(NSString*)statusCode requsetString:(NSString *)requestString
{
    
}




@end
