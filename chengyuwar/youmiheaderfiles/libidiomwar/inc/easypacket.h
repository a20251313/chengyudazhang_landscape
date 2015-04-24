#ifndef __EASYNET_INC_EASYPACKET_H__
#define __EASYNET_INC_EASYPACKET_H__

#include <assert.h>
#include <iostream>
#include <stdint.h>

using namespace std;


class DataNode;

class EasyPacket
{
  public:
    typedef enum
    {
        // Common Datatype
        eEPDT_Unknown                                          = 0,
        eEPDT_PacketType                                       = 1,
        eEPDT_StringLen                                        = 2,
        eEPDT_String                                           = 3,
        eEPDT_Uint32                                           = 4,
        eEPDT_SDStatus                                         = 5,
        eEPDT_ProtocolId                                       = 6,
        eEPDT_ClientNum                                        = 7,
        eEPDT_AppId                                            = 8,
        eEPDT_PlatformId                                       = 9,
        eEPDT_UserId                                           = 10,
        eEPDT_CompanyId                                        = 11,
        eEPDT_PassWD                                           = 12,
        eEPDT_IPV4Addr                                         = 13,
        eEPDT_Port                                             = 14,
        eEPDT_Latitude                                         = 15,
        eEPDT_Longitude                                        = 16,
        eEPDT_MessageId                                        = 17,
        eEPDT_MessageLen                                       = 18,
        eEPDT_PushType                                         = 19,
        eEPDT_MatchType                                        = 20,
        eEPDT_TextMessage                                      = 21,
        eEPDT_StartTime                                        = 22,
        eEPDT_EndTime                                          = 23,
        eEPDT_CityName                                         = 24,
        eEPDT_GeoHashString                                    = 25,
        eEPDT_NeedSendMsgFlag                                  = 26,
        eEPDT_MessageNum                                       = 27,
        eEPDT_LoginTime                                        = 28,
        eEPDT_Language                                         = 29,
        eEPDT_Time                                             = 30,
        eEPDT_ListSize                                         = 31,
        eEPDT_URL                                              = 32,
        eEPDT_ClientAppId                                      = 33,
        eEPDT_TextMessageType                                  = 34,
        eEPDT_IOSClientToken                                   = 35,
        eEPDT_IOSTokenUpdate                                   = 36,
        eEPDT_ServerId                                         = 37,
        eEPDT_SenderId                                         = 38,
        eEPDT_ReceiverId                                       = 39,
        eEPDT_ClientReqType                                    = 40,
        eEPDT_SenderUserName                                   = 41,
        eEPDT_RecverUserName                                   = 42,
        eEPDT_UserName                                         = 43,
        eEPDT_ListSize2                                        = 44,
        eEPDT_CommonStr1                                       = 45,
        eEPDT_CommonStr2                                       = 46,
        eEPDT_CommonFlag                                       = 47,
        eEPDT_RequestType                                      = 48,
        eEPDT_JobId                                            = 49,
        eEPDT_ArrayIdx                                         = 50,
        eEPDT_TotalItem                                        = 51,
        eEPDT_ImageName                                        = 52,
        eEPDT_BoolFlag                                         = 53,
        eEPDT_Key                                              = 54,
        eEPDT_Value                                            = 55,        
        eEPDT_Name                                             = 56,
        eEPDT_Direction                                        = 57,
        eEPDT_GiftId                                           = 58,
        eEPDT_Animation                                        = 59,
        eEPDT_Unit                                             = 60,
        eEPDT_SrcRole                                          = 61,
        eEPDT_DstRole                                          = 62,
        eEPDT_Money                                            = 63,        
        eEPDT_BoolFlag2                                        = 64,
        eEPDT_Price                                            = 65,
        eEPDT_Speaker                                          = 66,        
        eEPDT_Branch                                           = 67,
        eEPDT_Version                                          = 68,
        eEPDT_Session                                          = 69,
        eEPDT_Role                                             = 70,
        eEPDT_Result                                           = 71,
        eEPDT_Item                                             = 72,
        
        // File data types.
        eEPDT_FileSize                                         = 100,
        eEPDT_FileStream                                       = 101,
        eEPDT_FileStreamSize                                   = 102,
        eEPDT_FileName                                         = 103,
        eEPDT_FileReqType                                      = 104,
        eEPDT_FileType                                         = 105,
        eEPDT_FileExistFlag                                    = 106,

        eEPDT_ChallengeData                                    = 150,
        eEPDT_ChallengeLen                                     = 151,
        eEPDT_SignData                                         = 152,
        eEPDT_SignLen                                          = 153,

        // Monitor service types.
        eEPDT_HostName                                         = 200,
        eEPDT_ServiceDataType                                  = 201,
        eEPDT_ServiceNum                                       = 202,
        eEPDT_ReqServiceTypeItem                               = 203,
        
        eEPDT_MonitorCPUUsage                                  = 220,
        eEPDT_MonitorMemTotal                                  = 221,
        eEPDT_MonitorMemFree                                   = 222,
        eEPDT_MonitorDiskTotal                                 = 223,
        eEPDT_MonitorDiskUsed                                  = 224,
        eEPDT_MonitorDiskFree                                  = 225,
        eEPDT_MonitorDateTime                                  = 226,
        eEPDT_MonitorUploadDataSize                            = 227,
        eEPDT_MonitorDownloadDataSize                          = 228,
        eEPDT_MonitorOnlineUserNum                             = 229,
        eEPDT_MonitorUserReqNum                                = 230,
        eEPDT_MonitorDBBusyConnNum                             = 231,
        eEPDT_MonitorAlive                                     = 232,

        eEPDT_AppTotal                                         = 300,
        eEPDT_AppSequence                                      = 301,
        eEPDT_AppName                                          = 302,
        eEPDT_AppPicName                                       = 303,
        eEPDT_AppDesc                                          = 304,
        eEPDT_AppVersion                                       = 305,
        eEPDT_AppSize                                          = 306,
        eEPDT_ApkName                                          = 307,
        eEPDT_ApkVersionNum                                    = 308,
        eEPDT_AppCategory                                      = 309,
        
        // Multi-chatting group data types.
        eEPDT_ReturnStatus                                     = 400,
        eEPDT_GroupId                                          = 401,
        eEPDT_GroupTitle                                       = 402,
        eEPDT_GroupBulletin                                    = 403,
        eEPDT_GroupMember                                      = 404,
        eEPDT_GroupMemberLevel                                 = 405,
        eEPDT_GroupIdLow                                       = 406,
        eEPDT_GroupIdHigh                                      = 407,
        eEPDT_GroupUserNumber                                  = 408,
        eEPDT_GroupNumber                                      = 409,
        eEPDT_GroupServerAddress                               = 410,
        eEPDT_GroupUserState                                   = 411,
        eEPDT_UserNumber                                       = 412,
        eEPDT_GroupState                                       = 413,
        eEPDT_GroupServerId                                    = 414,
        eEPDT_GroupOwner                                       = 415,
        eEPDT_GCSForClientIPAddr                               = 416,
        eEPDT_GCSForClientPort                                 = 417,

        // Define user data here.
        eEPDT_UserBigHeadPicName                               = 500,
        eEPDT_UserSmallHeadPicName                             = 501,
        eEPDT_UserLevel                                        = 502,
        eEPDT_UserMute                                         = 503,
        eEPDT_UserOnline                                       = 504,
        eEPDT_UserPushOnline                                   = 505,
        eEPDT_UserOnlineNum                                    = 506,
        eEPDT_UserCategory                                     = 507,
        
        // Game assistant service specific item definition.
        eEPDT_RoomId                                           = 800,
        eEPDT_LowRoomId                                        = 801,
        eEPDT_HighRoomId                                       = 802,

        // Broadcast specific item.
        eEPDT_ColorbarNum                                      = 1000,
        eEPDT_CoverImage                                       = 1001,
        eEPDT_Tag                                              = 1002,
        eEPDT_BLSAddr                                          = 1003,
        eEPDT_VUSAddr                                          = 1004,
        eEPDT_VDSAddr                                          = 1005,
        eEPDT_RoomExist                                        = 1006,
        eEPDT_AnchorBLSServerId                                = 1007,
        
        eEPDT_CommonValue1                                     = 2000,
        eEPDT_CommonValue2                                     = 2001,
        eEPDT_CommonValue3                                     = 2002,
        eEPDT_CommonValue4                                     = 2003,
        
        // Add normal data above this line.
        eEPDT_NormalDataTypeEnd                                = 0x7FFFFF,



        //////////////////////////////////////
        // Attention, the following types are list:  //
        /////////////////////////////////////
        
        eEPDT_ListStartIdx                                     = 0x800000,
        eEPDT_FileNameList                                     = 0x800001,
        eEPDT_MessageIdList                                    = 0x800002,
        eEPDT_ServiceTypeList                                  = 0x800003,
        eEPDT_ServiceMonitorList                               = 0x800004,
        eEPDT_AppInfoList                                      = 0x800005,
        eEPDT_MemberList                                       = 0x800006,
        eEPDT_UserIdList                                       = 0x800007,
        eEPDT_UserStateList                                    = 0x800008,
        eEPDT_ServerList                                       = 0x800009,
        eEPDT_ChattingLogList                                  = 0x80000A,
        eEPDT_GroupIdList                                      = 0x80000B,
        eEPDT_RoomList                                         = 0x80000C,
        eEPDT_ServerList2                                      = 0x80000E,
        eEPDT_ADList                                           = 0x80000F,
        eEPDT_JsonList                                         = 0x800010,

        // Add list object above this line.
        eEPDT_ListTypeEnd                                      = 0x9FFFFF
    }eDataType;

    enum
    {
        EASY_PACKET_MAX_ELEM_LEN = 20480
    };

  public:
    EasyPacket();
    ~EasyPacket();

  private:
    EasyPacket(const EasyPacket &);

  private:
    int storeDataType(eDataType type, 
                      unsigned char **buff,
                      unsigned int bufflen,
                      unsigned int &usedlen);

    int storeDataLen(unsigned int datalen, 
                     unsigned char **buff,
                     unsigned int bufflen,
                     unsigned int &usedlen);

    int storeData(const unsigned char * data,
                  unsigned int datalen,
                  unsigned char **buff,
                  unsigned int bufflen,
                  unsigned int &usedlen);

  public:

    int buff2Packet(DataNode *front, const unsigned char * buff, unsigned int bufflen);
    int packet2Buff(DataNode *head, DataNode *tail, unsigned char *buff, unsigned int bufflen, unsigned int &usedlen);

    int addUint32(eDataType type, unsigned int data);
    int getUint32(eDataType type, unsigned int &data);

    int addUint64(eDataType type, uint64_t data);
    int getUint64(eDataType type, uint64_t &data);

    int addString(eDataType type, const unsigned char * data, unsigned int len);
    int getString(eDataType type, unsigned char * data, unsigned int maxlen, unsigned int &readlen);

    // Array objects.
    DataNode * addListObj(eDataType type);
    DataNode * addSubUint32(DataNode* node, eDataType type, unsigned int data);
    DataNode * addSubUint64(DataNode* node, eDataType type, uint64_t data);    
    DataNode * addSubString(DataNode* node, eDataType type, const unsigned char * data, unsigned int len);

    DataNode* getNode(eDataType type);
    DataNode* headNode() {return _head;}
    DataNode* tailNode() {return _tail;}

  private:
    DataNode* _head;
    DataNode* _tail;
    DataNode* _last_insert_node;
};


class DataNode
{
  public:

    typedef enum 
    {
        eDNT_Unknown,
        eDNT_Head,
        eDNT_Tail,
        eDNT_Data,
        eDNT_List
    }eDNType;

  public:

    DataNode();
    DataNode(EasyPacket::eDataType data_type);
    virtual ~DataNode();

  public:

    static DataNode * findNode(DataNode *head, DataNode *tail, EasyPacket::eDataType type);
    static DataNode * findSubNodeByIdx(DataNode *head, DataNode * tail, EasyPacket::eDataType type, unsigned int idx);

  public:
    void pushBackNode(DataNode *node);

  public:
    virtual eDNType nodeType() = 0;
    virtual EasyPacket::eDataType dataType() { return _data_type; }
    virtual unsigned char* data() const { assert(0); return NULL; }
    virtual unsigned int size() const { assert(0); return 0; }
    virtual DataNode * next() { return _next; }
    virtual void setNext(DataNode *n) { _next = n; }


    // Keep complier slience.
    virtual DataNode * headSubNode() { assert(0); return 0; }
    virtual DataNode * tailSubNode() { assert(0); return 0; }
    
    // The following 4 API is for list obj.
    virtual int findUint32(EasyPacket::eDataType type, unsigned int &value);    
    virtual int findUint64(EasyPacket::eDataType type, uint64_t &value);
    virtual int findString(EasyPacket::eDataType type, unsigned int max_len, unsigned char *result, unsigned int &result_len);
    virtual int findUint32ByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int &value);
    virtual int findUint64ByIdx(EasyPacket::eDataType type, unsigned int idx, uint64_t &value);
    virtual int findStringByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int max_len, unsigned char *result, unsigned int &result_len);

  protected:
    DataNode *_next;
    EasyPacket::eDataType _data_type;
};

class HeadDataNode : public DataNode
{
  public:
    HeadDataNode();
    ~HeadDataNode();

  private:
    HeadDataNode(const HeadDataNode &);

  public:
    virtual eDNType nodeType() { return eDNT_Head; }
};

class TailDataNode : public DataNode
{
  public:
    TailDataNode();
    ~TailDataNode();

  private:
    TailDataNode(const TailDataNode&);

  public:
    virtual eDNType nodeType() { return eDNT_Tail; }
    virtual void setNext(DataNode *n) { assert(n==NULL); _next = n; } 
    
};

class NormalDataNode : public DataNode
{
  public:
    NormalDataNode(EasyPacket::eDataType datatype, const unsigned char * data, unsigned int datalen);
    ~NormalDataNode();

  private:
    NormalDataNode(const NormalDataNode &);

  public:
    virtual eDNType nodeType() { return eDNT_Data; }
    virtual unsigned char* data() const { return _data; }
    virtual unsigned int size() const { return _data_size; }

  private:
    unsigned char * _data;
    unsigned int _data_size;
};

class ListObjDataNode : public DataNode
{
  public:
    ListObjDataNode(EasyPacket::eDataType);
    ~ListObjDataNode();

  private:
    ListObjDataNode(const ListObjDataNode &);

  public:
    virtual eDNType nodeType() { return eDNT_List; }

    virtual int findUint32(EasyPacket::eDataType type, unsigned int &value);    
    virtual int findUint64(EasyPacket::eDataType type, uint64_t &value);
    virtual int findString(EasyPacket::eDataType type, unsigned int max_len, unsigned char *result, unsigned int &result_len);

    virtual int findUint32ByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int &value);
    virtual int findUint64ByIdx(EasyPacket::eDataType type, unsigned int idx, uint64_t &value);    
    virtual int findStringByIdx(EasyPacket::eDataType type, unsigned int idx, unsigned int max_len, unsigned char *result, unsigned int &result_len);

    virtual DataNode * headSubNode() { return _sub_head; }
    virtual DataNode * tailSubNode() { return _sub_tail; }

  private:
    DataNode * _sub_head;
    DataNode * _sub_tail;
};

#endif
