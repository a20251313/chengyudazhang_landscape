//
//  JFWarProtrol.h
//  chengyuwar
//
//  Created by ran on 13-12-30.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "sdstatus.h"
#include "api_idiomwar.h"
#include "idiom_war_common_def.h"
#include "clientplatform.h"
#import "JFLocalPlayer.h"

@protocol JFWarProtrolDelegate <NSObject>

@optional
-(void)getResultDicInfo:(NSDictionary*)dicInfo;
@end
typedef enum
{
    JFWarProtrolJobTypeInit,
    JFWarProtrolJobTypeReset,
    JFWarProtrolJobTypeConfigLog,
    JFWarProtrolJobTypeJoinGame,
    JFWarProtrolJobTypePlayResult,
    JFWarProtrolJobTypeUserItem
    
}JFWarProtrolJobType;
@interface JFWarProtrol : NSObject
{
    NSThread        *m_getDataThread;
    NSMutableArray  *m_arrayJobs;
    char           **json_array;
    NSLock          *m_lock;

    id<JFWarProtrolDelegate>    delegate;
    
    BOOL            m_bIsQuit;
    
}

@property(nonatomic,assign)id<JFWarProtrolDelegate>    delegate;
@property(nonatomic)eSDStatus   warstatus;



-(eSDStatus)resetWar;
-(void)configLogPath:(BOOL)isOnScreen  filePath:(NSString*)filePath;
-(void)userPropItem:(int)propType;
-(void)PlayResult:(eIdiomWarPlayResult)result;
-(void)joinGame:(JFLocalPlayer*)player localQuestionVersion:(int)version;


+(id)shareInstance;
+(void)shareDealloc;
@end
