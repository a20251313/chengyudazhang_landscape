//
//  JFWarProtrol.m
//  chengyuwar
//
//  Created by ran on 13-12-30.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFWarProtrol.h"

#import "JSONKit.h"
#define MAXJOSNARRAY        10

static  JFWarProtrol    *protrolWar = nil;
@implementation JFWarProtrol
@synthesize warstatus;
@synthesize delegate;

+(id)shareInstance
{
    if (!protrolWar)
    {
        protrolWar = [[JFWarProtrol alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
      //  NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"didididididiididi"];
        [protrolWar configLogPath:YES filePath:documentsDirectory];
        DLOG(@"documentsDirectory:%@",documentsDirectory);
    }
    return protrolWar;
}
+(void)shareDealloc
{
    if (protrolWar)
    {
        [protrolWar release];
        protrolWar = nil;
    }
}
-(id)init
{
    self = [super init];
    if (self)
    {
        eSDStatus   status = IdiomWarInit();
        if (status != eSDS_Ok)
        {
            DLOG(@"IdiomWarInit fail:%d",status);
        }
        
        m_bIsQuit = NO;
        m_arrayJobs = [[NSMutableArray alloc] init];
        m_lock = [[NSLock alloc] init];
        m_getDataThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        [m_getDataThread start];
    }
    return self;
}


-(void)dealloc
{
    IdiomWarDeinit();
    [m_getDataThread release];
    m_getDataThread = nil;
    [m_arrayJobs release];
    m_arrayJobs = nil;
    [m_lock release];
    m_lock = nil;
    
    free(json_array);
    json_array = NULL;
    [super dealloc];
}


-(void)joinGame:(JFLocalPlayer*)player localQuestionVersion:(int)version
{
    NSDictionary    *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:player.userID,@"userID",player.nickName,@"nickName",@(version),@"questionver",@(APP_VERSION),@"APP_VERSION",@(CLIENT_PLATFORM),@"platform",@(player.roleModel.roleType),@"roleType",player.lanchModel.iwvs_server_ip,@"IP",@(player.lanchModel.iwvs_server_port),@"port",@(JFWarProtrolJobTypeJoinGame),@"protrol", nil];
    [self addJobToList:dicInfo];
}

-(void)PlayResult:(eIdiomWarPlayResult)result
{
    NSDictionary    *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(result),@"result",@(JFWarProtrolJobTypePlayResult),@"protrol", nil];
    [self addJobToList:dicInfo];
    
    if (result == eIDWPR_Quit)
    {
        m_bIsQuit = YES;
    }
}

-(void)userPropItem:(int)propType
{
    NSDictionary    *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(propType),@"propType",@(JFWarProtrolJobTypeUserItem),@"protrol", nil];
    [self addJobToList:dicInfo];
    
}


-(void)addJobToList:(NSDictionary*)dicInfo
{
    
    [m_lock lock];
    [m_arrayJobs addObject:dicInfo];
    [m_lock unlock];
}
-(eSDStatus)handleJobs:(NSDictionary*)dicInfo
{
    eSDStatus   status = eSDS_Ok;
    int  jobType = [[dicInfo valueForKey:@"protrol"] intValue];
    switch (jobType)
    {
        case JFWarProtrolJobTypeJoinGame:
        {
            uint32_t userID = [[dicInfo valueForKey:@"userID"] intValue];
            const char *nickName = [[dicInfo valueForKey:@"nickName"] UTF8String];
            uint32_t questionVersion = [[dicInfo valueForKey:@"questionver"] intValue];
            uint32_t appver = [[dicInfo valueForKey:@"APP_VERSION"] intValue];
            int platForm = [[dicInfo valueForKey:@"platform"] intValue];
            uint32_t roleID = [[dicInfo valueForKey:@"roleType"] intValue];
            const char *IP = [[dicInfo valueForKey:@"IP"] UTF8String];
            uint16_t port = [[dicInfo valueForKey:@"port"] intValue];
            status =  IdiomWarJoinGame(userID, nickName, questionVersion, appver, (eClientPlatform)platForm, (eIdiomWarPlayerRole)roleID, IP, port);
            // status = IdiomWarJoinGame(userID, nickName, questionVersion, appver, platForm, roleID, IP, port);
        }
            break;
        case JFWarProtrolJobTypePlayResult:
        {
            int relust = [[dicInfo valueForKey:@"result"] intValue];
            status =  IdiomWarPlayResult((eIdiomWarPlayResult)relust);
        }
            break;
        case JFWarProtrolJobTypeUserItem:
        {
            int propType = [[dicInfo valueForKey:@"propType"] intValue];
            DLOG(@"propType:%d",propType);
            status = IdiomWarUseItem((eIdiomWarItemDef)propType);
        }
            break;
            
        default:
            break;
    }
    
    if (status != eSDS_Ok)
    {
        DLOG(@"addJobToList occur error:%d",status);
    }
    
    self.warstatus = status;
    return self.warstatus;
}


-(void)configLogPath:(BOOL)isOnScreen  filePath:(NSString*)filePath
{
    IdiomWarConfigLog(isOnScreen,[filePath UTF8String],NULL, 0);
}


-(eSDStatus)resetWar
{
    eSDStatus   status = IdiomWarReset();
    if (status != eSDS_Ok)
    {
        DLOG(@"resetWar call fail:%d",status);
    }
    return status;
}

-(eSDStatus)handleJobs
{
    [m_lock lock];
    eSDStatus status = eSDS_Ok;
    if ([m_arrayJobs count])
    {
        status = [self handleJobs:[m_arrayJobs objectAtIndex:0]];
        [m_arrayJobs removeObjectAtIndex:0];
    }
    
    [m_lock unlock];
    return status;
}

-(void)run
{
    json_array = (char**) malloc(IDIOM_WAR_MAX_JSON_ARRAY_LEN * sizeof(char*));
    // (char **)malloc(IDIOM_WAR_MAX_JSON_LEN);
    for (int i = 0; i != IDIOM_WAR_MAX_JSON_ARRAY_LEN; ++i)
    {
        json_array[i] = (char *)malloc(IDIOM_WAR_MAX_JSON_LEN);
    }
  
    while (1)
    {
        [self handleJobs];
        [self getJsonArray];
        [NSThread sleepForTimeInterval:0.05];
    }
    
}


-(void)getJsonArray
{
    uint32_t json_num = 0;
    
    for (int i = 0; i != IDIOM_WAR_MAX_JSON_ARRAY_LEN; ++i)
    {
        memset(json_array[i], 0, IDIOM_WAR_MAX_JSON_LEN);
    }
    
    eSDStatus status =   IdiomWarGetJson(json_array, &json_num);
    if (status > eSDS_Ok)
    {
        DLOG(@"IdiomWarGetJson geterror:%d",status);
        
    }
    
    eSDStatus cb_status = IdiomWarGetLibStatus();
    
    
    if (m_bIsQuit)
    {
        DLOG(@"m_bIsQuit:%d cb_status:%d",m_bIsQuit,cb_status);
        if (cb_status == eSDS_Complete || cb_status > eSDS_Ok)
        {
            
            m_bIsQuit = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BNRQuitSuc" object:self userInfo:nil];
        }
    }
    
   // DLOG(@"getJsonArray status:%d",cb_status);
    if (cb_status > eSDS_Ok)
    {
        DLOG(@"getJsonArray status unsuc:%d",cb_status);
        if (cb_status == eSDS_ConnectError)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BNRErrorOccur" object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@(cb_status),@"errorCode",nil]];
        }
        
    }
    self.warstatus = cb_status;
    for (int i = 0; i < json_num; i++)
    {
        
        NSString *jsonString = [NSString stringWithCString:json_array[i] encoding:NSUTF8StringEncoding];
        [self performSelectorOnMainThread:@selector(parseJSONString:) withObject:jsonString waitUntilDone:YES];
    }
    
}

-(void)parseJSONString:(NSString*)josnString
{
    NSDictionary *dic = [josnString objectFromJSONString];
    int jobType = [[dic objectForKey:@"protocol"] intValue];
    NSString    *strMsgName = nil;
    switch (jobType)
    {
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
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:strMsgName object:dic userInfo:dic];
  //  DLOG(@"\nparseJSONString:%@ \ndic:%@",josnString,dic);
}

@end
