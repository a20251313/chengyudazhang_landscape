#ifndef __COMMON_INC_IDIOM_WAR_COMMON_DEF_H__
#define __COMMON_INC_IDIOM_WAR_COMMON_DEF_H__

#define IDIOM_WAR_EASYPACKET_LEN                  40960
#define IDIOM_WAR_MAX_JSON_LEN                    30720
#define IDIOM_WAR_MAX_JSON_ARRAY_LEN              10
#define IDIOM_WAR_MIN_USER_ID                     1000000
#define IDIOM_WAR_MAX_LEVEL                       10
#define IDIOM_WAR_VS_WAITING_MAX_TIME             5
#define IDIOM_WAR_VS_MAX_DIFF_LEVEL               2

#define IDIOM_WAR_JSON_PROTOCOL                   "protocol"

#define IDIOM_WAR_LOG_DEFAULT_PATH                "."
#define IDIOM_WAR_LOG_DEFAULT_NAME                "api_idiomwar.log"

typedef enum
{
    eIWPR_RoleSkeletonDemon                       = 21,        
    eIWPR_RoleMonkSha                             = 22,    
    eIWPR_RolePig                                 = 23,
    eIWPR_RoleMonkey                              = 24,
    eIWPR_RoleMonkTang                            = 25,

    // Add before this line.
    eIWPR_RoleEnd
}eIdiomWarPlayerRole;

typedef enum
{
    eIWID_ItemTrash                               = 11,
    eIWID_ItemTimeMachine                         = 12,
    eIWID_ItemHint                                = 13,
    eIWID_ItemInvincible                          = 14,
    eIWID_ItemTransfer                            = 15,

    // Add before this line.
    eIWID_ItemEnd
}eIdiomWarItemDef;

typedef enum
{
    eIDWPR_CorrectAnswer                          = 100,
    eIDWPR_Disconnected                           = 200,
    eIDWPR_WrongAnswer                            = 300,
    eIDWPR_TimeOut                                = 400,
    eIDWPR_Quit                                   = 500,
    eIDWPR_SameIdError                            = 600,
    eIDWPR_ClientBadLogic                         = 700,
    eIDWPR_RoundDraw                              = 800,

    // Add before this line.
    eIDWPR_End
}eIdiomWarPlayResult;


typedef enum
{
    eIWPD_PlayerJoinResult                        = 200,
    eIWPD_StartPlay                               = 210,
    eIWPD_Play                                    = 220,
    eIWPD_UseItem                                 = 230,
    eIWPD_PlayResult                              = 240,    
    eIWPD_Reconnect                               = 250,
    eIWPD_Relogin                                 = 260,

    // Add before this line.
    eIWPD_End
}eIdiomWarProtocolDef;

#endif /* __COMMON_INC_IDIOM_WAR_COMMON_DEF_H__ */
