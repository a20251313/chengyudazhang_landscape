#ifndef __EASYNET_INC_EASYNET_H__
#define __EASYNET_INC_EASYNET_H__

#include "datachannel.h"
#include "sdstatus.h"
#include "mytranslayer.h"
#include "easypacket.h"

class EasyNet
{
public:

    typedef enum
    {
        eENPT_Unknown                       = 0,

        eENPT_HeartBeat                     = 10,

        // Define Packet Type Here.
        eENPT_FCS_ReqFile                   = 100,
        eENPT_FSC_RspFile                   = 101,
        eENPT_FCS_ReqUploadFile             = 102,
        eENPT_FSC_RspUploadFile             = 103,
        eENPT_FCS_ReqDeleteFile             = 104,
        eENPT_FCS_RspDeleteFile             = 105,

        eENPT_BP_Hello                      = 150,
        eENPT_BP_Question                   = 151,
        eENPT_BP_Authorized                 = 152,
        eENPT_BP_ReportClientNum            = 153,

        eENPT_BA_Hello                      = 200,
        eENPT_BA_Question                   = 201,
        eENPT_BA_Authorized                 = 202,
        eENPT_BA_ReqIPAndPort               = 203,

        eENPT_PA_Hello                      = 300,
        eENPT_PA_Question                   = 301,
        eENPT_PA_Authorized                 = 302,
        eENPT_PA_PushTextMsg                = 303,
        eENPT_PA_PushFileMsg                = 304,
        eENPT_PA_ForceDisconnect            = 305,

        eENPT_CP_Hello                      = 400,
        eENPT_CP_Authorized                 = 401,
        eENPT_CP_ReportOnlineUser           = 402,
        eENPT_CP_PushTextMsg                = 403,
        eENPT_CP_ReqRegister                = 404,
        eENPT_CP_ReportDisconnect           = 405,
        eENPT_CP_ReportPushMessageStatus    = 406,
        eENPT_CP_ForceUserDisconnect        = 407,

        eENPT_CO_Hello                      = 500,
        eENPT_CO_Authorized                 = 501,
        eENPT_CO_PushTextMsg                = 502,
        eENPT_CO_DeletePushMsg              = 503,
        eENPT_CO_OnlineUserReport           = 504,
        eENPT_CO_UserStateUpdate            = 505,
        eENPT_CO_ReportUserSetOffline       = 506,
        
        eENPT_HM_Hello                      = 600,
        eENPT_HM_Authorized                 = 601,
        eENPT_HM_ReqServiceType             = 602,
        eENPT_HM_ResServiceType             = 603,
        eENPT_HM_ReqMonitorData             = 604,
        eENPT_HM_ResMonitorData             = 605,
        
        eENPT_SH_ReqMonitorData             = 606,
        eENPT_SH_ResMonitorData             = 607,

        eENPT_RA_Hello                      = 1000,
        eENPT_RA_Question                   = 1001,
        eENPT_RA_Authorized                 = 1002,
        eENPT_RA_AppUpdateTime              = 1003,
        eENPT_RA_AppInfo                    = 1004,
        eENPT_RA_DownloadAppSuccess         = 1005,

        eENPT_TA_Hello                      = 1100,
        eENPT_TA_TokenUpdateAck             = 1101,
        eENPT_TA_BadgeResetAck              = 1102,
        
        eENPT_VC_Hello                      = 1200,
        eENPT_VC_Authorized                 = 1201,
        eENPT_VC_GetGCSLoad                 = 1202,
        
        eENPT_SC_Hello                      = 1300,
        eENPT_SC_Authorized                 = 1301,
        eENPT_SC_GetUserOnlineStatusList    = 1302,
        eENPT_SC_ReportUserStatusList       = 1303,
        eENPT_SC_StartupOK                  = 1304,        
        eENPT_SC_UpdateUserStatus           = 1305,
        eENPT_SC_GetUserStatus              = 1306,           
        eENPT_SC_GetGroupUserStatus         = 1307,                   
        eENPT_SC_ReqCreateGroup             = 1308,
        eENPT_SC_ReqDelGroup                = 1309,
        eENPT_SC_ReqAddUserToGroup          = 1310,
        eENPT_SC_ReqDelUserFromGroup        = 1311,
        eENPT_SC_ReqUpdateGroupInfo         = 1312,
        eENPT_SC_RegisterGCS                = 1313,
        eENPT_SC_RemoveGCS                  = 1314,

        eENPT_SS_Hello                      = 1400,
        eENPT_SS_Authorized                 = 1401,
        eENPT_SS_RemoteGroupMsg             = 1402,
        eENPT_SS_LocalGroupMsg              = 1403,

        eENPT_GV_Hello                      = 1500,
        eENPT_GV_Authorized                 = 1501,
        eENPT_GV_RoomOnlineUses             = 1502,
        eENPT_GV_UserStatusChange           = 1503,

        eENPT_IO_Hello                      = 1600,
        eENPT_IO_Authorized                 = 1601,
        eENPT_IO_PushTextMsg                = 1602,

        eENPT_BV_Hello                      = 1700,
        eENPT_BV_Authorized                 = 1701,
        eENPT_BV_FileAddrUpdate             = 1702,
        eENPT_BV_UDPAddrUpdate              = 1703,

        eENPT_BF_Hello                      = 1800,
        eENPT_BF_Authorized                 = 1801,

        eENPT_BU_Hello                      = 1900,
        eENPT_BU_Authorized                 = 1901,
        
        eENPT_OV_Hello                      = 2000,
        eENPT_OV_Authorized                 = 2001,
        eENPT_OV_OSSReportOnlineUser        = 2002,
        eENPT_OV_VGSReportOnlineUser        = 2003,
        eENPT_OV_VGSReqUserOnlineState      = 2004,
        eENPT_OV_VGSUserOnlineStateUpdate   = 2005,
        eENPT_OV_OSSUserOnlineStateUpdate   = 2006,
        eENPT_OV_VGSReqDeliveryMsg          = 2007,
        eENPT_OV_VGSReqFriendState          = 2008, /* Used when user login. */

        eENPT_VV_Hello                      = 2100,
        eENPT_VV_Authorized                 = 2101,
        eENPT_VV_Request                    = 2102,
		
        eENPT_BBL_Hello                     = 3000,
        eENPT_BBL_Authorized                = 3001,
        eENPT_BBL_ServeRoomUpdate           = 3002,
        
        eENPT_BRS_Hello                     = 3200,
        eENPT_BRS_Authorized                = 3201,
        eENPT_BRS_SyncRoomState             = 3202,
        eENPT_BRS_UpdateHostOnline          = 3204,
        eENPT_BRS_ShutdownRoom              = 3205,

        eENPT_BBC_Hello                     = 3300,
        eENPT_BBC_Authorized                = 3301,
        eENPT_BBC_GetRoomList               = 3302,
        eENPT_BBC_HostGetRoomInfo           = 3303,
        eENPT_BBC_GetAD                     = 3304,

        eENPT_BLL_Hello                     = 3500,
        eENPT_BLL_Authorized                = 3501,
        eENPT_BLL_RoomMessage               = 3502,
        eENPT_BLL_SendGift                  = 3503,
        eENPT_BLL_TakeChair                 = 3504,
        eENPT_BLL_RoomMemberShutUp          = 3505,
        eENPT_BLL_ColorBar                  = 3506,
        eENPT_BLL_ChairInfoUpdate           = 3507,
        eENPT_BLL_GetMicrophone             = 3508,
        eENPT_BLL_GetMicrophoneResult       = 3509,
        eENPT_BLL_GiveUpMicrophone          = 3510,
        eENPT_BLL_GiveUpMicrophoneResult    = 3511,
        eENPT_BLL_MicrophoneData            = 3512,
        eENPT_BLL_ReqMicrophoneUserList     = 3513,
        eENPT_BLL_RspMicrophoneUserList     = 3514,
        eENPT_BLL_BroadcastMessage          = 3515,
        eENPT_BLL_AnchorInfoUpdate          = 3516,
        eENPT_BLL_HongBao                   = 3517,
        
        eENPT_BRL_Hello                     = 3600,
        eENPT_BRL_Authorized                = 3601,
        eENPT_BRL_SyncAllRoom               = 3602,
        eENPT_BRL_BLSReportOnlineUser       = 3603,
        eENPT_BRL_RoomUserStateUpdate       = 3604,
        eENPT_BRL_RoomAnchorStateUpdate     = 3605,
        eENPT_BRL_SyncRoom                  = 3606,
        eENPT_BRL_KickUser                  = 3607,
        eENPT_BRL_RLConnDisconnect          = 3608,
        eENPT_BRL_RoomShutdown              = 3609,

        eENPT_IV_Hello                      = 20000,
        eENPT_IV_Authorized                 = 20001,
        eENPT_IV_ReportOnlinePlayer         = 20002,

        eENPT_IWVC_Hello                    = 20000,
        eENPT_IWVC_Authorized               = 20001,
        eENPT_IWVC_Json                     = 21002,
        eENPT_IWVC_PlayResult               = 21003,
        eENPT_IWVC_UseItem                  = 21004,

        // Add before this line.
        eFNPT_End
    }eENPacketType;

public:

    EasyNet(DataChannel *remote, unsigned int maxbuffsize);
    ~EasyNet();

public:
    
    eSDStatus sendPacket(EasyPacket *packet);
    eSDStatus sending();    
    eSDStatus getPacket(EasyPacket *packet);
    eSDStatus recvPacket();


private:

    unsigned int          _max_buff_size;
    MyTransLayer*         _trans;
    DataChannel*          _remote;
};

#endif
