#ifndef __COMMON_INC_SDSTATUS_H__
#define __COMMON_INC_SDSTATUS_H__

// Standard status.
typedef enum
{
    eSDS_Unknown                                       = 0,

    eSDS_Init                                          = 1,
    eSDS_Idle                                          = 10,

    eSDS_Connecting                                    = 20,
    eSDS_Connected                                     = 21,

    eSDS_Authenticated                                 = 30,

    eSDS_NeedSend                                      = 100,
    eSDS_Sending                                       = 101,
    eSDS_Sent                                          = 102,

    eSDS_NeedRecv                                      = 110,    
    eSDS_Recving                                       = 111,
    eSDS_Recvd                                         = 112,

    eSDS_Processing                                    = 150,
    
    eSDS_NeedWait                                      = 160,
    
    eSDS_Complete                                      = 1000,
    eSDS_Downloaded                                    = 1001,
    eSDS_Uploaded                                      = 1002,

    
    eSDS_Ok                                            = 19999,
    
    // Below statuses are errors.
    eSDS_Error                                         = 20000,
    eSDS_OutOfMemoryError                              = 20001,
    eSDS_RemoteDisconnectedError                       = 20002,
    eSDS_TimeoutError                                  = 20003,
    eSDS_TransLayerPacketHeaderError                   = 20004,
    eSDS_InternalLogicalError                          = 20005,
    eSDS_PacketTooBigError                             = 20006,
    eSDS_AppLogicalError                               = 20007,
    eSDS_FileNotFoundError                             = 20008,
    eSDS_AppProtocolError                              = 20009,
    eSDS_BufferSizeError                               = 20010,
    eSDS_FileNameLenError                              = 20011,
    eSDS_TransLayerSendError                           = 20012,
    eSDS_TransLayerRecvError                           = 20013,
    eSDS_NetworkError                                  = 20014,
    eSDS_PacketError                                   = 20015,
    eSDS_ChallengeError                                = 20016,
    eSDS_UserAlreadyExistError                         = 20017,
    eSDS_UserRegiserError                              = 20018,
    eSDS_ForceDisconnectError                          = 20019,
    eSDS_LBSError                                      = 20020,
    eSDS_SignDataError                                 = 20021,
    eSDS_LoginError                                    = 20022,
    eSDS_UserIdOrPassWDError                           = 20023,    
    eSDS_UserReloginError                              = 20024,
    eSDS_ConnectError                                  = 20025,    
    eSDS_UserBannedError                               = 20026,
    eSDS_UserOfflineError                              = 20027,    
    eSDS_PriceError                                    = 20028,
    eSDS_NotEnoughMoneyError                           = 20029,
    eSDS_PermissionError                               = 20030,    
    eSDS_MaxTimesError                                 = 20031,
    eSDS_NoGiftError                                   = 20032,
    eSDS_VersionTooLowError                            = 20033,
    eSDS_NoDataError                                   = 20034,
    eSDS_ParameterError                                = 20035,
    
    // Database error.
    eSDS_DatabaseInsertError                           = 21000,
    eSDS_DatabaseQueryError                            = 21001,
    eSDS_DatabaseDeleteError                           = 21002,
    eSDS_DatabaseUpdateError                           = 21003,
    eSDS_OCCIError                                     = 21010,

    // Error def for group.
    eSDS_NoGroupError                                  = 22022,
    eSDS_BadUserIdError                                = 22023,
    eSDS_MaxGroupError                                 = 22024,
    eSDS_GroupOwnerError                               = 22025,
    eSDS_GroupMemberError                              = 22026,
    eSDS_GroupMaxMemberError                           = 22027,

    // Error def for game assistant.
    eSDS_NoFreeRoomError                               = 23000,
    eSDS_RoomNoEmptySeatError                          = 23001,
    eSDS_InviteError                                   = 23002,
    eSDS_InviteeRefuse                                 = 23003,

    // Error def for http module
    eSDS_HttpHeaderError                               = 24004,
    eSDS_HttpResponseCodeError                         = 24005,
    eSDS_HttpPacketTooBig                              = 24006,
    eSDS_HttpRequestMethodError                        = 24007,

    // Error def for http api module
    eSDS_HttpApiUploadInfoError                        = 24100,
    eSDS_HttpRechargeVerifyFailed                      = 24101,
    eSDS_HttpRechargeWaitResult                        = 24102,
    eSDS_HttpRechargeFailed                            = 24103,
    eSDS_HttpApiDBError                                = 24104,
    eSDS_HttpRechargeRepeatGetResult                   = 24105,
    eSDS_HttpVerifyExchangeCodeFailed                  = 24106,

    // Error def for broadcast service.
    eSDS_NoRoomError                                   = 25000,
    eSDS_TooManyGuestError                             = 25001,
    eSDS_RoomNotReadyError                             = 25002,
    eSDS_AlreadyKickedError                            = 25003,
    eSDS_AlreadyShutUpError                            = 25004,
    eSDS_UserNotInRoomError                            = 25005,
    eSDS_KickedByAnchorError                           = 25006,
    eSDS_KickedByUserError                             = 25007,
    eSDS_RoomFullError                                 = 25008,
    eSDS_AnchorOfflineError                            = 25009,
    eSDS_TooManyUserError                              = 25010,
    eSDS_AnchorMicOffError                             = 25011,

    // Error def for idiom war.
    eSDS_QuestionVersionTooLowError                    = 26000,
    eSDS_NoSessionError                                = 26001,
    
    //Fatal error. Cannot be recovered.
    eSDS_FatalError                                    = 40000,
    eSDS_FileSystemError                               = 40001
}eSDStatus;

#endif
